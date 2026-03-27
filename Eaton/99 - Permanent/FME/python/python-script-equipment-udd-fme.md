Author: Wilton L Polesca de Souza, 
Client: `ORU`, 
Transformateur: `PythonCaller_SetUDD`
FME Version: **2023.2.4.0**
[[python-script-equipment-udd-fme-2024.2.2.0|Ce scénario était basé sur ceci.]]
```python
import fme
import fmeobjects

class FeatureProcessor(object):

    DEVICE_TYPE_SWITCH = 6
    DATA_TYPE_STRING = 0

    def has_support_for(self, support_type: int):
        return support_type == fmeobjects.FME_SUPPORT_FEATURE_TABLE_SHIM

    def input(self, feature: fmeobjects.FMEFeature):

        udds = [
            {"DataID": "SwitchType", "DataValue": feature.getAttribute("CmpType")},
            {"DataID": "FID",        "DataValue": feature.getAttribute("fid")},
            {"DataID": "CmpType",    "DataValue": feature.getAttribute("CmpType")},
            {"DataID": "PartName",   "DataValue": feature.getAttribute("PartName")},
        ]

        for udd in udds:
            data_value = udd["DataValue"]

            if data_value:
                feature.setAttribute("DeviceType", self.DEVICE_TYPE_SWITCH)
                feature.setAttribute("DataType", self.DATA_TYPE_STRING)
                feature.setAttribute("DataID", udd["DataID"])
                feature.setAttribute("DataValue", data_value)

                self.pyoutput(feature)

    def process_group(self):
        pass

    def close(self):
        pass

    def reject_feature(self, feature: fmeobjects.FMEFeature, code: str, message: str):
        feature.setAttribute("fme_rejection_code", code)
        feature.setAttribute("fme_rejection_message", message)
        self.pyoutput(feature, output_tag="<Rejected>")
```

Notes:
- N'oubliez pas de remplir l'attribut «Attributes to Expose»
  > `DeviceType DataType DataID DataValue NetworkID DeviceNumber`