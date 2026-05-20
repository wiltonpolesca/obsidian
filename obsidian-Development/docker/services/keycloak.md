# Portainer  docker service

## Service

```yaml
  keycloak:
    container_name: keycloak
    image: keycloak/keycloak:26.5
    command:
      - start
      - --import-realm
      - --verbose
    restart: on-failure
    ports:
      - 8080:8080
      - 8443:8443
    environment:
      KC_BOOTSTRAP_ADMIN_USERNAME: ${KEYCLOAK_USER}
      KC_BOOTSTRAP_ADMIN_PASSWORD: ${KEYCLOAK_ADMIN_PASSWORD}
      KC_DB: ${KEYCLOAK_DB}
      KC_DB_URL: jdbc:postgresql://${DB_HOST}:${DB_PORT}/${KEYCLOAK_DB_SCHEMA}
      KC_DB_USERNAME: ${KEYCLOAK_DB_USER}
      KC_DB_PASSWORD: ${KEYCLOAK_DB_PWD}
      KC_HEALTH_ENABLED: true
      KC_LOG_LEVEL: info
      KC_PROXY: edge
      KC_HOSTNAME_STRICT: false
      KC_HTTP_ENABLED: true
      KC_METRICS_ENABLED: true
      KC_TRACING_ENABLED: true
      KC_TRACING_SERVICE_NAME: "keycloak-auth-server"
      KC_TRACING_ENDPOINT: ${OBSERVABILITY_URL}
      OTEL_EXPORTER_OTLP_PROTOCOL: grpc
      KC_TRACING_EXPORTER: "otlp"
      KC_HTTPS_CERTIFICATE_FILE: /opt/keycloak/certs/my-certs/server.pem
      KC_HTTPS_CERTIFICATE_KEY_FILE: /opt/keycloak/certs/my-certs/server-key.pem
      # KC_HOSTNAME_STRICT_HTTPS: false # should not use in producion.
    #   KC_HTTPS_KEYSTORE_PASSWORD: ${CERT_PWD}
    #   KC_HTTPS_KEYSTORE_TYPE: PKCS12      
    networks:
      - dev_net
    depends_on:
      postgres:
        condition: service_healthy
        restart: true
    volumes:
      - ${CONFIG_BASE_PATH}/settings/certificates:/opt/keycloak/certs/my-certs:ro
      - ${CONFIG_BASE_PATH}/settings/keycloak/import:/opt/keycloak/data/import/
```

## Configurations

### .env file

```env
KEYCLOAK_USER=
KEYCLOAK_ADMIN_PASSWORD=
KEYCLOAK_DB=postgres
DB_HOST=
DB_PORT=
KEYCLOAK_DB_SCHEMA=
KEYCLOAK_DB_USER=
KEYCLOAK_DB_PWD=
OBSERVABILITY_URL=
```

