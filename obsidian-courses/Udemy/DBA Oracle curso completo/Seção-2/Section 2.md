---
tags:
  - User
  - permissions
  - CDB
  - CDBuser
  - Revoke
---
# Seção 2: Oracle Multi-Tenant (CDB e PDB)

> Para se conectar ao container, verifique o arquivo [[_básico]].

## Criação de um usuário

- Por convenção, exige um prefixo.
	- `c##`, essa restrição pode ser retirada, porém não é indicado.

### Características:

- Os usuários podem ser local ou Common (usuarios comuns).
- Cada PDB contém seu próprio dicionário de dados.
- Os usuários COMMON (comuns) se registram no dicionário do `CDB$ROOT`. 
  Crie usuário comum caso deseje que este usuario tenha capacidade 
  de administrar o proprio cdb e os pdbs.
- Os usuários locais se registram no dicionário de PDB.
- O Oracle controla o prefixo dos usuários comuns que estao no CDB. 
  Não se deve alterar este parâmetro sem o suporte da Oracle 
  que por padrão todo usuario comum que é criado no CDB, 
  e a Oracle exige um c## na frente do nome e esperasse que usuarios 
  criados em nivel de CDB receba privilegio para monitorar e gerenciar PDBs. 

### Tudo que devemos saber sobre usuários do tipo “LOCAL”:
- Os usuarios locais podem realizar tarefas somente dentro da PDB 
  onde foram criados. 
- Não podem conectar-se a nenhuma outra PDB a nao ser que seja tambem 
  criado em outro pdb com os devidos privilegios, inclusive podendo ser 
  criado com o mesmo nome e senha.
- Um usuário local, se receber este privilegio, pode criar usuários locais, 
  mas não usuários comuns. Os usuários locais só podem ter privilégios 
  concedidos localmente.

## Notas

Não se deve criar tabelas e outros objetos dentro dos CDBs, mas dentro dos PDBs.
- CDB -> SysDB, usuários especializados
- PDB -> Uso geral

O PDB `PDB$SEED` é um template, nada deve ser feito nele, todos os novos PDBs criados utilizam ele para serem criados (um clone dele).

## Laboratórios

### Laboratório 1

- Como se localizar dentro do Oracle (onde está conectado)
- Ver a lista de PDBs
#### Commandos

| Objetivo                                                | Comando                                                         |
| ------------------------------------------------------- | --------------------------------------------------------------- |
| Verificar onde o SYS está conectado, nome padrão do CDB | `Select con_id, dbid, name From v$containers Where con_id = 1;` |
| Obter o nome da conexão                                 | `show con_name;`                                                |
| Ver todos os pdbs                                       | Select name from v$pdbs;                                        |

### Laboratório 2

- Criação de usuário no CDB
- Permissões: Connexão, criação de tabelas.
- Important:  É necessário modificar a sessão para manipular um PDB

#### Commandos

| Objetivo                                                                                                    | Comando                                                                                                     |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| Cria um usuário chamado "c##commonuser", com senha "commonuser".                                            | `create user c##commomuser identified by  "commonuser" container=all;`                                      |
| Adiciona permissão para conexão em todos os containers                                                      | `grant connect to c##commomuser container = all;`                                                           |
| Adiciona permissão para criação de tabelas, apenas no `container atual`.                                    | `grant create table to c##commomuser container=current;`                                                    |
| Connecta no novo usuário para testar (usuário/senha)                                                        | - `conn c##commomuser/commonuser;`<br>- `conn sys/Oracle1234 as sysdba;`                                    |
| Visualizar o usuário corrent                                                                                | `show user;`                                                                                                |
| Retirar permissões                                                                                          | `revoke create table from c##commomuser container=current;`                                                 |
| Alterar a sessão da conexão para um PDB (FREEPDB1 no caso do meu docker)                                    | alter session set container=FREEPDB1;                                                                       |
| Criação de um usuário no PDB, a diferença é que o prefixo não é necessário (e nem deve ser utilizado mais.) | create user wilton_user identified by  "wilton" container=current;                                          |
| Permissões para o novo usuário (mesmos comandos já vistos acima)                                            | - grant connect to wilton_user contanier=current;<br>- grant create table to wilton_user container=current; |
| Para verificar o estado da database (montado/desmontado)                                                    | - `select open_mode from v$database;`<br>- select status from v$instance;                                   |
| Para fechar (desmontar) um PDB, erro `Database not open`                                                    |                                                                                                             |
| Para abrir (montar) um PDB, erro `Database not open`                                                        | alter pluggable database [pdb-name(database-name)] open;                                                    |

### Criar usuário dentro de um PDB

- É necessário modificar a sessão para o PDB
 

| Objetivo                                                                                                    | Comando                                                                                                     |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| Alterar a sessão da conexão para um PDB (FREEPDB1 no caso do meu docker)                                    | alter session set container=FREEPDB1;                                                                       |
| Criação de um usuário no PDB, a diferença é que o prefixo não é necessário (e nem deve ser utilizado mais.) | create user wilton_user identified by  "wilton" container=current;                                          |
| Para permissões, utilize as orientações do quadro acima, é tudo igual.                                      | - grant connect to wilton_user contanier=current;<br>- grant create table to wilton_user container=current; |
| Para verificar o estado da database (montado/desmontado)                                                    | - select open_mode from v$database;<br>- select status from v$instance;                                     |
| Para fechar (desmontar) um PDB, erro `Database not open`                                                    |                                                                                                             |
| Para abrir (montar) um PDB, erro `Database not open`                                                        | alter pluggable database [pdb-name(database-name)] open;                                                    |
|                                                                                                             |                                                                                                             |
