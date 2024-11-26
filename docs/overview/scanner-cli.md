---
layout: default
parent: Overview
title: Scanner CLI
permalink: /overview/scanner-cli
nav_order: 99
---

## 方式 1： Use CLI

```bash
curl -fsSL archguard.org/install-cli.sh | bash
```

执行：

```nash
archguard --help
```

返回结果：

```
Usage: runner [OPTIONS]

  scanner cli

Options:
  --type [SOURCE_CODE|GIT|DIFF_CHANGES|SCA|RULE|ARCHITECTURE|ESTIMATE|OPENAPI|DOCUMENT]
  --system-id TEXT                 system id for use ArchGuard backend
  --server-url TEXT                the server for receive data, for example
                                   ArchGuard backend
  --workspace TEXT                 the workspace directory
  --path TEXT                      the path of target project
  --output TEXT                    http, csv, json, console
  --output-dir TEXT                output directory
  --analyser-spec TEXT             Override the analysers via json.
  --slot-spec TEXT                 Override the slot via json.
  --language TEXT                  language: Java, Kotlin, TypeScript, CSharp,
                                   Python, Golang.
  --rules TEXT                     rules: webapi, test, sql
  --features TEXT                  features: apicalls, datamap.
  --repo-id TEXT                   repository id used for git analysing
  --branch TEXT                    repository branch
  --started-at INT                 TIMESTAMP, the start date of the scanned
                                   commit
  --since TEXT                     COMMIT ID, the specific revision of the
                                   baseline
  --until TEXT                     COMMIT ID, the specific revision of the
                                   target
  --depth INT                      INTEGER, the max loop depth
  --with-function-code             BOOLEAN, whether to include the function
                                   code
  --with-structure-cache           BOOLEAN, whether to enable structure cache
  --debug                          BOOLEAN, whether to enable debug mode
  -h, --help                       Show this message and exit
```

### 执行示例：

```bash
archguard --language=Kotlin --features=apicalls --features=datamap --output=http --output=json --path=. --server-url=http://localhost:8080
```

## 方式 2: 下载 cli.jar

下载地址 ArchGuard Release: [https://github.com/archguard/archguard/releases] ，如 `scanner_cli-2.2.8-all.jar`

执行：

```
java -jar scanner_cli.jar --language=Kotlin --features=apicalls --features=datamap --output=http --output=json --path=. --server-url=http://localhost:8080
```

### 示例 2：CLI with custom slot

```
java -jar scanner_cli.jar --language=Kotlin --features=apicalls --output=json --path=server --slot-spec='{"identifier": "rule", "host": "https://github.com/archguard/archguard/releases/download/v2.0.0-alpha.17", "version": "2.0.0-alpha.17", "jar": "rule-webapi-2.0.0-alpha.17-all.jar", "className": "org.archguard.linter.rule.webapi.WebApiRuleSlot", "slotType": "rule"}' 
```
