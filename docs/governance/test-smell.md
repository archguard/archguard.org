---
layout: default
title: Test smell
parent: Governance
nav_order: 2
permalink: /governance/test-smell
---

## empty-test

className: org.archguard.linter.rule.testcode.rules.EmptyTestRule

description: Test is without any code

## no-ignore-test

className: org.archguard.linter.rule.testcode.rules.NoIgnoreTestRule

description: 被忽略（Ignore、Disabled）的测试用例

suggest: 当需求修改导致测试用例失败、失效了，应该尽快修复或移除而不是忽略。

## sleep-test

className: org.archguard.linter.rule.testcode.rules.SleepyTestRule

description: 测试用例中包含 Sleep 休眠语句，常见于异步测试场景，或为了规避不同测试用例中某些操作的依赖和冲突。

suggest: 如 Robert C. Martin 在《代码整洁之道》所说的那样，好的测试应该是快速（Fast）、独立（Indendent）、可重复（Repeatable）、自足验证（Self-Validating）、及时（Timely）的
· 测试用例本身编写时，应该注意保持独立性，不同用例之前不要产生互相依赖、等待，尤其是不同用例使用的测试数据应该独立。
· 当处理异步测试场景时，建议使用 CompletableFuture 配合 CountDownLatch 的方式进行，从而不用硬编码休眠的时长。

## redundant-print

className: org.archguard.linter.rule.testcode.rules.RedundantPrintRule

description: 包含了过多调试打印信息的测试用例

suggest: 自动化测试用例中，应该使用自动的 Assert 语句，替代需要人眼观察的 Print

## redundant-assertion

className: org.archguard.linter.rule.testcode.rules.RedundantAssertionRule

description: The test is contains invalid assert, like assertEquals(true, true)

## unknown-test

className: org.archguard.linter.rule.testcode.rules.UnknownTestRule

description: 缺乏了自动校验的测试用例，这将无法达到自动验证结果的目的。

suggest: 为每个测试用例都添加足够的自动校验 Assert 语句

## duplicated-assert

className: org.archguard.linter.rule.testcode.rules.DuplicateAssertRule

description: 包含了过多 Assert 语句的测试用例

suggest: 建议每个测试用例聚焦于一个测试场景和目的，不要企图编写一个各种场景面面俱到的巨无霸测试，这将让后期的维护更加困难

