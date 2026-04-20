# [CYMDI-5788 - Add UDDs for both Existing and Queued DER]([[CYMDI-5788] Add UDDs for both Existing and Queued DER - Jira](https://eaton-corp.atlassian.net/browse/CYMDI-5788))


| DGINT |     | UDD Name               | Original Source Field                                                                                                                                   | FME Source Field                                                                                                                                     | Applies To                | Info                                                                                            |
| ----- | --- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- | ----------------------------------------------------------------------------------------------- |
| Ok    |     | ISBMEnrolled           | Are you applying under the OR ISBM Demonstration program                                                                                                | OR_ISBM_Demonstration                                                                                                                                | DGINT                     | ‘Yes’ if ‘Yes’, otherwwise ‘No’                                                                 |
| oK    |     | SystemCoupling         | d. Indicate whether the ESS and DG system inverter(s)/converter(s) are DC-coupled or AC-coupled and provide the following:                              | IndicateCoupling                                                                                                                                     | DGINT / CDG / LDG         |                                                                                                 |
| Ok    |     | DGEnergySource         | DG Energy Source                                                                                                                                        | DG_Energy_Source                                                                                                                                     | DGINT / CDG / LDG / NJINT |                                                                                                 |
| OK    |     | PVInverterManufacturer | PV System Inverter Manufacturer 1..9                                                                                                                    | SystemINVManufacturer1..n                                                                                                                            | DGINT / CDG / LDG / NJINT | Concatenate all non-null values, separated by a semicolon. ex: <br>« SMA America; SMA America » |
|       |     | ESSManufacturer        | Energy Storage System Battery Manufacturer 1..4                                                                                                         | SystemBattery_Manufacturer1..n                                                                                                                       | DGINT / CDG / LDG / NJINT | Concatenate all non-null values, separated by a semicolon. « Tesla; Tesla;Tesla  »              |
| OK    |     | ESSMaxImportkWAC       | List the systems maximum import in kW AC, including any equipment and ancillary loads (i.e., HVAC) to be installed to facilitate the ESS installation." | j_List_the_systems_maximum_import_in_kW_AC _including_any_equipment_and_ancillary_loads_i_ e_HVAC_to_be_installed_to_facilitate_the_ESS_installation | DGINT / CDG / LDG / NJINT |                                                                                                 |
|       |     | ESSExport              | ESS export                                                                                                                                              | ESS_Export                                                                                                                                           | DGINT / CDG / LDG / NJINT |                                                                                                 |
|       |     | ESSselfConsumption     | ESS self-consumption                                                                                                                                    | ESS_Self_Consumption                                                                                                                                 | CDG                       | PROBLEMA, SÓ EXISTE NO ARQUIVO CDG                                                              |
|       |     | ESSMaxExportkWAC       | Maximum Export Capacity (AC -kW)                                                                                                                        | ESS_Max_Export_k_WAC                                                                                                                                 | NJINT                     |                                                                                                 |

| Champ                                                                                                                                                 | Fichiers                  |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------- |
| List the systems maximum import in kW AC, including any equipment and ancillary loads (i.e., HVAC) to be installed to facilitate the ESS installation | DGINT / CDG / LDG / NJINT |
| maximum import in kW AC                                                                                                                               | LDG                       |
=VLOOKUP(B3531,'pv-udds-output'!C:C,1,FALSE)

|     | UDD Name                 | Source Field                                                   |                                 | Applies To      |
| --- | ------------------------ | -------------------------------------------------------------- | ------------------------------- | --------------- |
| Ok  | DG Energy Source         | PC: DG Energy Source                                           | DG_Energy_Source                | All 4 Programs  |
|     | PV Inverter Manufacturer | PC: PV System Inverter Manufacturer 1…9                        | PV_System_Inverter_Quatity      | All 4 Programs  |
|     | ESS Manufacturer         | PC: ESS Battery Manufacturer 1…n                               | SystemBattery_Manufacturer1...4 | All 4 Programs  |
|     | ESS Max Import kW AC     | PC: Maximum Import (kW AC)                                     |                                 | All 4 Programs  |
|     | ESS Export               | PC: ESS Export                                                 |                                 | All 4 Programs  |
|     | ESS Self‑Consumption     | PC: ESS Self‑Consumption                                       |                                 | All 4 Programs  |
| OK  | System Coupling          | Gateway AC/DC‑coupling determination                           | CouplingMode                    | DGINT, CDG, LDG |
| Ok  | ISBM Enrolled            | PC: “Are you applying under the OR ISBM Demonstration program” |                                 | DGINT only      |
|     | ESS Max Export kW AC     | PC: Maximum Export Capacity (AC‑kW)                            |                                 | NJINT only      |

