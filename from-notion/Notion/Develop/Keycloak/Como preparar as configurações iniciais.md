---

---
## Environment

Keycloak sendo executado em um container, nenhuma customização foi executada durante esse processo.

## Configurações necessárias para usar o container (docker)

O Keycloak está sendo está utilizando uma base de dados Postgres para funcionar

- Imagem utilizada: 'jboss/keycloak'
- Criar uma base de dados, no postgres, com o nome keycloak
    - não olhei se esse nome pode ser alterado por configuração, provavelmente é possível.
- No arquivo 'docker-compose' utilizado para iniciar os serviço, as seguintes variáveis foram definidas

```javascript
KEYCLOAK_USER: admin
      KEYCLOAK_PASSWORD: admin
      DB_VENDOR: postgres
      DB_ADDR: host.docker.internal
      DB_PORT: 5432
      DB_USER: keycloak
      DB_PASSWORD: keycloak
```

- Para os testes, o keycloak foi definido para estar disponível na porta 9090. A porta padrão é a 8080.

## Configurações a serem realizadas no Keycloak console (manualmente neste tutorial)

- Criar um Realm que será utilizado pelo projeto
- Na aba Login, definir o que será permitido ao usuário relacionado a login

| User registration | Se o usuário poderá se alto registrar |
| --- | --- |
| Email as username | Se o email será utilizado como login (user name) |
| Forgot password | Se estará disponível um link para o usuário recuperar a senha |
| Remember me | Se o usuário estará autorizado a se manter logado no sistema |
| Verify email | Se o email precisa ser válido para ser utilizado |

- Na aba Email devem ser colocadas as configurações para se enviar um email pelo Keycloak. Caso o Verify Email tenha sido habilitado, essas configurações precisam ser adicionadas.
- Na aba Themes, por enquanto, só habilitar o "Internationalization Enable" e definir o código padrão para o Brasileiro.

## Clients

Com as configurações executadas até aqui, temos os seguintes links disponíveis em client

| account | [http://localhost:9090/auth/realms/Gallery/account/](http://localhost:9090/auth/realms/Gallery/account/) |
| --- | --- |
| account-console | [http://localhost:9090/auth/realms/Gallery/account/](http://localhost:9090/auth/realms/Gallery/account/) |
| security-admin-console | [http://localhost:9090/auth/admin/Gallery/console/](http://localhost:9090/auth/admin/Gallery/console/) |

## Users

Crie um usuário para a realização dos testes!

## Conferindo as configurações até agora!

Neste ponto já temos um Realm configurado e um usuário para testar a conexão.