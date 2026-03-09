---

---
At postegresql, set the config `wal_level` to `logical` .

docker-compose config

debezium-connecetor

image: debezium/connect:1.4

environment:

BOOTSTRAP_SERVERS: kafka:9092

GROUP_ID: 1

CONFIG_STORAGE_TOPIC: connect_configs

OFFSET_STORAGE_TOPIC: connect_offsets

STATUS_STORAGE_TOPIC: pg_connect_statuse

depends_on: [kafka]

networks:

- newtrax

ports:

- 8083:8083

Para que o debezium conecte-se a  uma base de dados e inicie a captura das mudanças é necessário 'ativar' uma configuração

Exemplo de configuração:

{

"name": "pg-iot-config-source",

"config": {

"connector.class": "io.debezium.connector.postgresql.PostgresConnector",

"plugin.name": "wal2json",

"database.hostname": "host.docker.internal",

"database.port": "5435",

"database.user": "postgres",

"database.password": "timescaledb",

"database.dbname": "met_configuration",

"database.server.name": "myserver",

"table.include.list": "public.worker_titles",

"value.converter": "org.apache.kafka.connect.json.JsonConverter"

}

}

Para adicionar a configuração a API deve ser utilizada, a documentação oficial está em: [Connect REST Interface | Confluent Documentation](https://docs.confluent.io/platform/current/connect/references/restapi.html)

Para adicionar uma configuração

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:9090/connectors/ -d @<<NOME DO ARQUIVO DE CONFIGURAÇÃO>>.json

exemplo

curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" localhost:9090/connectors/ -d @pg-source-config.json

Excluir uma configuracão

curl -i -X  DELETE localhost:9090/connectors/<<CONFIG-NAME>>/

Obter todas as configurações

curl GET -H "Accept:application/json" -H "Content-Type:application/json" localhost:9090/connectors

LEADER_NOT_AVAILABLE ->

KAFKA_LISTENERS: '...,PLAINTEXT://0.0.0.0:9092'

KAFKA_LISTENER_SECURITY_PROTOCOL_MAP:

KAFKA_ADVERTISED_LISTENERS: '...,PLAINTEXT://host.docker.internal:9092'

Serviços necessários

- zookeeper
- kafka
- kafka-connect
- schema-registry
- debeziuim
- control-center
- postgresql

[javascript - How do I connect Kafkajs with Socket.io - Stack Overflow](https://stackoverflow.com/questions/66337792/how-do-i-connect-kafkajs-with-socket-io)

versão antiga

[Angular Websockets Tutorial | TutorialEdge.net](https://tutorialedge.net/typescript/angular/angular-websockets-tutorial/)