There are 4 distinct programs for DER interconnection at ORU:
- 50 kW or Less installation (DGINT)
- Greater than 50 kW installation (LDG)
- Community DG (CDG)
- DG interconnection (NJINT)

Circuito utilizado antes da mudança: 82-3-13

Meus test3s:
### DGINt
- 10-2-13
- 22-6-13 -> ok
- 80-3-13 -> vários erros

### LDG
- 45-8-13 (2476 errors)
- 113-5-13
### NJINT
- 28-2-13 (1510 ERRORS)



---
## Transformers modificados

| Transformer                                  | changes              |
| -------------------------------------------- | -------------------- |
| PythonCaller_fillMissingPairedProjectNumbers | Missing `import fme` |

	- 

---
Transformer: PythonCaller_Queued_DER_UDDs



CT_POWERCLERK_TYPE_3 -> entrega o dado para a criação do UDD, bookmark: UDD

_DGINT
_LDG
_CDG
_NJINT


```python
import fme
import fmeobjects


class FeatureProcessor(object):

    DATA_TYPE_STRING = 0

    def has_support_for(self, support_type: int):
        return support_type == fmeobjects.FME_SUPPORT_FEATURE_TABLE_SHIM

    def input(self, feature: fmeobjects.FMEFeature):

        udds = [
            {
                "DataID": "DGEnergySource",
                "DataValue": feature.getAttribute("DG_Energy_Source"),
            },
            {
                "DataID": "PVInverterManufacturer",
                "DataValue": self._get_values_in_loop(
                    feature, "SystemINVManufacturer", 9
                ),
            },
            {
                "DataID": "ESSManufacturer",
                "DataValue": self._get_values_in_loop(
                    feature, "SystemBattery_Manufacturer", 4
                ),
            },
            {
                "DataID": "ESSMaxImportkWAC",
                "DataValue": feature.getAttribute(
                    "j_List_the_systems_maximum_import_in_kW_AC_including_any_equipment_and_ancillary_loads_i_e_HVAC_to_be_installed_to_facilitate_the_ESS_installation"
                ),
            },
            {
                "DataID": "ESS Export",
                "DataValue": feature.getAttribute("ESS_Export"),
            },
        ]

        if (
            feature.getAttribute("_LDG") == 1
            or feature.getAttribute("_CDG") == 1
            or feature.getAttribute("_DGINT") == 1
        ):
            udds.append(
                {
                    "DataID": "SystemCoupling",
                    "DataValue": feature.getAttribute("IndicateCoupling"),
                }
            )

        if feature.getAttribute("_CDG") == 1:
            udds.append(
                {
                    "DataID": "ESSselfConsumption",
                    "DataValue": feature.getAttribute("ESS_Self_Consumption"),
                },
            )

        if feature.getAttribute("_DGINT") == 1:
            udds.append(
                {
                    "DataID": "ISBMEnrolled",
                    "DataValue": (
                        "Yes"
                        if feature.getAttribute("OR_ISBM_Demonstration")
                        == "Yes"
                        else "No"
                    ),
                }
            )

        if feature.getAttribute("_NJINT") == 1:
            udds.append(
                {
                    "DataID": "ESSMaxExportkWAC",
                    "DataValue": feature.getAttribute("ESS_Max_Export_k_WAC"),
                }
            )

        for udd in udds:
            dataValue = udd["DataValue"]
            dataID = udd["DataID"]

            if dataValue is not None and dataValue != "":
                out_feature = feature.clone()
                out_feature.setAttribute("DataType", self.DATA_TYPE_STRING)
                out_feature.setAttribute("DataID", dataID)
                out_feature.setAttribute("DataValue", dataValue)
                self.pyoutput(out_feature)

    def _get_values_in_loop(
        self, feature: fmeobjects.FMEFeature, attribute_prefix: str, count: int
    ):
        device = feature.getAttribute("DeviceNumber"),
        values = []
        for i in range(1, count + 1):
            try:
                attribute_name = f"{attribute_prefix}{i}"
                value = feature.getAttribute(attribute_name)
                if value is not None and value != "":
                    values.append(value)
            except Exception as e:
                continue

        result = ";".join(values)
        return result

    def process_group(self):
        pass

    def close(self):
        pass

    def reject_feature(
        self, feature: fmeobjects.FMEFeature, code: str, message: str
    ):
        feature.setAttribute("fme_rejection_code", code)
        feature.setAttribute("fme_rejection_message", message)
        self.pyoutput(feature, output_tag="<Rejected>")

```