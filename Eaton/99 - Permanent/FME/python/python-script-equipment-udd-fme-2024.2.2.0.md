,Author: Jean Sebastien, 
Client: `Fortis Alberta`, 
Transformateur: `PythonCaller_SetUDD`
FME Version: **2024.2.2.0**

```Python
import fme
from fme import BaseTransformer
import fmeobjects


class FeatureProcessor(BaseTransformer):

    def __init__(self):
        pass

    def has_support_for(self, support_type: int):

        return support_type == fmeobjects.FME_SUPPORT_FEATURE_TABLE_SHIM

    def input(self, feature: fmeobjects.FMEFeature):
        
        # Declare Each UDD    
        UDDs = [
            {"DataID": "PSN",                   "DataValue": feature.getAttribute('_ElectricJonctionObjects{0}.EJO.SITE_ID')},
            {"DataID": "CustomerName",          "DataValue": feature.getAttribute('CustomerInfo.Preferred_Name_of_Business_Part')},
            {"DataID": "OWNER_NAME",            "DataValue": feature.getAttribute('ElectricDevice.ownedby')},
            {"DataID": "G3E_FID",               "DataValue": feature.getAttribute('ElectricDevice.G3E_ID')},
            {"DataID": "REA_NAME",              "DataValue": feature.getAttribute('ElectricDevice.REA_NAME')},
            {"DataID": "LastGISModifiedDate",   "DataValue": feature.getAttribute('ElectricDevice.last_edited_date')},
            {"DataID": "LastGISUserModified",   "DataValue": feature.getAttribute('ElectricDevice.last_edited_user')},
            {"DataID": "CRITICAL",              "DataValue": feature.getAttribute('CustomerInfo.Critical_Customer')},
            {"DataID": "CRITICAL_COMMENT",      "DataValue": feature.getAttribute('CustomerInfo.Life_Support_Comments')},
            {"DataID": "Municipality_Code",     "DataValue": feature.getAttribute('CustomerInfo.Municipality_Code')},
            {"DataID": "Energization_Status",   "DataValue": feature.getAttribute('CustomerInfo.Installation_Type_Description')},
            {"DataID": "Idle",                  "DataValue": feature.getAttribute('CustomerInfo.Used_or_Idle')},
            {"DataID": "LifeCycleStatus",       "DataValue": feature.getAttribute('ElectricDevice.lifecyclestatus_resolved')},
            {"DataID": "DeviceSize",            "DataValue": feature.getAttribute('ElectricDevice.devicesize')},        
            {"DataID": "IsYoDo",                "DataValue": feature.getAttribute('ElectricDevice.IsYoDo')},             
            {"DataID": "Meter_Type",            "DataValue": feature.getAttribute('CustomerInfo.Metering_Type_Description')},             
        ]
            
        # Create a feature for each UDD
        for UDD in UDDs:
            if UDD["DataValue"] is not None and UDD["DataValue"] != "":      
                out_feature = feature.clone()
                out_feature.setAttribute("DataID", UDD["DataID"])
                out_feature.setAttribute("DataValue", UDD["DataValue"])
            
                self.pyoutput(out_feature, output_tag="PYOUTPUT")

    def close(self): 
        pass

    def process_group(self):
        pass

    def reject_feature(self, feature: fmeobjects.FMEFeature, code: str, message: str):
        feature.setAttribute("fme_rejection_code", code)
        feature.setAttribute("fme_rejection_message", message)
        self.pyoutput(feature, output_tag="<Rejected>")

```
