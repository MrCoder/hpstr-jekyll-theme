---
layout: post
title: "What is NoSQL"
description: ""
category: Tech
tags: [tech, database]
---


# What is NoSQL and Why

I have not touched NoSQL since finished the spike for myTaxes. Since we are going to use MongoDB or Redis in the Nanki
project. Let's revisit it here.

## The CAP theorem

The [CAP theorem](http://www.julianbrowne.com/article/viewer/brewers-cap-theorem)  states that among Consistency, Availability
and Partition tolerance, you can only pick two.

In Chinese, below:
这三项分别是一致性、可访问性和分区容忍。而在DB设计中我们最多只能保证其中的两项。比如我们要去GoDaddy上注册域名。因为每个域名只能有一个人购买，
我们必须保证在Checkou的一刻，所有人得到的状态是一致的（并且Checkout这个动作是原子的），这就是Consistency。他们当然也需要所有的客户总是
可以访问他们的网站（并间接访问到他们的数据库），这就是Availability。另外，由于GoDaddy业务的迅速扩张，他们可能还希望可以快速
简单的横向扩展数据库，这就是Partition tolerance。
可惜的是，理论上这三条最多只能同时满足两条。作为一种不严谨的解释，我们可以这样分析一下其中的原因：

1. 当满足P的时候，必不可能同时满足CA。因为数据处于不同的服务器上面，我们为了让所有的用户看到一致的数据（C），必然需要时间去做同步。这样就不能
保证对用户总是可访问（A）。相反如果我们要保证所有的用户总是可访问，那么在数据完成同步之前，必然有一些用户看到的数据跟另一些用户看到的不同。
1. 当满足C的时候，必不可能同时满足AP。因为既然要求所用用户看到的数据都是一致的，要么只有一份数据（不满足P），要么给足够的时间去做同步（不满足A）。
1. 同样道理，当满足A的时候，也不可能同时满足CP。

As NoSQL focuses on solving horizontal scalebility problem, P is a must-have feature. So there are two different flavors of NoSQL:

1. `CP` NoSQL. BigTable, MongoDB, Redis, etc. Some data may not be accessible, but the rest is still consitent/accurate.一份数据
   通常只有一个备份。
1. `AP` NoSQL. Dynamo, Cassandra, CouchDB, etc. System are still available under partitioning, but some of the data returned
   may be inaccurate. 'Eventual Consistency' can be achieved through replication and verification.

\* Relation DB statisefy CA requirement. So they are single site cluster. When partition occurs, system blocks.

![CAP Theorem and NoSQL Databases](/images/NoSQL-CAP-Theorem.png)
From: http://blog.nahurst.com/visual-guide-to-nosql-systems

上图中的举例指的都是默认配置，有些DB在不同的配置中可以实现不同的偏好。比如，Terrastore在默认情况，如果Server连不上DB并不会尝试连接到master(s)。
但是它也可以server-to-mater reconnection参数，指定在给定的时间窗内尝试重连master。这时候Terrastor就是CA模式，因为Availability被保证了。

既然，CAP都是我们希望得到的，而又不可能同时全部得到。那么，总会有一些方案去解决或者缓和自身的缺陷。

1. 对于`CA`（传统RDB）来说，一般采用replication的方式来实现partition，即多台机器持有部分重复的数据。
1. 对于`CP`来说，一般
1. 对于`AP`来说，一般通过replication+verification的方式来保证最终一致性（Eventual Consistency）。

NoSQL database can also be grouped with how the data is stored: Document Oriented, XML, Graph, Key-Value.