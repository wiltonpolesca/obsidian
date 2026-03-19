## Fichier: `CYME Gateway for ORU - Substation Data Mapping 1.8.docx`

| Section                          | DeviceType                       | Transformer                   | UDD        | Properties added                                                                                                                     |
| -------------------------------- | -------------------------------- | ----------------------------- | ---------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| 1.3  - Substation Source         | 35 - Source                      | `PythonCaller_Network_SetUDD` | NetworkUDD | FID                                                                                                                                  |
| 1.8 - Cable Section              | 10 - Underground                 | `PythonCaller_Cable_SetUDD`   | DeviceUDD  | DEW_OperatingKV, CmpName, CmpType, Primary_Construction, Primary_PhaseSize, Primary_PhaseMaterial, Primary_PhaseCond, OriginalLength |
| 1.10 - Breaker                   | 2 - Breaker                      | `PythonCaller_Breaker_SetUDD` | DeviceUDD  | PartName, CmpType, FID                                                                                                               |
| 1.11 - Switch                    | 6 - Switch                       | `PythonCaller_Switch_SetUDD`  | DeviceUDD  | PartName, CmpType                                                                                                                    |
| 1.12 - Fuse                      | 7 - Fuse                         | `PythonCaller_Fuse_SetUDD`    | DeviceUDD  | PartName, CmpType                                                                                                                    |
| 1.13 - Recloser                  | 4 - Recloser                     |                               |            | PartName, CmpType, FID                                                                                                               |
| 1.14 - Sectionalizer             | 5 - Sectionalizer                |                               |            | PartName, FID                                                                                                                        |
| 1.21 - Regulator                 | 0 - Regulator                    |                               |            | FID                                                                                                                                  |
| 1.22 - Transformer               | 1 - Transformer                  |                               |            | PartName, CmpType, FID                                                                                                               |
| 1.23 - Three Winding Transformer | 43 - ThreeWindingAutoTransformer |                               |            | PartName, CmpType, FID                                                                                                               |
| 1.26 - Shunt Capacitor           | 16 - ShuntCapacitor              |                               |            | FID, CooldownPeriod, maxoperations                                                                                                   |

DeviceType DataType DataID DataValue NetworkID DeviceNumber

StationID
FID