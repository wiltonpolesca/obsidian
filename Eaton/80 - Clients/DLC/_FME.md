## 1.3. - Substation (as circuits)

## 1.3.2 - Substation sources

**GIS Feature: ElectricDistributionDevice where** **AssetGroup****=428/Controller**

CYME_Source

| Property   | Problem/Comment                   |
| ---------- | --------------------------------- |
| SourceID   | EquipmentID? ???                  |
| HeadNodeID | Is the destination TopoNodeID ??? |
|            |                                   |

It requires more information:
>*Note A: If controller is in a high-voltage substation (138 kV or 345 kV), use controller as the source. Group multiple sources together at 1 single node.*
>*If controller OPERATINGVOLTAGE = 23 kV, use controller as the source, but don’t merge multiple controllers together.*


## 1.3.3 Subnetworks (nested views)

CYME_SubNetwork

It requires more information:

>***GIS Feature:** **StructureBoundary where** **ASSETGROUP***=303/Substation Boundary, that appears in the JSON for a subtransmission line, without any Busbars assigned to a SubnetworkName ending in “SS” (nested view without a substation)***

| Property     | Problem/Comment                                                     |
| ------------ | ------------------------------------------------------------------- |
| SubNetworkID | `StructureBoundary.name` not found, using `properties.name` instead |
## 1.3.4 - Substation busbars

cyme_section?

| Property | Problem/Comment                                                                   |
| -------- | --------------------------------------------------------------------------------- |
|          |                                                                                   |
## 1.3.5 - Substation Switches

CYME_ProtectiveDevice?
`StructureBoundary where ASSETGROUP=303/Substation Boundary`: Should be used here?

| Property     | Problem/Comment                                                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------------------------------- |
| EquipmentID  | `rated_voltage` AND `device_size` do not exist for ASSETGROUPS 419, 303, it exists for ASSETGROUP 408 (Network Protector) |
| NewtorkID    | Should remove **SS** from `Subnetworkname`?                                                                               |
|              |                                                                                                                           |
|              |                                                                                                                           |

### Changes by chat

![[1.3.5-substation-switches-device-number-1.png]]

## 1.3.6 - Substation internal Breakers

| Property     | Problem/Comment     |
| ------------ | ------------------- |
| DeviceNumber | Missing information |
|              |                     |

- PlumSS
## 1.3.7 Substation internal reclosers

| Property    | Problem/Comment                                                      |
| ----------- | -------------------------------------------------------------------- |
| EquipmentID | ????                                                                 |

## 1.3.8 - Substation internal Regulators

| Property    | Problem/Comment       |
| ----------- | --------------------- |
| EquipmentID | device_size not found |

## 1.3.9 - Substation Transformer

- PlumSS
	- High_Side_Voltage: ID: 9633e3e7-5a32-4fc0-a48b-f76afa890db0 (138000)
## 1.3.10 - Substation Shunt Capacitor

| Property     | Problem/Comment      |
| ------------ | -------------------- |

- PlumSS

---

# Networks

WolfeRun

## Ok

- Craft
- Glassport
- Robroy
	- "ASSETGROUP": 601, "ASSETTYPE": 701, ??
- NarrowsRun
- WestinghouseFoundry
- Imperial
## Maybe it is OK ...

- MtNebo
- Homestead
- Brentwood


10.106.28.65

----

```
{
let $Conn := fme:get-json-attribute("networkWithTerminalConnections")
    
return {|
for $key in jn:keys($Conn)
    let $ConnCompoIds := $Conn($key)
    where(fn:not(fn:empty($ConnCompoIds(1)("connectedComponentIds"))))
    group by $key
  return {  $key :
{|
        for $i in (1 to jn:size($ConnCompoIds))
            for $y in (1 to jn:size($ConnCompoIds($i)("connectedComponentIds")))
                count $c
                let $strIds := fn:concat("ConnId",$c)
                return
                {
                    $strIds:$ConnCompoIds($i)("connectedComponentIds")($y)
                }
|}
}
|}
}
```