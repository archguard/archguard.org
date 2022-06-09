---
layout: default
title: ArchGuard
nav_order: 1
description: "ArchGuard 是一个针对于微服务（分布式场景）下的架构工作台/治理工具。它可以在开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。"
permalink: /
---

![Logo](/assets/images/logo.png)

ArchGuard 是一个针对于微服务（分布式场景）下的架构工作台/治理工具。它可以在开发过程中，帮助架构师、开发人员分析系统间的远程服务依赖情况、数据库依赖、API 依赖等。并根据一些架构治理模型，对现有系统提出改进建议。

特性（Features）：

- 设计态架构：
  - 架构工作台
- 开发态分析
  - 容器间：数据库地图
  - 容器间：精准测试/变化分析
  - 容器级别依赖分析（当前支持 HTTP API）。API 生产者支持语言：Java、Kotlin、C#，API 消费者支持语言：TypeScript/JavaScript、Kotlin、Java 等。
    - HTTP API 使用清单、调用清单
      - HTTP API 依赖可视化分析
  - 容器内 
    - 代码行数分析。
      - 系统不稳定性模块分析。
      - 代码间依赖分析。支持级别模块、包、类、方法四个级别。
- 开发态治理
  - 五大维度架构质量评估以及对应的指标分析。
      - 体量维度。过大的包、类、方法、模块
      - 耦合维度。枢纽模块、包、类、方法，数据泥团、过深继承、循环依赖
      - 内聚维度。霰弹式修改、数据类
      - 冗余维度。冗余元素、过度泛化
      - 质量维度（Java）。包含休眠的测试、被忽略的测试、缺乏校验的测试、包含繁杂判断的测试、包含冗余打印的测试、静态方法
- 运行态分析（TODO）

Features：

- Container-level dependency analysis (currently supports HTTP API). API Producer Support Language: Java, Kotlin, C#, API Consumer Support Language: TypeScript/JavaScript
    - HTTP API usage list, call list
    - HTTP API visual analysis
- Quality assessment and indicator analysis of various dimensions.
    - Mass dimension. Oversized packages, classes, modules
    - Coupling method. Method modules, packages, classes, mud balls, deep inheritance, data circular dependencies
    - Cohesive dimensions. Shotgun Modifications, Data Classes
    - Premium. Over Generalization
    - Quality dimension (Java). Tests Included, Tests Included, Tests Included, Tests Included
- Code bad smell. Common.
- other related overviews
    - Code dependency analysis. Class, package, class, method classes are supported.
    - Lines of code analysis.
    - System instability module analysis.
- Database map
- Precise testing/variation analysis

Online Demo: coming soon

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
