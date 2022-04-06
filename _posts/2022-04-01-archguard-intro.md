---
layout: single
title:  "ArchGuard 介绍"
categories:
- Blog
- ArchGuard
---

过去的 10 年间，软件的架构发生了巨大的变化，从早先流行的单体 MVC 架构，变成了所谓的 5：5 开，即分布式 vs 单体。只是呢，有大量的软件开发人员，无法看到系统的全貌，又或者是从单体的思维转变过来。于是，哪怕是在使用了微服务的情况下，但是实现的却又是一个一个的单体，只是它们变成了“分布式的单体”。

架构治理变成一个急待解决的问题。

## 我们所面临的挑战

作为一个架构师或者是软件开发人员，在架构治理上，我们面对的诸多挑战有：

- 设计与实现不匹配。设计的软件架构与真正实施后的架构，存在着巨大的差异。而这个差异，往往需要编码上线、乃至一段时间之后才能发现。
- 没有规范/不遵守规范。作为一个资深的开发人员，我们制定了一系列的规范，但是没有多少团队人员愿意遵守。
- 代码量巨大，难以识别问题。一个由十几个或者几十个微服务创建的系统，往往难以快速发现它们之间错综复杂的关系。
- 架构模型的每个层级都可能出错。如服务间 API 耦合、代码间耦合、数据库耦合等等。
- 架构师、开发人员自身缺乏丰富的经验。知道有问题，但是说不出来哪有问题，也不知道如何改进。

应对这些挑战，我们需要一个平台/工具，来帮助我们解决这些问题。所以，结合我们过去的一系列软件开发和重构经验，我们（Thoughtworks 的咨询师们）从 2020 年（疫情开始的时候）开始了架构治理平台 ArchGuard 的开发。

如今呢，它开源了，GitHub：[https://github.com/archguard/archguard](/assets/140/https://github.com/archguard/archguard)

## 它能做点什么？

ArchGuard 按照流行的 C4 架构模型进行分层化的分析。即在 System Context（上下文）, Container（容器）, Component（部件）, Code（代码）四个不同的架构视图上，它们是不同的抽象级别，对应于不同的受众，如团队内开发人员关心代码内的依赖，架构师关心组件、窗口间的依赖。

![Home](/assets/140/home.png)

而在最后的实现形式上，它们是以代码库和文档的形式存在的。ArchGuard 是基于代码的静态分析工具，未来也将基于设计提供这方面的功能。

在 ArchGuard 中，我们需要先创建一系列的系统组件，即要配置好对应的语言和 GitHub 地址，就可以对代码进行扫描。

### 组件/模块

在组件视图内，我们可以看到单个项目的总体情况，根据对应的代码提交历史，不稳定代码模块：

![Summary](/assets/140/summary.png)

API 声明和使用情况等：

![API Usage](/assets/140/api-usage.png)

并通过体量维度、耦合维度、内聚维度、冗余维度、测试维度五大维度对架构进行评估，以及一系列的指标来分析系统的情况：

![Evolution](/assets/140/evoluation.png)

### 系统依赖分析：服务地图

**注意**：这种依赖分析方式，依赖于团队开发人员拥有统一的编码规范。

而针对于微服务来说，ArchGuard 可以自动化地分析不同服务之间的依赖关系，并将这种依赖关系可视化出来：

![API Analysis](/assets/140/http-api-analysis.png)

PS：由于 ArchGuard 过去是微服务架构，合并成单体之后，存在自己调用自己的情况。

同时，系统能帮你自动分析哪些 API 是使用的，哪些 API 是未被使用的（有些 API 暂时分析不到）：

![未匹配 API](/assets/140/umatch-api.png)

当前，ArchGuard 可以支持 Spring、RestTemplate、Axios、UMI-Request 等几种有限的 API 调用识别。

### 数据库依赖分析：数据库地图

**注意**：这种依赖分析方式，依赖于团队开发人员拥有统一的编码规范。

针对于数据库间的依赖问题，ArchGuard 可以解析代码中的 SQL 调用，并**尝试性**将这种依赖关系与不同的微服务相匹配，进而分析哪些服务在数据库层是耦合的。由于存在不统一的编码规范，所以有些情况下，我们并没有识别出代码中的数据库表：

![Database](/assets/140/database.png)

通过这种依赖关系，我们可以查看代码中最经常使用的表。再结合我们在代码分析中的功能，就可以查看数据库的调用地图（前端实现中）。

### 代码分析

对于开发团队来说，它们可以在 ArchGuard 上查看项目的模块、包、类、方法之间的依赖关系：

![Code Analysis](/assets/140/code-analysis.png)

通过上面的 LoginModuleRepository 就能匹配到数据库对应的结果。

### 变更影响分析（开发中）

我们正在实现的一个功能是，通过分析和配置系统潜在的代码修改点，进而通过依赖关系，分析出变更的影响范围。它即能帮助架构师分析需求的影响，又能帮助测试人员更精准地测试系统中的内容。

## ArchGuard 是如何达成上述功能的？

ArchGuard 内置两个代码分析引擎：Bytecode 分析 + 源码分析。

- Bytecode 分析。顾名思义，就是通过分析 JVM 中的字节码，从而分析出代码中的依赖关系。
- 源码分析。即通过分析生成编译语言的语法树，产出特定的数据结构。

源码分析主要是静态分析，结合先前在重构自动化开源组织 [Modernizing](/assets/140/https://github.com/modernizing) 下开源的 Chapi 代码分析引擎（[https://github.com/modernizing/chapi](/assets/140/https://github.com/modernizing/chapi)）。Chapi 基于 Antlr 实现的语法分析，支持主流的编程语言：TypeScript/JavaScript、Kotlin、Java、C# 等等。如下表所示：


| Features/Languages  | Java | Python | Go  | Kotlin | TypeScript | C   | C#  | Scala | C++ |
|---------------------|------|--------|-----|--------|------------|-----|-----|-------|-----|
| http api decl       | ✅    | 🆕     | 🆕  | ✅      | ✅          | 🆕  | 🆕  | 🆕    | 🆕  |
| syntax parse        | ✅    | ✅      | ✅   | ✅     | ✅          | 🆕  | 🆕  | ✅     | 🆕  |
| function call       | ✅    | 🆕     |     | ✅     | ✅          |     |     |       |     |
| arch/package        | ✅    |        |     |✅        | ✅          |     |     | ✅     |     |
| real world validate | ✅    |        |     | ✅       | ✅          |     |     |       |     |

由于是静态代码分析，所以有些内容并不是非常准确。

再结合 ArchGuard Scanner （[https://github.com/archguard/scanner](/assets/140/https://github.com/archguard/scanner)）中的几个扫描工具将数据流入数据库中：

- scan_git，分析 Git 提交历史、行数、语言等基础信息
- scan_jacoco，分析代码测试覆盖率
- scan_bytecode，字节码分析
- scan_sourcecode，源码分析（包含 HTTP API 分析、数据库分析）
- scan_test_badsmell，测试代码坏味道
- collector_ci，收集 CI/CD 中的历史记录

## 其它

欢迎加入 ArchGuard 的开发中来，GitHub：[https://github.com/archguard/archguard](/assets/140/https://github.com/archguard/archguard)
