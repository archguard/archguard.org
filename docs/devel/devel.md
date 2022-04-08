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

系统组成：

- [x] [ArchGuard backend](https://github.com/archguard/archguard-backend) - connect scanner and show data.
- [x] [ArchGuard scanner](https://github.com/archguard/scanner/)  - scan source code, binary date and othes, and feed to database.
- [x] [ArchGuard frontend](https://github.com/archguard/archguard-frontend) - visualization results & dashboard
- [x] [Chapi Code analysis](https://github.com/modernizing/chapi) - Chapi is A common language meta information convertor, convert different languages to same meta-data model.

## Local setup

requirements: 

- JDK 12+
- InfluxDB 1.8.x

### database setup

1. Local mysql, or docker created
- `docker pull mysql:8`
- `docker run --name=mysql -it -p 3306:3306 -e MYSQL_ROOT_PASSWORD=password -d mysql`
2. Create archguard database
- `create database archguard default character set utf8mb4 collate utf8mb4_unicode_ci;`
- `./gradlew -Dflyway.configFiles=flyway.conf flywayMigrate` (probably not needed)

### run

`./gradlew bootrun`

## 独立启动其它组件

InfluxDB

```
docker run -d -p 8186:8086 --name influxdb \
      -v ~/ArchGuard/data/influxdb:/var/lib/influxdb \
      -e INFLUXDB_INIT_USERNAME=admin \
      -e INFLUXDB_INIT_PASSWORD=admin \
      -e INFLUXDB_DB=db0 \
      influxdb:1.8
```

MySQL

```
docker run -d -p 13308:3306 --name archguard-mysql \
      -v ~/ArchGuard/data/mysql:/var/lib/mysql:rw \
      -e MYSQL_ROOT_PASSWORD=prisma \
      -e MYSQL_DATABASE=archguard \
      -e TZ=Asia/Shanghai \
      mysql --default-authentication-plugin=mysql_native_password
```
