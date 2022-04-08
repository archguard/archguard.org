---
layout: default
title: Development
nav_order: 8
has_children: true
permalink: /development
---

- languages：Kotlin
- frameworks：Spring Boot，JDBI
- test frameworks：Junit5，Spring Boot Test，Flyway，H2
- build tool：Gradle
- data storage：MySQL, InfluxDB

## Local setup

requirements: JDK 12+

### database setup

1. Local mysql, or docker created
- `docker pull mysql:8`
- `docker run --name=mysql -it -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql`
2. Create archguard database
- `create database archguard default character set utf8mb4 collate utf8mb4_unicode_ci;`
- `./gradlew -Dflyway.configFiles=flyway.conf flywayMigrate` (probably not needed)

### run

`./gradlew bootrun`
