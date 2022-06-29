---
layout: default
title: 独立模型
parent: Setup
nav_order: 20
permalink: /setup/standalone
---

ArchGuard Scanner 支持独立的扫描模式，即不需要 ArchGuard Backend/Server 就能独立进行扫描。

## CLI 命令使用

```bash
Usage: runner [OPTIONS]

  scanner cli

Options:
  --type [SOURCE_CODE|GIT|DIFF_CHANGES|SCA|RULE|ARCHITECTURE]
  --system-id TEXT                 system id
  --server-url TEXT                the base url of the archguard api server
  --workspace TEXT                 the workspace directory
  --path TEXT                      the path of target project
  --output TEXT                    http, csv, json, console
  --analyser-spec TEXT             Override the analysers via json.
  --slot-spec TEXT                 Override the slot via json.
  --language TEXT                  language: Java, Kotlin, TypeScript, CSharp, Python, Golang.
  --rules TEXT                     rules: webapi, test, sql
  --features TEXT                  features: apicalls, datamap.

  --repo-id TEXT                   repository id used for git analysing
  --branch TEXT                    repository branch
  --started-at INT                 TIMESTAMP, the start date of the scanned commit
  --since TEXT                     COMMIT ID, the specific revision of the baseline
  --until TEXT                     COMMIT ID, the specific revision of the target
  --depth INT                      INTEGER, the max loop depth
  -h, --help                       Show this message and exit
```

示例命令行：

**常规 CLI**

```
java -jar scanner_cli.jar --language=Kotlin --features=apicalls --output=json 
```

**带规则的命令行**

```bash
java -jar scanner_cli.jar --language=Kotlin --features=apicalls --output=json --path=server --slot-spec='{"identifier": "rule", "host": "https://github.com/archguard/archguard/releases/download/v2.0.0-alpha.17", "version": "2.0.0-alpha.17", "jar": "rule-webapi-2.0.0-alpha.17-all.jar", "className": "org.archguard.linter.rule.webapi.WebApiRuleSlot", "slotType": "rule"}'
```



