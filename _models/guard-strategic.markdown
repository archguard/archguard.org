---
layout: single
title: 策略·模式·方法 ｜ 守护策略
header:
  overlay_filter: "rgba(99, 183, 175, 0.6)"
  overlay_image: /assets/images/background.jpg
sidebar:
  nav: "models"
permalink: /models/guard-strategic/
classes: wide
---

## 演进式守护原则

> 源自《演进式架构》:
> 演进式架构以支持增量的、非破坏的变更作为第一原则，同时支持在应用程序结构层面的多维度变化。
{: .notice--info}

* **增量变更**: 如何增量地构建软件和如何部署软件。
* **适应度函数**: 架构的适应度函数为某些架构特征提供了客观的完整性评估。
* **适当的耦合**: 如何确定哪些架构维度间应该相互耦合，以最小的开销和成本最大程度地获益。

## 聚焦痛点“如何减缓腐化”

! [如何减缓腐化](/assets/images/demising.png)


## 整体策略

* 依托工具多角度全时守护
  * 多角度： 基本代码规范扫描、测试保护能力扫描、依赖关系、分层架构、变更影响等等
  * 多个时间点： 开发阶段守护、测试阶段守护、运行时守护
* 基准化操作
  * 沉淀实践、降低门槛
* 人员技能提高
  * 工程师文化的培养

