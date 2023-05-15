# Streaming architecture

## Scenario
Imagine we work in the data engineering department of a delivery company and we need to create a real time dashboard that shows the some KPIs related to orders. To build this, we will make use of a popular distributed streaming platform, Kafka, to produce, consume and stream the necessary orders events into S3 bucket in AVRO format so we can query with Apache Druid and visualize with Apache Superset.
All this will run in local using Docker containers. 
We will use [Confluent Kafka](https://developer.confluent.io/) and [Localstack](https://hub.docker.com/r/localstack/localstack) to mock S3 buckets.

![diagram](./architecture/diagram.png)
### Prerequisites

- Make sure you have [Docker](https://docs.docker.com/engine/install/) installed.

### Runbook

#### Start local environment

- Run `docker-compose up -d`
- Control center will be available in http://localhost:9021/
- Go to `Topics` in the left menu and will see order topic

#### Orders Topic
This topic has 2 [Kafka Conectors](https://docs.confluent.io/platform/current/connect/kafka_connectors.html)
1. Producer: [Datagen Source Connector](https://docs.confluent.io/kafka-connectors/datagen/current/overview.html) that is producing synthetic data and publishing into the topic
2. Consumer: [Amazon S3 Sink Connector](https://docs.confluent.io/kafka-connectors/s3-sink/current/overview.html) that consumes the messages from the topic and sink into AVRO files in `kafka-raw-landing` bucket every 15 minutes.

```Note: Sink interval time is set to 15 minutes but can be reduced, is just to avoid a huge amount of tiny files in the bucket and make easier for Druid```

