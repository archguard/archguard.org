---
layout: default
title: SQL 治理
parent: Governance
nav_order: 3
permalink: /governance/sql
---

相关资源：[SQL 开发规范及基本原则](https://docs.pingcap.com/zh/appdev/dev/basic-principles)

## UnknownNumberColumnRule

禁止使用 SELECT * 进行查询。建议按需求选择合适的字段列，杜绝直接 SELECT * 读取全部字段，减少网络带宽消耗，有效利用覆盖索引；

## LimitTableNameLength

多个单词以下划线分隔，不推荐超过32个字符；

## InsertWithoutField

禁止使用带有数据值却不带有字段键名的 `INSERT` 操作

```
INSERT INTO user VALUES ('alicfeng',23);
# 应该这样操作
INSERT INTO user (`username`,`age`) VALUES ('alicfeng',23);
```

## FuzzyPercentNotAtStartRule

使用 like 模糊匹配时，查找字符串中通配符 % 放首位会导致无法使用索引。

## LimitJoinsRule

建议 `JOIN` 的表不要超过5个，JOIN 多表查询比较耗时时间，关联的表越多越耗时间，防止执行超时或死锁。

## SnakeCasingRule

多个单词以下划线分隔。

## AtLeastOnePrimaryKeyRule

至少有一个 Primary key

## LimitColumnSizeRule

限制 Column 的数量，默认 20

