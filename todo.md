# inbox
陈恒课程day01 ~ day16思维导图已记完
当前课程day04, day05（除dubbo高级特性以外）已记完

# to-do:

- alibaba sentinel @SentinelResource的原理
- 跨域问题一定是由前端的异步请求引发的吗
- 了解一般讲述项目时应该讲哪些方面，然后对已经学过的项目做相应的准备
- 通过阅读Spring的源码了解Bean的创建和获取过程是怎么样的
- 为什噩梦Redis包含16个数据库
- Redis是如何与MySQL同步的
- 使用Redis+JWT保存登录信息相对于使用session而言有什么优点
- 更全面了解内部类和注解的定义
- Java类型转换的底层原理
- 什么时候即使使用了索引，查询速度仍旧比较慢？
- Nginx有什么作用，怎么配置与应用？
- mysql原理
- 看java guide是否有必要看
- spring mvc请求参数匹配原理
- mybatis中mapper xml中为什么要写resultType?什么情况下不写会出错?
- 理解前后端分离，理解使用JSP、Thymeleaf、CDN提供的vue以及本地vue的区别
- 记录全局异常处理器的笔记，理解@ExceptionHandler的原理
- 为什么position:absolute的元素的位置会相对于带position:relative的上级元素？
- 为什么需要redo log来恢复物理数据页，而不能只用binlog来恢复，除了效率问题之外有其他原因吗？
- 看猎才mysql文档
- ConcurrentHashMap的源码
- MySQL优化
- 彻底理解索引的原理
- 如何解释三次握手和四次挥手
- 理解Bean生命周期
- 熟悉mini HTTP服务器的整个项目结构(并理解它与springmvc执行流程的关系)
- 看完这一页：https://mybatis.org/mybatis-3/zh/dynamic-sql.html
- log4j, slf4j的区别
- Spring @ControllerAdvice, @ExceptionHandler的原理
- Spring controller接受各种类型参数提取请求参数的原理
- Exception.getFieldError().getDefaultMessage()?
- 整理数据库和Spring笔记(mysql.xmind, ssm.xmind, 检查思维导图中每一条是否完善，有时间时检查思维导图是否已包含所有知识点)
- 理解NIO: Channel，Selector，如何连接，发送和接收
- 熟悉RPC代码
- 看廖雪峰网站上JDBC相关补充至思维导图
- 跟着廖雪峰教程手写Spring
- 根据illustration.xmind进行讲解练习
- 熟练使用代码实现各种排序算法
- 使用嵌套循环和外联内联的不同场合
- k8s

---
面试真题:
https://a0d32fgj7nu.feishu.cn/docx/NfjgdhYDZoBdUux6oSBcbaNgn6e

---
mysql manual:
https://dev.mysql.com/doc/refman/8.0/en/innodb-multi-versioning.html

---
MySQL数据库技术
https://yscp0bp3g6.feishu.cn/docx/Dv0kdkOmdofUhDx53VNch8mpnHg

数据库MySQL运维
https://gitee.com/houyworking/mysqlproject

MySQL MVCC课程设计
https://it38nc4nte.feishu.cn/docx/SbB1dOAaJofDS2xHPPMcmyEWnEc

Spring
https://it38nc4nte.feishu.cn/docx/H6VzdpNvHo0lutxqraWcBKVBnNd

MyBatis
https://it38nc4nte.feishu.cn/docx/LLhgdSwvUoVcgCx5hf8c6fNmn75

互联网架构
https://yscp0bp3g6.feishu.cn/docx/M302d8B0bogziBxZPWjcS3ZhnZb

Linux:
https://yscp0bp3g6.feishu.cn/docx/ZYMSdetTdo7qVXxCiRoc0RNLnCW

Linux环境项目直接部署
https://yscp0bp3g6.feishu.cn/docx/YqCZdjXxLoIiUtxQCaIcy0kSnse

Linux环境项目部署Gitee:
https://gitee.com/JasonCN2008/jht

Docker技术应用
https://yscp0bp3g6.feishu.cn/docx/IuNdd9vKFonuSVxzCGHcaSq6njh

Redis:
https://yscp0bp3g6.feishu.cn/docx/A0sPdnjHFoKaaSxJeFicXDLAnag
- Redis的AOF持久化

工作项目峰会参考
https://it38nc4nte.feishu.cn/docx/KYgzdjpggolIBuxCdtMc4II2nmc

Arthas使用说明
https://it38nc4nte.feishu.cn/docx/Vow3dkjxwoZSODxclwsc6Ur6nqg

前端课程repository:
https://gitee.com/IvanLiuGB/jsd-06-03-teacher.git

---
Java开发招聘要求：
- 掌握Java基础
- 熟练掌握常用设计模式，具备通过良好的结构设计和领域建模来支撑复杂业务的能力
- 熟悉JVM
- SQL性能调优
- Spring、MyBatis、Redis
- 了解tomcat、spring等开源产品的原理
- 熟悉分布式、缓存、消息等机制
- 熟悉微服务框架和Spring Cloud
- 高并发、高性能的分布式系统的设计及应用、调优


---
Java基础：复习笔记
反射：复习笔记，查看Spring源码中对反射的应用
动态代理：查看Spring源码中对动态代理的应用
JVM内存结构、多线程：看《深入理解Java虚拟机》
设计模式：廖雪峰的网站，网上搜索每个设计模式的实际应用
MySQL：看《从根上理解MySQL》
Spring：看Java Guide，以及官方文档？
MyBatis：看Java Guide
数据结构：网上搜索优质文章

对学到的知识点，需要想想工作中哪里会用到，即应用场景，比如arraylist，hashmap等工作中是怎么用的。

---
分库分表(比如将不同业务的数据放到不同数据库)，ShardingSphere中间件
反向代理，请求分发到不同服务器，Nginx
Redis

---
在MySQL命令行导入SQL语句：
`source <sql-file>`

---
2023-10-10: 活动课，《简历制作》-PartA

