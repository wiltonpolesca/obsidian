# Open Telemetry services and configurations

## Grafana

### About the image selected

The goal of this configuration is to have a good and consistent DEVELOPER environment, instead of to have many different services, it is using `grafana/otel-lgtm` image, it is a simple Opentelemetry backend.

The image already provides

| Component     | Purpose                          |
| ------------- | -------------------------------- |
| Grafana       | UI / Dashboards                  |
| Mimr          | Metric storage                   |
| Loki          | Logs storage                     |
| Tempo         | Traces storage                   |
| OTLP endpoint | Ingestion (metrics, logs, trace) |

>Note:
>If you need or would like something different, maybe will be better you select another image to use.

### Service commands


```yaml
  grafana:
    container_name: grafana
    image: grafana/otel-lgtm:latest
    environment:
      GF_AUTH_ANONYMOUS_ENABLED: "true"
      GF_AUTH_ANONYMOUS_ORG_ROLE: "Admin"
    ports:
      - "3000:3000"
      - "4318:4318"
    networks:
      - [[NETWORK NAME]]
```

### Service configurations

Available ports:
- 3000 # Grafana UI
- 4318 # OLTP HTTP

OpenTelemetry HTTP route:
- http://grafana-address:4318

---

## Database telemetry collector

In general, databases like PostgreSQL, MS Sql Server, Oracle and others do not have an internal mechanism to export telemetry by OLTP. To have it, an external collector is required.

This service will be responsible to access the databases it is monitoring, according to configuration, get the telemetry information and push it to grafana.

### Collector service

```yaml
  otelcollector:
    image: otel/opentelemetry-collector-contrib:latest
    container_name: otelcollector
    command: ["--config=/etc/otel/otel.yaml"]
    configs:
      - source: otel_config
        target: /etc/otel/otel.yaml
    depends_on:
      - grafana
      - [DATABASE services]
    networks:
      - [[NETWORK NAME]]
```

#### Collector service configuration

To avoid to have many different config files, a `config` section is added into the docker-compose file and it is used to config the service.
The following configuration is responsible to inform the `otel/opentelemetry-collector-contrib` how to connect to database it is going to monitoring and the frequency to get data.

```yaml
configs:

  otel_config:
    content: |
      receivers:
        oracledb:
          datasource: "oracle://sys:${ORACLE_PWD}@oracle-26ai:1521/FREE"
          collection_interval: 30s

        sqlserver:
          server: "sqlserver"
          port: 1433
          username: "sa"
          password: "${SQLSERVER_SA_PWD}"
          collection_interval: 30s

        postgresql:
          endpoint: "postgres:5432"
          username: ${POSTGRES_USER}
          password: ${POSTGRES_PWD}
          databases: ["${POSTGRES_DB}"]
          collection_interval: 30s
          tls:
              insecure: true

      processors:
        batch:

      exporters:
        otlphttp:
          endpoint: http://grafana:4318

      service:
        pipelines:
          metrics:
            receivers: [oracledb, sqlserver, postgresql]
            processors: [batch]
            exporters: [otlphttp]
```

---

## Specific configurations

### Oracle configuration

To collect telemetry from Oracle, it is recommended to create a specific user for that.

```sql
CREATE USER otel IDENTIFIED BY otel_pwd;
GRANT CONNECT TO otel;

GRANT SELECT ON V_$SESSION TO otel;
GRANT SELECT ON V_$SYSSTAT TO otel;
GRANT SELECT ON V_$RESOURCE_LIMIT TO otel;
GRANT SELECT ON V_$SYSTEM_EVENT TO otel;
GRANT SELECT ON V_$WAITCLASSMETRIC TO otel;
GRANT SELECT ON V_$TABLESPACE TO otel;
GRANT SELECT ON DBA_TABLESPACE_USAGE_METRICS TO otel;
```
