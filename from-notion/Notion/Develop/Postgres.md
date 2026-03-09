---

---
## Backup

[https://simplebackups.com/blog/docker-postgres-backup-restore-guide-with-examples/](https://simplebackups.com/blog/docker-postgres-backup-restore-guide-with-examples/)

## Commands

| Comando | Sql (se aplicável) | Descrição |
| --- | --- | --- |
| psql -U [user] <<database name>> |   | Conectar na base de dados via linha de comando |
| sudo service postgresql stop |   | Parar o serviço |
| sudo service postgresql start |   | Iniciar o serviço |
| SHOW config_file; |   | Mostrar o valor da configuração 'config_file' |
| SHOW wal_level; |   | Mostrar o valor da configuração 'wal_level' |
| /d table |   | Mostrar a estrutura da tabela |
| /du | Select * from pg_roles | Lista todas as roles disponíveis |
| select * from pg_settings where name ='config_file';select * from pg_settings where name ='wal_level' |   | Obter as configurações via query |
