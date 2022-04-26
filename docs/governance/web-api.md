---
layout: default
title: Web API
parent: Governance
nav_order: 99
permalink: /governance/web-api
---

## splice-naming

className: org.archguard.linter.rule.webapi.rules.SpliceNamingRule

description: API 应该采用 - 的方式命名，单个资源的长度通常不超过 20 字符。

## no-crud-end

className: org.archguard.linter.rule.webapi.rules.NoCrudEndRule

description: URL 不应该以 CRUD 结尾，错误的方式 `/api/book/get`，正确的方式： `GET /api/book`

## not-uppercase

className: org.archguard.linter.rule.webapi.rules.NotUppercaseRule

description: URL 中不应该包含大写字符。

## start-without-crud

className: org.archguard.linter.rule.webapi.rules.StartWithoutCrudRule

description: URL 不应该以 CRUD 开头。错误示例： `/api/getbook`， 正确示例： `GET /api/book`

## no-http-method-in-url

className: org.archguard.linter.rule.webapi.rules.NoHttpMethodInUrlRule

description: URL 中不应该包含 CRUD 方法。

## min-feature

className: org.archguard.linter.rule.webapi.rules.MinFeatureApiRule

description: API 应该保持单一职责的原则，一个 API 只做一件事。

suggest: > 让每个程序只做好一件事。要完成一项工作，构造全新的比在复杂的旧程序里添加新特性更好。 —— McIlroy, Pinson 和 Tague。

—— 《Google 系统架构解密：构建安全可靠的系统》


## multiple-parameters

className: org.archguard.linter.rule.webapi.rules.MultipleParametersRule

description: URL 中的参数不宜超过 3 个，可以放到 body 中。错误示例：/api/book/{bookType}/{bookId}/{bookChildType}/{childId}

