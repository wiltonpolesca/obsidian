## CYMDI-5751 - [Create ADMS Export Python script](https://eaton-corp.atlassian.net/browse/CYMDI-5751)


After review: To ask CYME team which properties should be used.

| Section            | Field                                                                   |     |     |
| ------------------ | ----------------------------------------------------------------------- | --- | --- |
| Dew_regulator      | controlPhase                                                            |     |     |
| Dew_regulator_type | summerKVA, summerEmergKva, winterKVA, winterEmergKva                    |     |     |
| Dew_switches       | OperatingKV                                                             |     |     |
| Dew_trans          | controlPhase, initialTap (XfoInitialTap) , tapside (XfoLTCLocation)     |     |     |
| Dew_trans_type     | summerKVA, summerEmergKva, winterKVA, winterEmergKva, maxtap (XfoNbTap) |     |     |
|                    |                                                                         |     |     |



: %s: %s" % summerKVA)
cyme-di-cust-oncor-plkugings

---

| File               | Field destination | Expected source | Source          |     |
| ------------------ | ----------------- | --------------- | --------------- | --- |
| dew_busbar         | OperatingKV       | OperatingKV     | DEW_OperatingKV | OK  |
| dew_primary        | OperatingKV       | OperatingKV     | DEW_OperatingKV | OK  |
| dew_regulator      | controlPhase      | TBD             |                 |     |
| dew_regulator      | tapside           | TBD             |                 |     |
| dew_switches       | OperatingKV       | TBD             |                 |     |
| dew_trans          | s1Connection      | ???             | XfoConn         |     |
| dew_trans          | controlPhase      | TBD             |                 |     |
| dew_trans          | initialTap        | TBD             |                 |     |
| dew_trans          | tapside           | TBD             |                 |     |
| dew_trans_type     | automode          | ???             |                 |     |
| dew_trans_type     | summerKVA         | TBD             |                 |     |
| dew_trans_type     | summerEmergKva    | TBD             |                 |     |
| dew_trans_type     | winterKVA         | TBD             |                 |     |
| dew_trans_type     | winterEmergKva    | TBD             |                 |     |
| dew_regulator_type | summerKVA         | TBD             |                 |     |
| dew_regulator_type | summerEmergKva    | TBD             |                 |     |
| dew_regulator_type | winterKVA         | TBD             |                 |     |
| dew_regulator_type | winterEmergKva    | TBD             |                 |     |
dew_feed -> com problema
dew_geo

| Device type          | Field destination | Observations                                           |
| -------------------- | ----------------- | ------------------------------------------------------ |
| 10 - Underground     | fid               | FID does not exists on cables, using SectionID instead |
| 10 - Underground     | CmpType           | Many cables do not have CmpType                        |
| 16 - Shunt capacitor | CmpType           | Shunt Capacitor does not have CmpType                  |
Test result

dew_sources: OK
dew_busbar: Error fixed
dew_primary: error fixed