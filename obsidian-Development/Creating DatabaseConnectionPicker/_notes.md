# Connections

## Sql Server

### DLC
- Server: VM-DBSQL2022.cyme.local\SQLSERVER2022
- Database: DLC_TEST_SPL_96
- User: DLC_TEST_SPL_96
- Password: DLC_TEST_SPL_96

### ORU

- Server: VM-DBSQL2019.CYME.LOCAL\SQLSERVER2019
- Database: ORU_NETWORK_95
- User: ORU_NETWORK_95
- Password: ORU_NETWORK_95

- Server: VM-DBSQL2019.CYME.LOCAL\SQLSERVER2019
- Database: ORU_EQUIPMENT_95
- User: ORU_EQUIPMENT_95
- Password: ORU_EQUIPMENT_95
## Oracle

### Requires

- [NuGet Gallery | Oracle.ManagedDataAccess 23.26.300](https://www.nuget.org/packages/Oracle.ManagedDataAccess) (Net Framework)
- 
- 

- User: PHI_ELECTRIC_OWNER
- Password: PHI_ELECTRIC_OWNER
- TNS: EXELON4_MOCK5

## Postgres


## Access

Requires: [Download Microsoft Access Database Engine 2016 Redistributable from Official Microsoft Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=54920)
## SQLite

# SQL to test


Create Table tb_connection_test(id int, name text)
Insert Into tb_connection_test(id, name) values (@id, @name)
select * from tb_connection_test

Select * from cymnetwork where networkid like @name



---

npx @redocly/cli preview-docs path/to/openapi.json
npx @redocly/cli preview-docs c:/dev/swagger.json
