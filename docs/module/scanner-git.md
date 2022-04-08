---
layout: default
parent: Modules
title:  "Git 与语言分析"
permalink: /modules/scanner/git
---

Scan Git 的主要功能：

- 提交记录日记历史（）。包含提交时间、提交人等基本信息
- 变更事项（ChangeEntry）。
- 文件行数计算。参照 CLOC 库里 [SCC](https://github.com/boyter/scc) 的根据语言进行行数计算。
- 方法、类的行数计算（原先的功能，待删除）。通过对 Java、Kotlin 进行语法解析，来生成行数数据。 

待完善功能：

- 基于 SCC 的认知复杂度。未来可以通过 SCC 的相关功能，替换掉这部分功能。

## 高频变更

高频变更主要是通过行数 + Git 的修改资料来进行可视化，添加了一个新的功能：打开文件，统计行数。

唯一有区别的是：统计的文件只会来源于 Git 历史中的文件。因此，是否编译不会被影响。

## 语言识别

语言的识别基于：[https://github.com/boyter/scc](https://github.com/boyter/scc)，从中剥离出 [languages.json](https://github.com/archguard/scanner/blob/master/scan_git/src/main/resources/languages.json) 文件。

在 SCC 的设计中，主要是根据后缀名来识别：

1. 如果是形如 `.gitignore` 的这种 `.` 开头文件，则会识别看是否在 languages map 中有对应的类型。
2. 取文件后续，会判断是否有双后续，即如 `types.d.ts` 的形式，如果有的话，则会返回 `.d.ts`，则不是正常的 `.ts` 文件
3. 其他情况，如 shebang 文件，会在 scc 处理，但是不会在 scan_Git 处理
