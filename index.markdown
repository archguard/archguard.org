---
title: "ArchGuard"
layout: splash
header:
  overlay_filter: "rgba(99, 183, 175, 0.7)"
  overlay_image: /assets/images/background.jpg
  actions:
    - label: "了解更多"
      url: "https://github.com/archguard"
excerpt: "国内首个开源架构治理平台工具，专治分布式场景下各种不服"
intro1: 
  - excerpt: "我们所面临的挑战"
feature_row1:
  - title: "设计与实现不匹配"
    excerpt: "设计的软件架构与真正实施后的架构，存在着巨大的差异。<br>而这个差异，往往需要编码上线、乃至一段时间之后才能发现"
  - title: "没有规范 or 不遵守规范"
    excerpt: "作为一个资深的开发人员，我们制定了一系列的规范，但是没有多少团队人员愿意遵守"
  - title: "代码量巨大，难以识别问题"
    excerpt: "一个由十几个或者几十个微服务创建的系统，往往难以快速发现它们之间错综复杂的关系"
  - title: "架构模型的每个层级都可能出错"
    excerpt: "如服务间 API 耦合、代码间耦合、数据库耦合等等"
  - title: "架构师、开发人员自身缺乏丰富的经验"
    excerpt: "知道有问题，但是说不出来哪有问题，也不知道如何改进"
intro2: 
  - image_path: /assets/images/title1.jpg
feature_row2:
  - image_path: /assets/images/assessment.png
    title: "帮助您精准的做投资决策，提高投资性价比"
    excerpt: 'ArchGuard以业务价值为导向，对系统的项目的各个方面进行扫描评估，助力用户找到系统存在的薄弱环节'
    url: "/models/evaluate-strategic/"
    btn_label: "架构评估"
    btn_class: "btn--primary"
feature_row3:
  - image_path: /assets/images/tools.png
    title: "帮助您高效的改造系统，降低改造门槛"
    excerpt: '通过多年ThoughtWorks改造经验总结，ArchGuard基于您系统的问题，向您推荐最适合的改造工具（自研/三方），自动，高效，安全的进行改造'
    url: "/models/transform-strategic/"
    btn_label: "架构改造"
    btn_class: "btn--primary"
feature_row4:
  - image_path: /assets/images/guard.png
    title: "帮助您持续的守护系统，减缓系统腐化"
    excerpt: 'ArchGuard支持个性化配置标准，在系统全生命周期及时预警，及时纠偏，以减缓系统腐化'
    url: "/models/guard-strategic/"
    btn_label: "架构守护"
    btn_class: "btn--primary"
---

{% include feature_row id="intro1" type="center" %}

{% include feature_row id="feature_row1" type="center" %}

{% include feature_row id="intro2" type="center" %}

{% include feature_row id="feature_row2" type="left" %}

{% include feature_row id="feature_row3" type="right" %}

{% include feature_row id="feature_row4" type="left" %}
