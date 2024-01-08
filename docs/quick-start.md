---
layout: default
title: ArchGuard
nav_order: 1
description: "ArchGuard 是一个由 Thoughtworks 发起的面向微服务（分布式场景）下的开源架构治理平台。它可以在设计、开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。"
permalink: /
---

![Logo](/assets/images/logo.png)

ArchGuard 是一个由 Thoughtworks 发起的面向微服务（分布式场景）下的开源架构治理平台。它可以在设计、开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。

核心理念：三态模型 + 双环守护

- 设计态：目标架构。通过 DSL（领域特定语言） + 架构工作台来构建 。
- 开发态：实现架构。关注于：可视化 + 自定义分析  + 架构治理。
- 运行态：运行架构。结合  APM 工具，构建完整的分析链。

双环守护：

![双环守护](assets/images/double-circle.png)

特性（Features）：

- **设计态**
	- 架构设计、分析与治理 DSL -> 参考：[Fklang](https://github.com/feakin/fklang)
- **开发态**
	- 架构扫描
		- 扫描配置
		- 插件化规则定制
	- 架构可视化
		- 基于 C4 模型的可视化分析
			- 上下文：API 服务地图（API 生产者支持语言：Java、Kotlin、C#，API 消费者支持语言：TypeScript/JavaScript、Kotlin、Java 等）
			- 容器分析。数据库地图（支持 MyBatis、JDBI、JPA）
			- 组件分析
			- 代码分析：支持级别模块、包、类、方法四个级别。
		- 高级分析 + 可视化
			- 系统不稳定性模块分析。
			- 容器间：精准测试/变化分析
	- 架构指标（单体DONE，分布式DOING）
		- 体量维度：过大的组件
		- 耦合维度：枢纽组件，过深调用，循环依赖
		- 内聚维度：霰弹式修改
		- 冗余维度：冗余元素，过度泛化
		- 质量维度：测试保护
	- 持续集成
- **架构工作台**
	- 查询整个组织的依赖信息
	- REPL 实时分析

Features：

- **Design State**
  - Architecture Design, Analysis and Governance DSL -> [Fklang](https://github.com/feakin/fklang)
- **Development state**
  - Schema scan
    - Scan configuration
    - Plug-in rule customization
  - Architecture visualization
    - Visual analysis based on C4 model
      - Context: API service map (API producer supported languages: Java, Kotlin, C#, API consumer supported languages: TypeScript/JavaScript, Kotlin, Java, etc.)
      - Container analysis. Database map (support MyBatis, JDBI, JPA)
      - Component analysis
      - Code analysis: supports four levels of modules, packages, classes, and methods.
    - Advanced Analysis + Visualization
      - System instability module analysis.
      - Between containers: precise testing/variation analysis
  - Architecture metrics (single DONE, distributed DOING)
      - Volume dimension: oversized components
      - Coupling dimension: hub components, too deep calls, circular dependencies
      - Cohesive Dimension: Shotgun Modification
      - Redundant dimensions: redundant elements, overgeneralization
      - Quality dimension: test protection
      - Continuous Integration
- **Architecture Workbench**

Online Demo: [https://archguard.dts.plus/](https://archguard.dts.plus/)

微信公众号： ![Wechat](/wechat.jpg)

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

## Local setup

see in [Setup](/setup)

## Docker 日志示例

```
➜  archguard-backend git:(master) ✗ docker-compose -p ArchGuard -f ./docker-compose.yml up -d
[+] Running 4/4
 ⠿ Container archguard_mysql     Healthy                                                                                                                                                                                                        0.5s
 ⠿ Container archguard_influxdb  Running                                                                                                                                                                                                        0.0s
 ⠿ Container archguard-backend   Running                                                                                                                                                                                                        0.0s
 ⠿ Container archguard-frontend  Started                                                                                                                                                                                                        1.3s
➜  archguard-backend git:(master) ✗ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS                             PORTS                                                    NAMES
9fa8ee495069   archguard/archguard-frontend:latest   "/docker-entrypoint.…"   10 minutes ago   Up 2 seconds                       0.0.0.0:11080->80/tcp, :::11080->80/tcp                  archguard-frontend
0c6064c84d4f   archguard/archguard-backend:latest    "java -jar /app.jar …"   10 minutes ago   Up 47 seconds (health: starting)                                                            archguard-backend
2450124197f2   mysql:8                               "docker-entrypoint.s…"   10 minutes ago   Up 35 seconds (healthy)            33060/tcp, 0.0.0.0:13306->3306/tcp, :::13306->3306/tcp   archguard_mysql
752459f7ccca   influxdb:1.8                          "/entrypoint.sh infl…"   10 minutes ago   Up 35 seconds (healthy)            0.0.0.0:8086->8086/tcp, :::8086->8086/tcp                archguard_influxdb
```

## 新建项目

Docker Compose 启动后，访问：[http://localhost:11080/](http://localhost:11080/)，就可以新建项目

1. 添加：[https://github.com/archguard/archguard](https://github.com/archguard/archguard)，名称 Backend，选择 Kotlin 语言，再选择扫描
2. 添加：[https://github.com/archguard/archguard-frontend](https://github.com/archguard/archguard-frontend)，名称 Frontend，选择 TypeScript 语言，再选择扫描

对于 Archguard 前端来说，因为源码是在 `archguard/src` 目录下，所以需要额外的**配置源码路径**

等待扫描完成，进入 Backend 就可以看到如下的页面：

![Backend Overview](/assets/screenshots/archguard-20-overview.png)

在服务地图可以看到类似于下面的页面：

![Services Map](/assets/screenshots/archguard-20-servicesmap.png)

如果没有的话，请根据 [FAQ](/docs/faq) 进行调整，或者提交新的 [issue](https://github.com/archguard/archguard)。 

成功日志示例：

```
2022-04-08 16:51:14.826  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:51:14.826  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis :  Finished level 1 scanners
2022-04-08 16:51:14.826  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:51:29.106  INFO 90471 --- [nio-8080-exec-4] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:51:29.107  INFO 90471 --- [pool-1-thread-1] c.t.a.s.i.client.AnalysisModuleClient    : Auto-define request to module-analysis for system 1
2022-04-08 16:51:29.108  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:51:29.108  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis :  Finished logic module auto define
2022-04-08 16:51:29.108  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:51:29.111  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : **************************************************************************
2022-04-08 16:51:29.111  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       :  Begin calculate and persist Level 2 Metric in systemId 1
2022-04-08 16:51:29.111  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : **************************************************************************
2022-04-08 16:51:29.248  INFO 90471 --- [-1 @coroutine#3] c.t.a.s.a.MetricPersistApplService       : Finished calculate methodMetric in systemId 1
2022-04-08 16:51:29.252  INFO 90471 --- [-1 @coroutine#3] c.t.a.s.i.m.MethodMetricRepositoryImpl   : Delete system method metric old data with id: 1
2022-04-08 16:51:29.252  WARN 90471 --- [-1 @coroutine#3] c.t.a.s.i.m.MethodMetricRepositoryImpl   : Insert system method metric new data with id is empty!: 1
2022-04-08 16:51:29.252  INFO 90471 --- [-1 @coroutine#3] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:29.252  INFO 90471 --- [-1 @coroutine#3] c.t.a.s.a.MetricPersistApplService       : Finished persist method Metric to mysql for in systemId 1
2022-04-08 16:51:29.252  INFO 90471 --- [-1 @coroutine#3] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:31.569  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.a.MetricPersistApplService       : Finished calculate packageMetric in systemId 1
2022-04-08 16:51:31.573  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.i.m.ModuleMetricRepositoryImpl   : Delete system package metric old data with id: 1
2022-04-08 16:51:31.595  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.i.m.ModuleMetricRepositoryImpl   : Insert system package metric new data with id: 1
2022-04-08 16:51:31.595  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:31.595  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.a.MetricPersistApplService       : Finished persist package Metric to mysql for systemId 1
2022-04-08 16:51:31.595  INFO 90471 --- [-1 @coroutine#4] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:33.911  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.a.MetricPersistApplService       : Finished calculate moduleMetric in systemId 1
2022-04-08 16:51:33.914  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.i.m.ModuleMetricRepositoryImpl   : Delete system module metric old data with id: 1
2022-04-08 16:51:33.919  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.i.m.ModuleMetricRepositoryImpl   : Insert system module metric new data with id: 1
2022-04-08 16:51:33.919  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:33.919  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.a.MetricPersistApplService       : Finished persist module Metric to mysql for systemId 1
2022-04-08 16:51:33.919  INFO 90471 --- [-1 @coroutine#5] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:51:56.265  INFO 90471 --- [-1 @coroutine#6] c.t.a.s.domain.service.DitService        : Finish calculate all DIT, count: 6600
2022-04-08 16:52:21.301  INFO 90471 --- [-1 @coroutine#7] c.t.a.s.domain.service.NocService        : Finish calculate all noc, count: 6600
2022-04-08 16:52:38.335  INFO 90471 --- [-1 @coroutine#8] c.t.a.s.domain.service.LCOM4Service      : Finish calculate all lcom4, count: 6600
2022-04-08 16:52:38.733  INFO 90471 --- [-1 @coroutine#2] c.t.a.s.i.m.ClassMetricRepositoryImpl    : Delete system class metric old data with id: 1
2022-04-08 16:52:39.958  INFO 90471 --- [-1 @coroutine#2] c.t.a.s.i.m.ClassMetricRepositoryImpl    : Insert system class metric new data with id: 1
2022-04-08 16:52:39.958  INFO 90471 --- [-1 @coroutine#2] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:52:39.958  INFO 90471 --- [-1 @coroutine#2] c.t.a.s.a.MetricPersistApplService       : Finished persist class Metric to mysql for systemId 1
2022-04-08 16:52:39.958  INFO 90471 --- [-1 @coroutine#2] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:52:42.313  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist moduleCircularDependency in systemId 1
2022-04-08 16:52:44.676  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist packageCircularDependency in systemId 1
2022-04-08 16:52:52.451  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist classCircularDependency in systemId 1
2022-04-08 16:52:52.461  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist methodCircularDependency in systemId 1
2022-04-08 16:52:52.461  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:52:52.461  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist circularDependenciesCount for systemId 1
2022-04-08 16:52:52.461  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:53:12.301  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:53:12.301  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : Finished persist data class Metric for systemId 1
2022-04-08 16:53:12.301  INFO 90471 --- [pool-1-thread-1] c.t.a.s.a.MetricPersistApplService       : -----------------------------------------------------------------------
2022-04-08 16:53:37.145  INFO 90471 --- [pool-1-thread-1] c.t.a.s.i.client.Scanner2Client          : send metrics analysis request to module service
2022-04-08 16:53:37.145  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:53:37.145  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis :  Finished level 2 analysis metrics
2022-04-08 16:53:37.145  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:53:37.665  INFO 90471 --- [nio-8080-exec-6] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:53:37.765  INFO 90471 --- [nio-8080-exec-6] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:53:37.815  INFO 90471 --- [nio-8080-exec-6] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:53:37.835  INFO 90471 --- [nio-8080-exec-6] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:53:37.915  INFO 90471 --- [nio-8080-exec-6] c.t.a.m.i.influx.InfluxDBClient          : save metrics to InfluxDB
2022-04-08 16:53:37.917  INFO 90471 --- [pool-1-thread-1] c.t.a.s.i.client.AnalysisModuleClient    : BadSmellDashboard saved for system 1
2022-04-08 16:53:37.917  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:53:37.917  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis :  Finished bad smell dashboard
2022-04-08 16:53:37.917  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : ************************************
2022-04-08 16:53:37.917  INFO 90471 --- [pool-1-thread-1] t.a.s.d.a.ArchitectureDependencyAnalysis : SET SYSTEM INFO 1 SCAN FLAG TO :SCANNED
```

## Thanks

JetBrains support:

![JetBrains Logo (Main) logo](https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.svg)

