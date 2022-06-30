---
layout: default
title: Custom Rules
parent: Custom
nav_order: 11
permalink: /custom/custom-rule
---

治理规则定义了围绕于某一类（特定）架构关注点的标准。

# 自定义治理规则

规则基于 [Slot](/custom/custom-slot) 来定义的，示例：

- [rule-linter/rule-sql](https://github.com/archguard/archguard/tree/master/rule-linter/rule-sql)
- [rule-linter/rule-test](https://github.com/archguard/archguard/tree/master/rule-linter/rule-test)
- [rule-linter/rule-webapi](https://github.com/archguard/archguard/tree/master/rule-linter/rule-webapi)
                         
其中，主要的接口是：

- Rule，定义数据的访问顺序和流程，用于优化效率。
- RuleSetProvider，用于提供规则集。
- RuleVisitor，用于访问规则集和数据。
- RuleSlot，定义规则对数据的处理流程。

工程目录结果示例：

```bash
├── TbsRule.kt                   
├── TestSmellRuleSetProvider.kt
├── TestSmellRuleSlot.kt
├── TestSmellRuleVisitor.kt
└── rules                          # 规则集目录
    ├── DuplicateAssertRule.kt
    ├── EmptyTestRule.kt
    ├── NoIgnoreTestRule.kt
    ├── RedundantAssertionRule.kt
    ├── RedundantPrintRule.kt
    ├── SleepyTestRule.kt
    └── UnknownTestRule.kt
```

注意，需要创建对应的 Service：

- resources/META-INF/services/org.archguard.meta.Slot
- resources/META-INF/services/org.archguard.rule.core.RuleSetProvider
- resources/META-INF/services/org.archguard.rule.core.RuleVisitor
