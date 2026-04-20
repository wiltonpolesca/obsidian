```python
import fme
import fmeobjects


class FeatureProcessor(object):

    DATA_TYPE_STRING = 0
    EXPORT_ALLOWED = "Export allowed"
    EXPORT_PERMITTED = "Export permitted"
    EXPORT_NOT_PERMITTED = "Export not permitted"
    EXPORT_LIMITED = "Export limited/no permitted"

    LOWER_YES = "yes"
    LOWER_NO = "no"

    YES_VALUE = "Yes"
    NO_VALUE = "No"

    TRUE = "true"
    FALSE = "false"

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
                "DataID": "ESSselfConsumption",
                "DataValue": (
                    self.YES_VALUE
                    if self._normalize_and_lower_string(
                        feature.getAttribute("ESS_Self_Consumption")
                    )
                    == self.LOWER_YES
                    else self.NO_VALUE
                ),
            },
        ]

        ESSExport = feature.getAttribute("ESS_Export")

        if (
            feature.getAttribute("_LDG") == 1
            or feature.getAttribute("_CDG") == 1
            or feature.getAttribute("_DGINT") == 1
        ):
            export_status = ESSExport

            if self._normalize_and_lower_string(ESSExport) == self.LOWER_YES:
                export_status = self.EXPORT_PERMITTED

            elif self._normalize_and_lower_string(ESSExport) == self.LOWER_NO:
                export_status = self.EXPORT_NOT_PERMITTED

            udds.append(
                {
                    "DataID": "SystemCoupling",
                    "DataValue": feature.getAttribute("IndicateCoupling"),
                }
            )
            udds.append(
                {
                    "DataID": "ESSExport",
                    "DataValue": export_status,
                },
            )

        if feature.getAttribute("_DGINT") == 1:

            export_status = self._get_njint_ess_export_value(feature, ESSExport)

            udds.append(
                {
                    "DataID": "ISBMEnrolled",
                    "DataValue": (
                        self.YES_VALUE
                        if self._normalize_and_lower_string(
                            feature.getAttribute("OR_ISBM_Demonstration")
                        )
                        == self.LOWER_YES
                        else self.NO_VALUE
                    ),
                },
            )

            udds.append(
                {
                    "DataID": "ESSExport",
                    "DataValue": export_status,
                },
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
        values = []
        for i in range(1, count + 1):
            try:
                attribute_name = f"{attribute_prefix}{i}"
                value = feature.getAttribute(attribute_name)
                if value is not None and value != "":
                    values.append(value)

            except Exception:
                continue

        result = ";".join(values)
        return result

    def _get_njint_ess_export_value(
        self, feature: fmeobjects.FMEFeature, ess_export: str
    ):
        ESSMaxExportkWAC = feature.getAttribute("ESS_Max_Export_k_WAC")
        OffsetLoad = feature.getAttribute("Offset_Load")

        if ESSMaxExportkWAC is None or ESSMaxExportkWAC == "":
            return self.EXPORT_ALLOWED

        if (
            ess_export is None
            or ess_export == ""
            and self._normalize_and_lower_string(OffsetLoad) == self.FALSE
        ):
            return self.EXPORT_ALLOWED

        if (
            ess_export is None
            or ess_export == ""
            and self._normalize_and_lower_string(OffsetLoad) == self.TRUE
        ):
            return self.EXPORT_LIMITED

        if self._normalize_and_lower_string(ess_export) == self.LOWER_NO:
            return self.EXPORT_LIMITED

        if self._normalize_and_lower_string(ess_export) == self.LOWER_YES:
            return self.EXPORT_ALLOWED

    def _normalize_and_lower_string(self, value: str | None) -> str:
        if value is None:
            return ""
        return value.strip().lower()

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