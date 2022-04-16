---
layout: default
parent: Overview
title: 组件/模块分析
permalink: /overview/services-map
nav_order: 2
---

## 系统依赖分析：服务地图

**注意**：这种依赖分析方式，依赖于团队开发人员拥有统一的编码规范。

而针对于微服务来说，ArchGuard 可以自动化地分析不同服务之间的依赖关系，并将这种依赖关系可视化出来：

![API Analysis](/assets/140/http-api-analysis.png)

PS：由于 ArchGuard 过去是微服务架构，合并成单体之后，存在自己调用自己的情况。

同时，系统能帮你自动分析哪些 API 是使用的，哪些 API 是未被使用的（有些 API 暂时分析不到）：

![未匹配 API](/assets/140/umatch-api.png)

当前，ArchGuard 可以支持 Spring、RestTemplate、Axios、UMI-Request 等几种有限的 API 调用识别。
