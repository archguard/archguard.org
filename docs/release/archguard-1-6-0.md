---
layout: default
parent: Release
title: ArchGuard 1.6.0 正式发布
permalink: /release/archguard-1-6-0
---

ArchGuard 是一个针对于微服务（分布式场景）下的架构治理工具。它可以在开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。

## 重要更新

针对于 1.4.0 ~ 1.6.0 版本的变化：

重要更新：

- 数据库地图。支持从代码到数据库调用关系的展示（说明见文档：[源码分析：数据库依赖](https://archguard.org/modules/scanner/sourcecode-database)）。
  - 支持 JPA 注解
  - 支持 JDBI 注解
  - 支持 MyBatis（XML 方式） [#9](https://github.com/archguard/archguard/issues/9)
- 影响变更分析。允许根据 commit id，选择某一区间内的代码变更的影响范围。
  - 支持 Java 语言。 

其它更新：

- 支持在网页端查看构建日志 [#13](https://github.com/archguard/archguard/issues/13)
- 优化代码下载过程，支持 Git 增量更新 [#16](https://github.com/archguard/archguard/issues/16)

## 问题修复

- 服务地图。支持 `@Controller` 注解，以及 `Request Mapping 为空的情况等。
- 修复 TypeScript 依赖分析下，React 组件的命名问题。
- 修复 Windows 下，TypeScript 依赖分析的路径问题
- 等等。
