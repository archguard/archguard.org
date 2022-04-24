---
layout: default
title: Web API 规则
parent: Governance
nav_order: 2
has_children: true
permalink: /governance/web-api
---

```
val CRUD = arrayOf("create", "update", "refresh", "delete", "get", "put", "set")
```

## EndWithoutCrudRule

URL 不应该以 CRUD 结尾

错误示例： `/api/book/delete`

## NotUppercaseRule

URL 中不应该包含大写，应该使用 `-` 的方式，

正确示例： `/api/services-map`

## StartWithoutCrudRule

URL 不应该以 CURD 开头

错误示例： `/api/getbook`

## SpliceNamingRule

单个单词的长度应该受限制，默认：20

错误示例： `/api/getbookauthornameandtitle`
