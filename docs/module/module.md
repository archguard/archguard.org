---
layout: default
title: Modules
nav_order: 5
has_children: true
permalink: /modules
---

{: .no_toc .text-delta }

1. 目录
   {:toc}

所有的 Scanner 都以 Jar 包 + CLI 的方式来提供服务，使用的框架是：clikt，语言是：Kotlin。

## Scanner 执行过程

主要过程上：

1. Backend 根据不同上下文，调用不同的 xxxScannerTool。
2. xxxScannerTool 下载 jar，再将 jar 复制到目标目录
3. 执行对应的 scanner.jar，生成 SQL 数据，并注入到数据库中。

### 1. Backend 调用 Scanner

在 ArchGuard Backend 中是通过调用 Jar 包的方式，来调用相关的 Scanner。

Backend 是通过 `ScannerManager` 来寻找系统中的所有 Scanner：

```kotlin
@Component
class ScannerManager(@Autowired private val scanners: List<Scanner>) {
    fun execute(context: ScanContext) {
        val WORKER_THREAD_POOL = Executors.newFixedThreadPool(4)
        val callables: List<Callable<Unit>> = scanners.map { s ->
            Callable {
                try {
                    if (s.canScan(context)) {
                        s.scan(context)
                    }
                } catch (e: Exception) {
                    log.error("failed to scan {}", s.javaClass.simpleName, e)
                }
            }
        }

        WORKER_THREAD_POOL.invokeAll(callables)
    }
}
```

随后，通过构建的 `ScanContext` 来分析什么情况下使用哪些 Scanner。如 `SourceCodeScanner` 的条件是：

```kotlin
@Service
class SourceCodeScanner: Scanner {
    override fun getScannerName(): String {
        return "SourceCodeScanner"
    }

    override fun canScan(context: ScanContext): Boolean {
        return context.language.lowercase() != "jvm"
    }

    override fun scan(context: ScanContext) {
        SourceCodeTool(context.workspace, context.systemId, context.language, context.dbUrl, context.codePath, context.logStream).also { it.analyse() }
    }
}
```

随后，直接调用对应的 ScannerTool。

### 2. ScannerTool 调用 Jar

Scanner 调用 scanner.jar 时，一般是分为三步的：

```
fun analyse() {
  prepareTool()

  val cmd = mutableListOf(
      "java",
      "-jar",
      "-Ddburl=$dbUrl?useSSL=false",
      "diff_changes.jar",
      "--path=.",
      "--branch=$branch",
      "--system-id=$systemId",
      "--language=${language.lowercase()}"
  )

  cmd.addAll(this.additionArguments)

  scan(cmd)
}

private fun prepareTool() {
  val jarExist = checkIfExistInLocal()
  if (jarExist) {
      copyIntoSystemRoot()
  } else {
      download()
  }
}
```

PS：其中的 `$dbUrl` 是从 Spring 的 properties 中读取对应的数据库 URL、用户名和密码生成的，传递给目标 scanner，以向这个数据库表注入数据。

即：

1. 准备工具。先检查本地是否有对应的工具，有的话直接复制到目标目录，没有的话 GitHub 下载。
2. 生成 Command 命令。
3. 执行对应的 Command 命令。

### 3. Scanner 过程：Sourcecode 示例

如下所示，每个 [Scanner](https://github.com/archguard/archguard) 都使用 `clikt` 框架编写，都以 `Runner.kts` 作为入口。

执行 Scanner 时，一般会分为这几步：

1. 执行对应的分析 Task，分成一个目标数据。
2. 构建一个 Repository，如 `ContainerRepository` 用于将目标数据结构，转换为 SQL 字符串，即调用：SqlGenerator 来生成。
3. 随后清理数据，并将数据存入数据库中。

存储过程中下所述：

```kotlin
 private fun storeDatabase(tables: Array<String>, systemId: String) {
     store.disableForeignCheck()
     store.initConnectionPool()
     logger.info("========================================================")
     val phaser = Phaser(1)
     deleteByTables(tables, phaser, systemId)
     phaser.arriveAndAwaitAdvance()
     logger.info("============ system {} clean db is done ==============", systemId)
     saveByTables(tables, phaser)
     phaser.arriveAndAwaitAdvance()
     logger.info("============ system {} insert db is done ==============", systemId)
     updateByTables(tables, phaser)
     phaser.arriveAndAwaitAdvance()
     logger.info("============ system {} update db is done ==============", systemId)
     logger.info("========================================================")
     store.enableForeignCheck()
 }
```

## Scanner Download

Scanner 下载过程：

1. 从 GitHub 的 release 下载对应的版本到应用的运行目录。
   - 在本地时，则与后端代码同级（即和 build.gradle.kts 同级）
   - 在镜像内，则与 /home/spring/app.jar 同级
2. 将 Scanner 从应用目录，拷贝到代码仓库的临时目录

## Scanner **调试**

Scanner 的调试即可以与 backend 一起，也可以到目标项目的目录中：

1. 与 backend 一起。将 jar 包复制到代码中，与 `build.gradle.kts` 同级，并修改为与 `xxxScannerTool` 相同的版本，即可运行扫描工具进行扫描。
2. 目标项目。将 jar 包复制到将要构建的项目（workdir，即从 system_info 表中查询）目录，按不同类型的应用和参数执行。其中 DBUrl 和 systemId 为必填 。

与 backend 放置时示例如下：

```
├── CHANGELOG.md
├── DesigniteJava.jar
├── LICENSE
├── README.md
├── build.gradle.kts
├── diff_changes-1.4.5-all.jar
├── docker-compose.yml
├── docs
├── install.sh
├── scan_git-1.4.3-all.jar
├── scan_sourcecode-1.4.3-all.jar
├── scan_sourcecode-1.4.5-all.jar
├── settings.gradle.kts
└── src
```

### Scanner Git

CLI 参数：

```
Options:
  --branch TEXT     git repository branch
  --after TEXT      scanner only scan commits after this timestamp
  --path TEXT       local path
  --repo-id TEXT    repo id
  --system-id TEXT  system id
  --language TEXT   language
  --loc TEXT        scan loc
```

CLI 示例：

```
java "-Ddburl=jdbc:mysql://localhost:3306/archguard?user=root&password=&useSSL=false" -jar scan_git-1.2.4-all.jar --branch=dev --path=. --system-id=5
```

### Scanner SourceCode

CLI 参数：

```
Options:
  --path TEXT       local path
  --api-only        only scan api
  --system-id TEXT  system id
  --language TEXT   langauge: Java, Kotlin, TypeScript, CSharp, Python, Golang
```

CLI 示例：

```
java "-Ddburl=jdbc:mysql://localhost:3306/archguard?user=root&password=&useSSL=false" -jar scan_sourcecode-1.4.3-all.jar --path=. --language=kotlin --system-id=10
```

### Diff Changes 

CLI 参数：

```
Options:
  --branch TEXT     git repository branch
  --since TEXT      since specific revision
  --until TEXT      util specific revision
  --path TEXT       local path
  --system-id TEXT  system id
  --language TEXT   language
```

CLI 示例：

```
java "-Ddburl=jdbc:mysql://localhost:3306/archguard?user=root&password=&useSSL=false" -jar diff_changes-1.4.3-all.jar --since=aa2b5379 --until=fcd00dbd9df71923a9a2dd909dc230b344eea9f2 --system-id=1 --path=.
```
