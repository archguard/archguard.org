---
layout: default
title: FAQ
nav_order: 99
permalink: faq
---

## JVM

### Fail to identify build tool for compile

选择 JVM，但是未能识别到构建工具，

建议使用 Java、Kotlin 进行扫描。

## Scanner

下载最新的 [Scanner](https://github.com/archguard/scanner/releases)

```
java "-Ddburl=jdbc:mysql://localhost:3306/archguard?user=root&password=&useSSL=false" -jar scan_sourcecode.jar --system-id=6 --language=java --path=.
```

1. 运行目录 scanner 中的 .jar 是否完整。如果出错了，需要从 GitHub 重新下载。
2. 查看是否生成对应的 sql 文件。如果没有的话，建议可以提交 issue，包含错误日志。

### Error: Unable to access jarfile scan_sourcecode.jar

出错：Error: Unable to access jarfile scan_sourcecode.jar

原因：连接不了 Github 下载对应的 jar

建议：

1. 选择合适的 VPN 工具，连接下载。
2. 将 jar 包打包到进窗口中

未来将提供一个 all in one 的大版本包。

## Git

### Fail to clone source with exitCode 128

无法 CLONE 代码，需要检查一下用户名和密码，或者网络权限。

### Git 源码配置

error: cannot run ssh: No such file or directory
fatal: unable to fork

ArchGuard 直接调用 `git clone` 去 clone 源码

如果配置了用户名和秘密，则会执行 `repo.replace("//", "//${urlEncode(systemInfo.username)}:${urlEncode(systemInfo.getDeCryptPassword())}@")`，以生成一个带用户名和密码的 URL。

### SSL certificate problem: unable to get local issuer certificate

原因：内部 Git 服务器的 SSL 证书有问题

建议：尝试到 Docker 窗口中配置一下不验证 SSL

```
git config --global http.sslVerify false
```

### Windows

java.io.IOException: Cannot run program "git" (in directory "d:/xxx"): d:/xxx/scm_git_hot_file.txt (No such file or directory)

Docker Compose 下访问不了 Local 类型的项目，建议下载。

## Docker

### docker mysql exited 137 memory

需要增大 Docker 虚拟机内存。

The default VM created by Coloma has 2 CPUs, 2GiB memory and 60GiB storage.  When run scanner in large projects, the default config will make MySQL exited, can to set more memory for ArchGuard:

```
colima start --cpu 4 --memory 8
```

### specify container image platform requires api version 1.41

需要更新一下 Docker Compose 的版本到  1.41

### Alpine ERROR: unable to select packages:

尝试：

```
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
```

### SSL certificate problem: unable to get local issuer certificate

1. `git clone https://github.com/archguard/archguard`
2. `docker-compose -p ArchGuard -f ./docker-compose.yml up -d` 所有组件启动OK
3. 参考 https://archguard.org/ ，访问 http://localhost:11080/， 创建系统
4. `./docker-compose logs -f` 查看日志打印，出现`SSL certificate problem: unable to get local issuer certificate`错误
查看日志，该日志在`archguard-backend`容器中的错误，最开始本人误认为是宿主机上的错误，解决方法如下：

```
# 进入后端容器
docker exec -it archguard-backend /bin/sh
git config --global http.sslVerify false
# 验证以下
git clone xxxxxx
```

**注：有些童鞋可能会遇到无法访问外网的问题，根据自己公司设置外网代理即可（docker宿主机器和`archguard-backend`容器都需要配置）**

详细操作步骤，可参考：
* [Look me：ArchGuard 部署搭建 —— help ！！！](https://github.com/archguard/archguard/issues/14)
* [SSL certificate problem: unable to get local issuer certificate](https://github.com/archguard/archguard/issues/28)

### failed to scan GitSourceScanner

详细日志如下：

```
archguard-backend   | 2022-04-12 14:34:56.506 ERROR 1 --- [pool-3-thread-3] c.t.a.s.d.hubexecutor.ScannerManager     : failed to scan GitSourceScanner
archguard-backend   |
archguard-backend   | java.net.ConnectException: Operation timed out (Connection timed out)
archguard-backend   |   at java.base/java.net.PlainSocketImpl.socketConnect(Native Method) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:399) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:242) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:224) ~[na:na]
archguard-backend   |   at java.base/java.net.SocksSocketImpl.connect(SocksSocketImpl.java:403) ~[na:na]
archguard-backend   |   at java.base/java.net.Socket.connect(Socket.java:591) ~[na:na]
archguard-backend   |   at java.base/sun.security.ssl.SSLSocketImpl.connect(SSLSocketImpl.java:285) ~[na:na]
archguard-backend   |   at java.base/sun.security.ssl.BaseSSLSocketImpl.connect(BaseSSLSocketImpl.java:173) ~[na:na]
archguard-backend   |   at java.base/sun.net.NetworkClient.doConnect(NetworkClient.java:182) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.http.HttpClient.openServer(HttpClient.java:474) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.http.HttpClient.openServer(HttpClient.java:569) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsClient.<init>(HttpsClient.java:265) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsClient.New(HttpsClient.java:372) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.getNewHttpClient(AbstractDelegateHttpsURLConnection.java:193) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1181) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1075) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:179) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1581) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1509) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsURLConnectionImpl.getInputStream(HttpsURLConnectionImpl.java:246) ~[na:na]
archguard-backend   |   at java.base/java.net.URL.openStream(URL.java:1140) ~[na:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.infrastructure.FileOperator.download(FileOperator.kt:14) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.git.GitScannerTool.download(GitScannerTool.kt:78) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.git.GitScannerTool.prepareTool(GitScannerTool.kt:55) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.git.GitScannerTool.getGitReport(GitScannerTool.kt:25) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.git.GitSourceScanner.scan(GitSourceScanner.kt:25) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.hubexecutor.ScannerManager.execute$lambda-1$lambda-0(ScannerManager.kt:27) ~[classes!/:na]
archguard-backend   |   at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264) ~[na:na]
archguard-backend   |   at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128) ~[na:na]
archguard-backend   |   at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628) ~[na:na]
archguard-backend   |   at java.base/java.lang.Thread.run(Thread.java:835) ~[na:na]
archguard-backend   |
archguard-backend   | 2022-04-12 14:34:56.506 ERROR 1 --- [pool-3-thread-1] c.t.a.s.d.hubexecutor.ScannerManager     : failed to scan SourceCodeScanner
archguard-backend   |
archguard-backend   | java.net.ConnectException: Operation timed out (Connection timed out)
archguard-backend   |   at java.base/java.net.PlainSocketImpl.socketConnect(Native Method) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.doConnect(AbstractPlainSocketImpl.java:399) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.connectToAddress(AbstractPlainSocketImpl.java:242) ~[na:na]
archguard-backend   |   at java.base/java.net.AbstractPlainSocketImpl.connect(AbstractPlainSocketImpl.java:224) ~[na:na]
archguard-backend   |   at java.base/java.net.SocksSocketImpl.connect(SocksSocketImpl.java:403) ~[na:na]
archguard-backend   |   at java.base/java.net.Socket.connect(Socket.java:591) ~[na:na]
archguard-backend   |   at java.base/sun.security.ssl.SSLSocketImpl.connect(SSLSocketImpl.java:285) ~[na:na]
archguard-backend   |   at java.base/sun.security.ssl.BaseSSLSocketImpl.connect(BaseSSLSocketImpl.java:173) ~[na:na]
archguard-backend   |   at java.base/sun.net.NetworkClient.doConnect(NetworkClient.java:182) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.http.HttpClient.openServer(HttpClient.java:474) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.http.HttpClient.openServer(HttpClient.java:569) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsClient.<init>(HttpsClient.java:265) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsClient.New(HttpsClient.java:372) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.getNewHttpClient(AbstractDelegateHttpsURLConnection.java:193) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.plainConnect0(HttpURLConnection.java:1181) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.plainConnect(HttpURLConnection.java:1075) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.AbstractDelegateHttpsURLConnection.connect(AbstractDelegateHttpsURLConnection.java:179) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream0(HttpURLConnection.java:1581) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.http.HttpURLConnection.getInputStream(HttpURLConnection.java:1509) ~[na:na]
archguard-backend   |   at java.base/sun.net.www.protocol.https.HttpsURLConnectionImpl.getInputStream(HttpsURLConnectionImpl.java:246) ~[na:na]
archguard-backend   |   at java.base/java.net.URL.openStream(URL.java:1140) ~[na:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.infrastructure.FileOperator.download(FileOperator.kt:14) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.codescan.sourcecode.SourceCodeTool.download(SourceCodeTool.kt:61) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.codescan.sourcecode.SourceCodeTool.prepareTool(SourceCodeTool.kt:38) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.codescan.sourcecode.SourceCodeTool.analyse(SourceCodeTool.kt:24) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.scanner.codescan.sourcecode.SourceCodeScanner.scan(SourceCodeScanner.kt:26) ~[classes!/:na]
archguard-backend   |   at com.thoughtworks.archguard.scanner.domain.hubexecutor.ScannerManager.execute$lambda-1$lambda-0(ScannerManager.kt:27) ~[classes!/:na]
archguard-backend   |   at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264) ~[na:na]
archguard-backend   |   at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128) ~[na:na]
archguard-backend   |   at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628) ~[na:na]
archguard-backend   |   at java.base/java.lang.Thread.run(Thread.java:835) ~[na:na]
archguard-backend   |
archguard-backend   | 2022-04-12 14:34:56.506  INFO 1 --- [pool-1-thread-3] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
archguard-backend   | 2022-04-12 14:34:56.506  INFO 1 --- [pool-1-thread-3] t.a.s.d.a.ArchitectureDependencyAnalysis :  Finished level 1 scanners
archguard-backend   | 2022-04-12 14:34:56.506  INFO 1 --- [pool-1-thread-3] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
```

该问题是由于`archguard-backend`容器访问`github`下载`Scanner`超时，解决方法：

1. 手动下载最新[`Scanner`jar包](https://github.com/archguard/scanner/releases)
2. 上传到docker宿主机，并且拷贝到`archguard-backend`容器的`/home/spring`目录
3. 修改版本号为`1.4.3`

```
# 登录容器
docker exec -it archguard-backend /bin/sh

~ $ pwd
/home/spring
~ $ ls
app.jar                           scan_git-1.4.3-all.jar            scan_test_badsmell-1.4.3-all.jar
archguard                         scan_jacoco-1.4.3-all.jar
diff_changes-1.4.3-all.jar        scan_sourcecode-1.4.3-all.jar
```

### 日志

查看：

```
docker-compose logs -f
```


