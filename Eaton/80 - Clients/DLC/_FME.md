## 1.3. - Substation (as circuits)

| Property | Problem/Comment           |
| -------- | ------------------------- |
| Group1   | property `aor` is missing |

## 1.3.2 - Substation sources

**GIS Feature: ElectricDistributionDevice where** **AssetGroup****=428/Controller**

CYME_SwitchableShuntBank?

| Property   | Problem/Comment                                             |
| ---------- | ----------------------------------------------------------- |
| HeadNodeID | Property does not exist in `CYME_SwitchableShuntBank`       |
| SourceID   | `StructureBoundary.name`?<br>`voltage`? (operating_voltage) |

Note A: If controller is in a high-voltage substation (138 kV or 345 kV), use controller as the source. Group multiple sources together at 1 single node.
If controller OPERATINGVOLTAGE = 23 kV, use controller as the source, but don’t merge multiple controllers together.

(how to do it???)

## 1.3.3 Subnetwords (nested views)

**GIS Feature:** **StructureBoundary where** **ASSETGROUP****=303/Substation Boundary and** **structure_owner****=DLC/”Duquesne Light Co”, that appears in the JSON for a substation.**

**GIS Feature:** **StructureBoundary where** **ASSETGROUP****=303/Substation Boundary, that appears in the JSON for a subtransmission line, without any Busbars assigned to a SubnetworkName ending in “SS” (nested view without a substation)**

CYME_SubNetwork?

| Property     | Problem/Comment                                                     |
| ------------ | ------------------------------------------------------------------- |
| SubNetworkID | `StructureBoundary.name` not found, using `properties.name` instead |
## 1.3.4 - Substation busbars

cyme_section?

| Property | Problem/Comment                                                                   |
| -------- | --------------------------------------------------------------------------------- |
| CableID  | Properties: `conductor_type`, `conductor_size` and `conductor_material` not found |
|          |                                                                                   |
## 1.3.5 - Substation Switches

CYME_ProtectiveDevice?
`StructureBoundary where ASSETGROUP=303/Substation Boundary`: Should be used here?

| Property     | Problem/Comment                                                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------------------------------- |
| DeviceNumber | `Global ID` property not found, using `id` instead                                                                        |
| EquipmentID  | `rated_voltage` AND `device_size` do not exist for ASSETGROUPS 419, 303, it exists for ASSETGROUP 408 (Network Protector) |
| NewtorkID    | Should remove **SS** from `Subnetworkname`?                                                                               |
|              |                                                                                                                           |
|              |                                                                                                                           |

## 1.3.5 - Substation internal Breakers

CYME_ProtectiveDevice?
ProtectiveDeviceType = 2 (Breaker)??

| Property     | Problem/Comment                                                      |
| ------------ | -------------------------------------------------------------------- |
| DeviceNumber | Missing information                                                  |
| State        | CYME_ProtectiveDevice does not has `State` property. (Connected = 0) |
| EquipmentID  | `device_size` does not exist                                         |
|              |                                                                      |

## 1.3.7 Substation internal reclosers

| Property     | Problem/Comment                                                      |
| ------------ | -------------------------------------------------------------------- |
| State        | CYME_ProtectiveDevice does not has `State` property. (Connected = 0) |
| EquipmentID  | ????                                                                 |