---
layout: default
title: Web API 规则
parent: Governance
nav_order: 2
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

## NoHttpMethodInUrl

URL 中不应该包含 HTTP 方法。

错误示例：  `/api/book/delete/{bookId}`

## MinFeatureApiRule

> 让每个程序只做好一件事。要完成一项工作，构造全新的比在复杂的旧程序里添加新特性更好。 —— McIlroy, Pinson 和 Tague。

—— 《Google 系统架构解密：构建安全可靠的系统》

## MultipleParametersRule

URL 中包含了多个参数（默认值 3）

