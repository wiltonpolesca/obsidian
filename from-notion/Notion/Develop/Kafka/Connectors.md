---

---
Rename kafka property to match to existing table

[https://stackoverflow.com/questions/64938383/kafka-jdbc-sink-connector-for-a-existing-table-with-different-column-names](https://stackoverflow.com/questions/64938383/kafka-jdbc-sink-connector-for-a-existing-table-with-different-column-names)

MQTT

- [https://github.com/johanvandevenne/kafka-connect-mqtt](https://github.com/johanvandevenne/kafka-connect-mqtt)

avsc docs

- [https://avro.apache.org/docs/current/spec.html](https://avro.apache.org/docs/current/spec.html)

- [https://avro.apache.org/docs/1.10.0/spec.html#UUID](https://avro.apache.org/docs/1.10.0/spec.html#UUID)

How to generate C# class from avsc file

. [https://www.nuget.org/packages/Apache.Avro.Tools/](https://www.nuget.org/packages/Apache.Avro.Tools/)

- avrogen -s <<proto-file>> <<directory>>

Date and time/timespan

. [https://developer.confluent.io/tutorials/connect-sink-timestamp/ksql.html](https://developer.confluent.io/tutorials/connect-sink-timestamp/ksql.html)

Transform un object to jsonb value (kafka -> postgres)

- [https://github.com/confluentinc/kafka-connect-jdbc/issues/46#issuecomment-730532792](https://github.com/confluentinc/kafka-connect-jdbc/issues/46#issuecomment-730532792)

Muitliples topics using only one config (example)

- [https://docs.datastax.com/en/kafka/doc/kafka/kafkaMultTopicToTables.html](https://docs.datastax.com/en/kafka/doc/kafka/kafkaMultTopicToTables.html)

- [https://docs.datastax.com/en/kafka/doc/kafka/install/kafkaInstall.html](https://docs.datastax.com/en/kafka/doc/kafka/install/kafkaInstall.html)

Kafka connector

. 8083 => kafka-connector port

- configs

. [https://developer.aiven.io/docs/products/kafka/kafka-connect/howto/jdbc-sink](https://developer.aiven.io/docs/products/kafka/kafka-connect/howto/jdbc-sink)

- To add a new configuration to kafka connector

. POST => http://localhost:8083/connectors

- To get the current configs

. GET => http://localhost:8083/connectors

- To delete a config

. DELETE => http://localhost:8083/connectors/<<config-name>>/