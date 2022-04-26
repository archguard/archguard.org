---
layout: default
title: SQL
parent: Governance
nav_order: 1
permalink: /governance/sql
---

## unknown-column-size

className: org.archguard.linter.rule.sql.rules.UnknownColumnSizeRule

description: 禁止使用 SELECT * 进行查询。建议按需求选择合适的字段列，杜绝直接 SELECT * 读取全部字段，减少网络带宽消耗，有效利用覆盖索引；

severity: BLOCKER

## like-start-without-percent

className: org.archguard.linter.rule.sql.rules.LikeStartWithoutPercentRule

description: 使用 like 模糊匹配时，查找字符串中通配符 % 放首位会导致无法使用索引。

severity: INFO

## limit-table-name-length

className: org.archguard.linter.rule.sql.rules.create.LimitTableNameLengthRule

description: 表名应该小于 32 个字符

severity: INFO

## snake-case-naming

className: org.archguard.linter.rule.sql.rules.create.SnakeCaseNamingRule

description: 表名应该使用 _ 来命名。

severity: INFO

## insert-without-field

className: org.archguard.linter.rule.sql.rules.insert.InsertWithoutField

description: INSERT 应该包含字段键名。

severity: BLOCKER

suggest: 正确示例：`INSERT INTO system (`name`) VALUES ('archguard');`


## limit-joins

className: org.archguard.linter.rule.sql.rules.expression.LimitJoinsRule

description: 建议 JOIN 的表不要超过 5 个，JOIN 多表查询比较耗时时间，关联的表越多越耗时间，防止执行超时或死锁。

severity: BLOCKER

## at-least-one-primary-key

className: org.archguard.linter.rule.sql.rules.create.AtLeastOnePrimaryKeyRule

description: 至少包含一个 Primary Key。

severity: WARN

## limit-column-size

className: org.archguard.linter.rule.sql.rules.create.LimitColumnSizeRule

description: 表的字段应该控制在 20 以内。

severity: INFO

