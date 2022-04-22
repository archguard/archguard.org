---
layout: default
title: Contribute Code
parent: Contribute to Archguard
permalink: /contribute-code
nav_order: 8
---

Archguard 正在慢慢形成自己的社区，我们非常欢迎任何感兴趣的人能够贡献自己的代码。Archguard 社区使用 [pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests) 的流程进行开发。

## 在开始之前

为了避免大家的工作返工，我们不建议你在社区不知情的情况下直接发起 pull request，因为可能你的方案刚好跟社区相反，这可能导致在你的 pull request review 的过程中需要做大量的修改。

## Contribution 步骤

1. 如果你遇到了问题或者想要完成某一个新的功能，请先浏览对应 repo 的 issue 区域；
2. 如果你的问题或者想要实现的功能已经有一个类似的 issue，你可以检查该 issue 是否已经有人认领；
3. 如果没有的话你可以创建一个新的 issue；
4. 然后你可以在这个 issue 中与社区的成员讨论这个问题或功能的实现并认领这个 issue；
5. 在开发的过程中请遵循 [github workflow](https://docs.github.com/cn/get-started/quickstart/github-flow) 的规范，先在自己的 repo 中开发，之后发起 pull request 等待社区的 review。在未来我们会逐步完善我们的 CI/CD，请确保你的代码修改能够通过所有的 pipeline；
6. 在 review 的过程中社区可能会留下一些修改建议和讨论，在修改这些建议的过程中还请确保你的 pull request 持续 rebase 以保持代码的更新；
7. 当你的 pull request 被 approve 后代码将被自动合入 repo;
