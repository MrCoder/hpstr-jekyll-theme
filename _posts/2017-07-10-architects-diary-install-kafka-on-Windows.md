---
layout: post
title: "20170710 Architect's Diary - Install Kafka on Windows"
description: "Kafak installation on Windows"
category: Kafka
tags: [Kafka, Windows]
---

## Download

Download release 0.11.0.0 from [https://kafka.apache.org/downloads]. Unzip it.

## Start ZooKeeper

ZooKeeper is included in the above package. See `ROOT\libs\zookeeper-3.4.6.jar`.

````
> .\bin\windows\zookeeper-server-start.bat config\zookeeper.properties
````

## Start Kafka

````
bin\windows\kafka-server-start.bat config\server.properties
````

## Create a topic

````
 bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic test
 Created topic "test".
````

> List topics
> `bin\windows\kafka-topics.bat --list --zookeeper localhost:2181`

## Send a message
````
λ bin\windows\kafka-console-producer.bat --broker-list localhost:9092 --topic test
>This is a test message
>This is another test message
````

## Start a consumer
````
bin\windows\kafka-console-consumer.bat --bootstrap-server localhost:9092 --topic test --from-beginning
````

## Setting up a multi-broker cluster
### Edit the new configuration files
````
copy config\server.properties config\server-1.properties
copy config\server.properties config\server-2.properties

config/server-1.properties
  broker.id=1
  listeners=PLAINTEXT://:9093
  log.dir=/tmp/kafka-log-1

config/server-2.properties
  broker.id=2
  listeners=PLAINTEXT://:9094
  log.dir=/tmp/kafka-log-2
````

> Note: For `log.dir`, use Linux style path.

### Start server-1 and server-2

````
bin\windows\kafka-server-start.bat config\server-1.properties
bin\windows\kafka-server-start.bat config\server-2.properties
````

### Create a topic
````
λ bin\windows\kafka-topics.bat --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic my-replica
ted-topic
Created topic "my-replicated-topic".
````

### Describe a topic

````
λ bin\windows\kafka-topics.bat --describe --zookeeper localhost:2181 --topic my-replicated-topic
Topic:my-replicated-topic       PartitionCount:1        ReplicationFactor:3     Configs:
        Topic: my-replicated-topic      Partition: 0    Leader: 2       Replicas: 2,0,1 Isr: 2,0,1
````

> Note: If you kill one node, you will notice a difference in `Isr: 2,0,1`
