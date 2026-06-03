# Oracle

## Installation notes

### Windows Server

Version: 21C


## Commands

Views com informações do sistema: v$instance
Exemplo:
```sql
Select host_name, instance_name, status
  from v$instance;
```

### How to turn of

from sqlplus
`shu immediate`
-  shu => shortcut of `shutdown`
- immediate => rollback an close all current connections (what were commited will be saved)
- normal => wait until all users close their the connections
- abort => will turn off Immediately and can lose data
