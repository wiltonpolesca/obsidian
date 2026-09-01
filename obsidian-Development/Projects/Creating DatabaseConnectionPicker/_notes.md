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


---

Code to be replaced with the new approach

Real code from DLC (Extact.cs)

```
 //Source Networks
 if (m_configurationToolData.CYMDISTSubstation.DatabaseType == GatewayDatabaseType.Oracle)
 {
     impExpProcess.SetCYMESourceNetworkDatabase(m_configurationToolData.CYMDISTSubstation.OracleSubstationDatabase);
 }
 else if (m_configurationToolData.CYMDISTSubstation.DatabaseType == GatewayDatabaseType.MSAccess)
 {
     impExpProcess.SetCYMESourceNetworkDatabase(m_configurationToolData.CYMDISTSubstation.MDBSubstationDatabase);
 }
 else if (m_configurationToolData.CYMDISTSubstation.DatabaseType == GatewayDatabaseType.MSSQL)
 {
     impExpProcess.SetCYMESourceNetworkDatabase(m_configurationToolData.CYMDISTSubstation.SQLSubstationDatabase);
 }

 if (m_configurationToolData.CYMDISTDatabase.EquipmentDatabaseType == GatewayDatabaseType.Oracle)
 {
     impExpProcess.SetCYMESourceEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.OracleEquipmentDatabase);
 }
 else if (m_configurationToolData.CYMDISTDatabase.EquipmentDatabaseType == GatewayDatabaseType.MSAccess)
 {
     impExpProcess.SetCYMESourceEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.MdbEquipmentDatabase);
 }

 // Destination Network
 if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.Oracle)
 {
     impExpProcess.SetCYMEDestinationNetworkDatabase(m_configurationToolData.CYMDISTDatabase.OracleNetworkDatabase);
 }
 else if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.MSAccess)
 {
     impExpProcess.SetCYMEDestinationNetworkDatabase(m_configurationToolData.CYMDISTDatabase.MdbNetworkDatabase);
 }
 else if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.MSSQL)
 {
     impExpProcess.SetCYMEDestinationNetworkDatabase(m_configurationToolData.CYMDISTDatabase.SQLNetworkDatabase);
 }

 //Destination Equipment
 if (GatewayConfigurationToolData.UseEquipmentDatabase)
 {
     if (m_configurationToolData.CYMDISTDatabase.EquipmentDatabaseType == GatewayDatabaseType.Oracle)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.OracleEquipmentDatabase);
     }
     else if (m_configurationToolData.CYMDISTDatabase.EquipmentDatabaseType == GatewayDatabaseType.MSAccess)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.MdbEquipmentDatabase);
     }
     else if (m_configurationToolData.CYMDISTDatabase.EquipmentDatabaseType == GatewayDatabaseType.MSSQL)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.SQLEquipmentDatabase);
     }
 }
 else
 {
     if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.Oracle)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.OracleNetworkDatabase);
     }
     else if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.MSAccess)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.MdbNetworkDatabase);
     }
     else if (m_configurationToolData.CYMDISTDatabase.NetworkDatabaseType == GatewayDatabaseType.MSSQL)
     {
         impExpProcess.SetCYMEDestinationEquipmentDatabase(m_configurationToolData.CYMDISTDatabase.SQLNetworkDatabase);
     }
 }
```