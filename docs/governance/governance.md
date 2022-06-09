---
layout: default
title: Governance
nav_order: 4
has_children: true
permalink: /governance
---

{:toc}

Architecture Governance model

![ArchGuard](/assets/diagrams/archguard-model.svg)

## Linter

- SQL Linter 基于 [jsqlparser](https://github.com/JSQLParser/JSqlParser) 可以支持多种 SQL 方言，如 Oracle, SqlServer, MySQL, PostgreSQL ...
- Test Code 用于检测代码中的坏味道 
- Web API 分析 Web API 的规范
- Layer （待实现）分析代码中的分层实现
- Arch  （待实现）参照 [ArchUnit](https://github.com/TNG/ArchUnit) 或者 [Guarding](https://github.com/modernizing/guarding)

