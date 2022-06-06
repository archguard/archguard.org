---
layout: default
title: Scanner
parent: Setup
nav_order: 2
permalink: /setup/scanner
---

## AST vs Bytecode

ArchGuard 1.0 使用的是 Bytecode 分析，经常编译失败，主要存在以下问题：

1. 在内网环境搭建时，需要为服务器配置一系列的环境，如 Gradle, Maven 等。
2. 编译时，还需要配置特定的 JDK 版本等，否则会编译失败。

ArchGuard 1.6.x 之后使用 Chapi + AST 分析

1. 多语言支持 + 插件化
2. 支持针对特定环境的语法操作，如 SQL 之类的操作等

