---
layout: default
title: Architecture
parent: Development
nav_order: 8
has_children: true
permalink: /development/architecture
---

Workflow:

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

