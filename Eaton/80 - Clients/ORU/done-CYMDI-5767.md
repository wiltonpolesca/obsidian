## [[CYMDI-5767] Modify Substation Import script to support ADMS export requirements - Jira](https://eaton-corp.atlassian.net/browse/CYMDI-5767)

| Section                          | DeviceType                   | Transformer                                  | UDD        | Properties added                                                                                                                     |                 |
| -------------------------------- | ---------------------------- | -------------------------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------ | --------------- |
| 1.3  - Substation Source         | 35 - Source                  | `PythonCaller_Network_SetUDD`                | NetworkUDD | FID                                                                                                                                  |                 |
| 1.8 - Cable Section              | 10 - Underground             | `PythonCaller_Cable_SetUDD`                  | DeviceUDD  | DEW_OperatingKV, CmpName, CmpType, Primary_Construction, Primary_PhaseSize, Primary_PhaseMaterial, Primary_PhaseCond, OriginalLength |                 |
| 1.10 - Breaker                   | 2 - Breaker                  | `PythonCaller_Breaker_SetUDD`                | DeviceUDD  | PartName, CmpType, FID                                                                                                               |                 |
| 1.11 - Switch                    | 6 - Switch                   | `PythonCaller_Switch_SetUDD`                 | DeviceUDD  | PartName, CmpType                                                                                                                    |                 |
| 1.12 - Fuse                      | 7 - Fuse                     | `PythonCaller_Fuse_SetUDD`                   | DeviceUDD  | PartName, CmpType                                                                                                                    |                 |
| 1.13 - Recloser                  | 4 - Recloser                 | `PythonCaller_Recloser_SetUDD`               | DeviceUDD  | PartName, CmpType, FID                                                                                                               |                 |
| 1.14 - Sectionalizer             | 5 - Sectionalizer            | `PythonCaller_Sectionalizer_SetUDD`          | DeviceUDD  | PartName, FID                                                                                                                        | No data to test |
| 1.21 - Regulator                 | 0 - Regulator                | `AttributeCreator_Regulator_SetUDD`          | DeviceUDD  | FID                                                                                                                                  |                 |
| 1.22 - Transformer               | 1 - Transformer              | `PythonCaller_Transformer_SetUDD`            | DeviceUDD  | PartName, CmpType, FID                                                                                                               |                 |
| 1.23 - Three Winding Transformer | 32 - ThreeWindingTransformer | `PythonCaller_ThreeWindingTranformer_SetUDD` | DeviceUDD  | PartName, CmpType, FID                                                                                                               |                 |
| 1.26 - Shunt Capacitor           | 16 - ShuntCapacitor          | `PythonCaller_ShuntCapacitor_SetUDD`         | DeviceUDD  | FID, CooldownPeriod, maxoperations                                                                                                   |                 |

DeviceType DataType DataID DataValue NetworkID DeviceNumber

StationID
FID


Je peux aller regarder directement dans CYME quelques cas au hazard de chacun de ces appareils. Tu as extrait les postes dans la BD SQL ORU_SUBSTATION_95 (ou qqc comme ça) ?

Salut Phillippe,

J'ai creé la base de donné `wilton-tests1` (sqlite) est-ce suffisant?

