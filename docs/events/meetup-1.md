---
layout: default
title: ArchGuard 1st Meetup
parent: Events
nav_order: 1
has_children: true
permalink: /events/1
---

Videos: [开源架构治理平台 ArchGuard —— Meetup 第一期](https://www.bilibili.com/video/BV1oF411g79d?spm_id_from=333.999.0.0)

## 当前功能的介绍

省略好几百个字。

## 架构治理

### 架构评估及预警

通过持续的架构评估，可以在开发态对于架构实现的效果进行评定，并且对于一些不合理的实现进行预警。
架构评估的关键在于评估模型的建立以及阈值区间的设置，现有评估模型的一级维度如右图所示，源于行业经验沉淀而构建的，仍需完善：

1. 从业界架构设计的原则、规范与最佳实践出发，如：高内聚、低耦合、开闭原则、依赖倒置等
2. 对代码架构坏味道进行了体系化的归纳总结，如数据泥团、枢纽化模块、深继承、循环依赖都可能导致过高耦合
3. 充分重视测试保护对于架构的贡献及影响
4. 同时兼顾考虑了业界实践与企业内部规范的融合

未来需要持续地：评估模型完善，对应功能开发

## 下个版本

已知的 ArchGuard 使用场景：

1. 基于 ArchGuard 前端、后端进行分析或者定制。
2. 基于 Scanner 配合持续集成使用。（自定义规则）
3. 将 Scanner 集成到自己现有的系统中。（定制一些插件）

所以下一个版本的主要关注点是：《Scanner 重用》。

主要的特性：

- **Scanner 组件化：可插拔与自定义扩展**。拆分scanner，并允许使用自定义的组件替换官方组件
- **Scanner Linter 插件化：框架插件化 API**。通过抽象与复用，将现有的测试坏味道、数据库地图、API 分析等做成标准 API

其它，还有：

- 依赖组件清单（如：Gradle、Maven、NPM）
- API Linter 示例
- RPC 调用
- All in One 版本包
- ……


