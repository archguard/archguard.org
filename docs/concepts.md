---
layout: default
title: Concepts
nav_order: 80
permalink: /concepts
---

架构建模是一个**复杂问题**。

适用于这样的一个过程：探索 (Probe)  -> 感知 (Sense) -> 响应 (Respond)。

## 《面向模式的软件架构 卷 1：模式系统》架构定义

**软件架构**描述了软件系统的子系统和组件以及它们之间的关系。通常使用不同的视图来说明子系统和组件，以展示软件系统的功能特征和非功能特征。系统的软件
架构是人工制品，乃软件设计活动的结果。

**组件**是被封装起来的软件系统的一部分，包含一个接口。组件是用于打造系统的构件。在编程语言层面，组件可能由模块、类、对象或一组相关的函数表示。

**关系**描述了组件之间的联系，可能是静态的，也可能是动态的。静态关系会在源代码中直接显示出来，它们指出了架构中组件的布局；动态关系指出了组件之间
的临时关系和动态交互，可能不容易通过源代码的静态结构看出来。

（动态关系，可以结合 APM）

**视图**呈现软件架构的某个方面，展示软件系统的某些具体特征。

视图的例子包括组件的状态视图以及组件间通信视图和数据传输视图。

视图一 SNH 95 [^snh] 结构化分类：

- 概念架构（组件、关系等）（conceptual architecture）
- 模块关系（子系统、模块、导出和导入等）（module interconnection architecture）
- 执行任务（任务、线程、进程等）（execution architecture）
- 代码架构（文件、目录、库等）（code architecture）

[^snh]: "Software Architecture in Industrial Applications"

视图二： KRU95 4 + 1 [^kru95] 视图表示方式：

- 逻辑视图（logical view）。设计方案的对象模型或通信模型，如实体关系图。
- 流程视图（process view）。并发性和同步方面。
- 物理视图（physical view）。软件和硬件的对应关系以及分布性方面。
- 开发视图（development vie）。软件在开发环境中的静态组织结构。

[^kru95]: Architectural Blueprints—The “4+1” View Model of Software Architecture

**功能特征**描述了系统功能的特定方面，通常与特定的功能需求相关。功能特征可能表现为应用程序用户能够看到的特定功能，也可能描述了实现的特定方面，
如用于实现功能的算法。

**非功能特征**描绘了功能特征未涵盖的软件特征，通常阐述了与软件系统可靠性、兼容性、成本、易用性、维护或开发相关的方面。

**软件设计**指的是软件开发人员根据给定的功能和非功能特征，确定软件系统的组件以及组件间关系的活动，其成果为系统的软件架构。

**架构风格**从组织结构的角度定义了一个软件系统族，描述了组件及其关系、使用这些组件时应满足的约束条件，以及创建这些组件时应遵循的组合和设计规则。

**框架**是一个有待实例化的软件（子）系统半成品。它为一个（子）系统定义了架构。并提供了创建它们的构件。框架还指出了需要调整哪些地方的具体功能。在
面向对象环境中，框架由抽象类和具体类组成。

### Software Architecture in Industrial Applications

| 软件架构 | 使用示例                                            | 影响因素的例子             |
|------|-------------------------------------------------|---------------------|
| 代码架构 | 配置管理, 系统构建、OEM 定价                               | 编程语言，开发工具和环境，扩展子系统  |
| 模块架构 | 模块接口管控、变更影响分析、接口约束一致性检查、配置管理                    | 使能软件技术、组织结构、设计原则    |
| 执行架构 | 性能和可调度性分析，系统的静态和动态配置，将系统移植到不同的执行环境              | 硬件架构、运行时环境性能标准、通信机制 |
| 概念架构 | 使用特定领域的组件和连接器进行设计、性能评估、安全性和可靠性分析、了解系统的静态和动态可配置性 | 应用领域、抽象软件范式、设计方法    | 

元素

