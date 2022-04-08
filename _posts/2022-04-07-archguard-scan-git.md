---
layout: default
title:  "ArchGuard Scan Git 模块介绍"
categories:
- Blog
- ArchGuard
---

Scan Git 的主要功能：

- 提交记录日记历史（）。包含提交时间、提交人等基本信息
- 变更事项（ChangeEntry）。
    - [ ] 认知复杂度。通过 AST 计算进行计算。(未来可以通过 SCC 的相关功能，替换掉这部分功能。)
- 文件行数计算。参照 CLOC 库里 [SCC](https://github.com/boyter/scc) 的根据语言进行行数计算。
- 方法、类的行数计算（原先的功能，待删除）。通过对 Java、Kotlin 进行语法解析，来生成行数数据。 

待完善功能：


- 基于 SCC 的认知复杂度。未来可以通过 SCC 的相关功能，替换掉这部分功能。
