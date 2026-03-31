## CYMDI-5751 - [Create ADMS Export Python script](https://eaton-corp.atlassian.net/browse/CYMDI-5751)

| File               | Field destination | Expected source | Source                                |
| ------------------ | ----------------- | --------------- | ------------------------------------- |
| dew_busbar         | OperatingKV       | OperatingKV     | DEW_OperatingKV                       |
| dew_primary        | OperatingKV       | OperatingKV     | UID_BANK_16_BUS -> LENGTH ESTÁ ERRADO |
| dew_regulator      | controlPhase      | TBD             |                                       |
| dew_regulator      | tapside           | TBD             |                                       |
| dew_switches       | OperatingKV       | TBD             |                                       |
| dew_trans          | s1Connection      | ???             | XfoConn                               |
| dew_trans          | controlPhase      | TBD             |                                       |
| dew_trans          | initialTap        | TBD             |                                       |
| dew_trans          | tapside           | TBD             |                                       |
| dew_trans_type     | automode          | ???             |                                       |
| dew_trans_type     | summerKVA         | TBD             |                                       |
| dew_trans_type     | summerEmergKva    | TBD             |                                       |
| dew_trans_type     | winterKVA         | TBD             |                                       |
| dew_trans_type     | winterEmergKva    | TBD             |                                       |
| dew_regulator_type | summerKVA         | TBD             |                                       |
| dew_regulator_type | summerEmergKva    | TBD             |                                       |
| dew_regulator_type | winterKVA         | TBD             |                                       |
| dew_regulator_type | winterEmergKva    | TBD             |                                       |

dew_geo

| Device type          | Field destination | Observations                                           |
| -------------------- | ----------------- | ------------------------------------------------------ |
| 10 - Underground     | fid               | FID does not exists on cables, using SectionID instead |
| 10 - Underground     | CmpType           | Many cables do not have CmpType                        |
| 16 - Shunt capacitor | CmpType           | Shunt Capacitor does not have CmpType                  |
C://dev//clients//oru//output_files