| 软件架构 | 组件                        | 互连                                                                                 | 工程标准                                 |
|------|---------------------------|------------------------------------------------------------------------------------|--------------------------------------|
| 概念架构 | 领域特定组件                    | 领域特定互连                                                                             | 对周期的限制，对吞吐量的要求                       |
| 模块架构 | 系统、子系统、模块、层               | component_of，import_from, export_to                                                | 功能分解方法，信息隐藏和抽象等标准，何时使用多个接口，分层策略施加的约束 |
| 执行架构 | 进程、任务、线程、客户端、服务器、缓冲区、消息队列 | 进程间通信，远程过程调用                                                                       | 优先级分配的标准，运行时环境施加的约束                  |
| 代码架构 | 文件、目录、链接器库、包、程序库          | member_of, includes, contains, linked_with, compiled_into, with clause, use clause | 编译和构建时间、与项目管理和配置管理工具以及开发环境相关的标准      | 

详细解释《实用体系软件结构》

![ArchView](/assets/diagrams/arch-view.svg)

不同的**关注点**

概念视图：

- 系统如何满足需求？
- 商用构件怎样组装成整体，怎样在功能上与系统的其他部分交互？
- 领域特定的硬件和/或软件如何融入系统？
- 功能是如何被分割并进入产品各版本的？
- 系统如何与之前版本的产品合并？它如何支持未来的版本？
- 如何支持产品线？
- 如何将由需求或领域中所做的变动引起的影响最小化？

模块视图：

- 产品是如何映射到软件平台的？
- 使用了什么样系统支持或系统服务？具体是在什么地方？
- 怎样支持测试？
- 如何降低模块间的依赖性？
- 如何将模块与子系统的复用最大化？
- 当商用软件、软件平台或标准发生变动时，采用何种技术在封装产品可以将它们与产品进行隔离？

执行视图：

- 系统如何满足性能、恢复及重新配置方面的需求？
- 如何平衡资源的使用（例如：负载平衡）？
- 如何达到必需的并发、复制及分布，而不过度增加控制算法的复杂度？
- 如何使运行时平台的改变所引起的影响达到最小？

代码视图：

- 如何降低产品升级的时间和费用？
- 如何管理产品版本及发布？
- 如何降低构造时间？
- 需要什么工具支持开发环境？
- 如何支持集成与测试？

## 《软件架构：架构模式、特征及实践指南》

**软件架构**包含系统的结构、系统必须支持的架构特征、架构决策以及设计原则。

**系统的结构**是指实现该系统的一种或多种架构风格（如微服务、分层和微内核等）。

## 《软件系统架构：使用视点和视角与利益相关者合作》

典型系统类型的重要视图（viewpoint）

|     | OLTP 信息系统 | 计算服务/中间件 | DSS/MIS 系统 | 大数据量的站点 | 企业程序包 |
|-----|-----------|----------|------------|---------|-------|
| 情境  | 高         | 低        | 高          | 中       | 中     | 
| 功能  | 高         | 高        | 低          | 高       | 高     |
| 信息  | 中         | 低        | 高          | 中       | 中     |
| 并发  | 低         | 高        | 低          | 中       | 视情况而定 |
| 开发  | 高         | 高        | 低          | 高       | 高     |
| 部署  | 高         | 高        | 高          | 高       | 高     |
| 运维  | 视情况而定     | 低        | 中          | 中       | 高     |

典型系统类型的最重要视角（perspective）

|         | OLTP 信息系统 | 计算服务/中间件 | DSS/MIS 系统 | 大数据量的站点 | 企业程序包 |
|---------|-----------|----------|------------|---------|-------|
| 可访问性    | 视情况而定     | 低        | 视情况而定      | 高       | 高     |
| 可用性和弹性  | 视情况而定     | 高        | 中          | 高       | 中     |
| 开发资源    | 中         | 高        | 中          | 高       | 低     |
| 演进      | 视情况而定     | 低        | 高 视情况而定    | 中       |
| 国际化     | 视情况而定     | 低        | 视情况而定      | 高       | 视情况而定 |
| 位置      | 视情况而定     | 低        | 低          | 高       | 视情况而定 |
| 性能和可伸缩性 | 视情况而定     | 高        | 视情况而定      | 高       | 视情况而定 |
| 法规      | 视情况而定     | 低        | 视情况而定      | 视情况而定   | 视情况而定 |
| 安全性     | 视情况而定     | 低        | 中          | 高       | 高     |
| 易用性     | 中         | 低        | 低          | 高       | 中     | 

名词

- 联机事务处理（Online Transaction Processing）
- 管理信息系統（Management Information System）
- 決策支持系統（Decision Support System）
