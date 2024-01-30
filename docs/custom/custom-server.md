---
layout: default
title: Custom Server
parent: Custom
nav_order: 13
permalink: /custom/custom-server
---

ArchGuard 采用的是 CS 架构，所以在分析数据时，需要通过 Scanner CLI + JSON 的方式，将数据传递给 Server 进行分析。
因此，你可以通过自定义 Server 来实现自己的数据分析逻辑。

> 即：基于 Scanner 接口，实现独立 Server API

# Rust 语言：[CoUnit 示例](https://github.com/unit-mesh/co-unit)

> CoUnit，一个基于 LLM 的虚拟团队接口人（API），通过向量化文档、知识库、SDK和 API 等，
> 结合 LLM 智能化团队间对接与协作。

## Rust Server example

```rust
pub fn router() -> Router {
   use axum::routing::*;
   Router::new()
       .route("/:systemId/reporting/class-items", post(save_class_items))
       .route("/:systemId/reporting/container-services", post(save_container))
       .route("/:systemId/reporting/datamap-relations", post(save_datamap))
       .route("/:systemId/reporting/openapi", post(save_openapi))
}
```