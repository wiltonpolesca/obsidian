## Comandos básicos

| Comando                                  | Descrição                                               |
| ---------------------------------------- | ------------------------------------------------------- |
| shu immediate                            | Desliga o oracle                                        |
| !clear                                   | Limpar a tela                                           |
| show user;                               | Apresenta o usuário logado                              |
| show con_name                            | Local da conexão (CDB/PDB)                              |
| alter session set container=<<cdb/pdb>>; | Altera o local da sessão (conexão com o banco de dados) |

## Conexão no oracle dentro do docker
- docker exec -it <container_name> sqlplus system/oracle@localhost:1521/XEPDB1
- podman exec -it <container_name> sqlplus system/oracle@localhost:1521/XEPDB1

Local credentials:
user: sys
pwd: Oracle1234

#### Conexão container local como SYSDBA
`podman exec -it oracle-26ai sqlplus sys/Oracle1234@localhost:1521/FREE as SYSDBA`

## Conexão no oracle a partir do oracle client (exige instalação do oracle client)

- sqlplus system/oracle@localhost:1521/XEPDB1

