---
layout: default
title: Architecture
parent: Setup
nav_order: 8
has_children: true
permalink: /setup/architecture
---

Full Workflow:

![](/assets/diagrams/ArchGuard.drawio.svg)

## Relations

1. analysis code
2. create code basic info:
    - "code_class",
    - "code_field",
    - "code_method",
    - "code_annotation",
    - "code_annotation_value",
3. create code relations:
    - "code_ref_class_fields",
    - "code_ref_class_methods",
    - "code_ref_class_parent",
    - "code_ref_class_fields",
    - "code_ref_method_callees",
    - "code_ref_class_dependencies",
4. create container (HTTP API) level info:
    - "container_demand"    for used HTTP API
    - "container_resource"  for provide HTTP API
    - "container_service"   container info
5. create database from code to sql
    - "data_code_database_relation" for MySQL

## Data Flow

![Data Flow](/assets/diagrams/archguard-process.svg)

ArchGuard 可视化工作流

1. 对源码进行 AST 分析，得到 Chapi 的类 AST 模型
2. 对 AST 中的框架等信息进行识别
3. 结合 SCM (版本控制管理) 工具分析变更上下文
4. 将数据放入 ArchGuard 后端数据库

ArchGuard 守护工具流

1. 对源码进行 AST 分析，得到 Chapi 的类 AST 模型
2. 对 AST 中的框架等信息进行识别
3. 结合 SCM (版本控制管理) 工具分析变更上下文
4. 配置守护规则
5. 在持续集成中,运行守护
