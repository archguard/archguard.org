---
layout: default
title: ArchGuard
nav_order: 1
description: "ArchGuard 是一个针对于微服务（分布式场景）下的架构治理工具。它可以在开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。"
permalink: /
---

Online Demo: coming soon

![Logo](/assets/images/logo.png)

# Quick Start

## Docker Compose

```
curl -s https://raw.githubusercontent.com/archguard/archguard/master/install.sh | bash -s master 
```

or

```
git clone https://github.com/archguard/archguard
docker-compose up
```

## 新建项目

Docker Compose 启动后，访问：[http://localhost:11080/](http://localhost:11080/)，就可以新建项目

1. 添加：[https://github.com/archguard/archguard](https://github.com/archguard/archguard)，名称 Backend，选择 Kotlin 语言，再选择扫描
2. 添加：[https://github.com/archguard/archguard-frontend](https://github.com/archguard/archguard-frontend)，名称 Frontend，选择 TypeScript 语言，**配置源码路径** `archguard`（如果项目的 src 不是在其它目录，就不需要此选项），再选择扫描

等待扫描完成，进入 Backend 就可以看到如下的页面：

![Backend Overview](/assets/screenshots/archguard-20-overview.png)

在服务地图可以看到类似于下面的页面：

![Services Map](/assets/screenshots/archguard-20-servicesmap.png)

如果没有的话，请根据 [FAQ](/docs/faq) 进行调整，或者提交新的 [issue](https://github.com/archguard/archguard)。 

## Why ArchGuard

### vs APM

APM is awesome for developer. APM is build in runtime, ArchGuard is focus on development and rules. In archguard, not follow rule will not show data, better for governance.

APM 是在运行态发现架构问题的，ArchGuard 是运行在开发态。两者之间存在一些 gap，ArchGuard 专注于代码，更适用于通过规范来治理架构 —— 没有规范，没有数据。
