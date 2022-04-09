---
layout: default
title: Modules
nav_order: 8
has_children: true
permalink: /modules
---

{: .no_toc .text-delta }

1. 目录
   {:toc}

所有的 Scanner 都以 Jar 包 + CLI 的方式来提供服务，使用的框架是：clikt，语言是：Kotlin。

## Scanner Download

Scanner 下载过程：

1. 从 GitHub 的 release 下载对应的版本到应用的运行目录。
   - 在本地时，则与后端代码同级（即和 build.gradle.kts 同级）
   - 在镜像内，则与 /home/spring/app.jar 同级
2. 将 Scanner 从应用目录，拷贝到代码仓库的临时目录

## Scanner **本地调试**

将 jar 包复制到将要构建的项目目录，按不同类型的应用和参数执行。其中 DBUrl 和 systemId 为必填 。

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
