---
layout: default
parent: Overview
title: Component Overview
permalink: /overview/module-analysis
nav_order: 11
---

在组件视图内，我们可以看到单个项目的总体情况，根据对应的代码提交历史，不稳定代码模块：

![Summary](/assets/140/summary.png)

API 声明和使用情况等：

![API Usage](/assets/140/api-usage.png)

并通过体量维度、耦合维度、内聚维度、冗余维度、测试维度五大维度对架构进行评估，以及一系列的指标来分析系统的情况：

![Evolution](/assets/140/evoluation.png)

## Why 高频变更 

反应的是系统的不稳定性

在单个服务/单个模块内，主要可以根据 SOLID 进行治理，诸如于一些常见的原因： 

1. 划分不合理。应该是在 B 聚合下的，划到了 A 聚合下。导致了 B 相关 API 特别多，但是 A 的非常少。
2. 类承担过多的职责。
3. 职责不清晰。不合理划分的 Util 类。

诸如于 Intellij IDEA 源码中的 [EditorImpl](https://github.com/JetBrains/intellij-community/blob/master/platform/platform-impl/src/com/intellij/openapi/editor/impl/EditorImpl.java)

也可以考虑 [CUPID](https://dannorth.net/2022/02/10/cupid-for-joyful-coding/) 原则：

- 可组合：与他人相处融洽
- Unix哲学：做好一件事
- 可预测：做你所期望的
- 惯用语：感觉自然
- 基于领域：解决方案领域在语言和结构上对问题领域进行建模
