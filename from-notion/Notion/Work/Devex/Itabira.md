---

---
VPN

- IP: 200.149.212.41
User: valenet\01663724
Pwd: M@st3rk31

Application server

- IP: 172.18.86.48
- User:top\wilton.souza
- pwd: devex001

DDP server

- IP: 172.18.86.252
- User:top\wilton.souza
- pwd: devex001

Gateway server

- IP: 172.18.86.255
- User: .\devex
- pwd: devex@1

Report server

- IP: 172.18.86.50
- User:top\wilton.souza
- pwd: devex001

Quais as Layers são utilizadas?

- Platform
- Trackerbus
- Mine
- Fueling
- Maintenance

Quais as aplicações são utilizadas?

- Supervisory
- Inspector
- Settings
- Viewer

Configurações para acesso a rede do cliente

- Wifi

<u>**Estrutura de diretórios do cliente:**</u>

(servidor de aplicação: IP: 172.18.86.48)

C:\Devex

**ActiveMQ ***(Software de fila utilizada pelo sistema)*

**Application***(Armazena a versão atual da aplicação, para uso do suporte)*

**Backup  ***(Armazenado uma cópia do sistema e do banco antes das atualizações)*

application

db

server

DUMP

**ConnectionHelper  ***(Pasta criada automaticamente pelo sysconfig com informações de conexão)*

**Percistence  ***(Databases do postgres)*

**Server  ***(Serviço do sistema (businnes e plugins)*

Fueling

Maintenance

Mine

Platform

Trackerbus

**Tools ***(Ferramentas de apoio)*

ServerBackup

SysConfig

SystemMonitor

(servidor de relatório: IP: 172.18.86.50)

C:\Devex

DataSync *(Serviço de sincronismo entre o sistema e o sql server (reports))*

Obs: Existem outros diretórios que não interessam para a atualização, porém, não devem ser removidos.