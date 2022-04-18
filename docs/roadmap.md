---
layout: default
title: FAQ
nav_order: 98
permalink: faq
---

see also in: [https://github.com/archguard/archguard/discussions/5](https://github.com/archguard/archguard/discussions/5)

## ArchGuard 1.0 Monolith application

this version is InnerSource only

## ArchGuard 2.0 Distributed (microservices) analysis

- [ ] Multiple Language
    - [x] with Chapi
    - [x] API declaration analysis
        - [x] Java/Kotlin
        - [x] C#
    - [x] API call analysis
        - [x] Java
        - [x] Kotlin (50%)
- [x] Summary
    - [x] Language Summary
    - [x] Unstable file
    - [x] API list
- [x] HTTP API dependencies analysis
    - [x] Java/Kotlin
        - [x] resource: Spring
        - [x] demand: RESTTemplate
    - [x] JavaScript/Typescript
        - [x] demand: Axios
        - [x] demand: Umi-Request
- [ ] RPC dependencies analysis
    - [ ] Dubbo 
- [x] Database analysis
    - [x] Java/Kotlin
        - [x] JDBI
        - [x] JPA
        - [x] Mybatis (XML)
- [x] Change analysis
    - [x] Git analysis
- [x] Debug log
    - [x] show log in frontend
- [ ] Refactor
    - [ ] Scanner
        - [x] Lint Rule Model
        - [ ] Test Bad Smell
        - [ ] Scanner Refactor to Plugins

## ArchGuard 3.0 Distributed Linter

- [ ] Continuous Integration API
- [ ] Distributed linter
    - [ ] API Linter（refs: [https://github.com/stoplightio/spectral](https://github.com/stoplightio/spectral)）
    - [ ] Database Linter
    - [ ] Architecture Linter (refs: [https://github.com/modernizing/guarding](https://github.com/modernizing/guarding)
- [ ] Custom rule engine
    - [ ] Rule DSL
    - [ ] online DSL editor

