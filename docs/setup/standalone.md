---
layout: default
title: 独立模型
parent: Setup
nav_order: 20
permalink: /setup/standalone
---

ArchGuard Scanner 支持独立的扫描模式，即不需要 ArchGuard Backend/Server 就能独立进行扫描。

示例命令行：

```bash
java -jar scanner_cli.jar --language=Kotlin --features=apicalls --output=json --path=server --slot-spec='{"identifier": "rule", "host": "https://github.com/archguard/archguard/releases/download/v2.0.0-alpha.17", "version": "2.0.0-alpha.17", "jar": "rule-webapi-2.0.0-alpha.17-all.jar", "className": "org.archguard.linter.rule.webapi.WebApiRuleSlot", "slotType": "rule"}'
```



