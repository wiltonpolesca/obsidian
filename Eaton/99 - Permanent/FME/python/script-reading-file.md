
import fme
import fmeobjects

class FeatureProcessor(object):

    def __init__(self):
        # Read file once and save in cache
        path = fme.macroValues['DemandData_Load_Model_File']
        
        self.lines = []
        
        with open(path, 'r', encoding='utf-8') as data:
            for line in data:
                line = line.strip()
                if line:
                    self.lines.append(line)

    def has_support_for(self, support_type: int):
        return support_type == fmeobjects.FME_SUPPORT_FEATURE_TABLE_SHIM
  
    def input(self, feature: fmeobjects.FMEFeature):

        # reuse cached data
        for line in self.lines:
            self.pyoutput(self.create_new_feature(feature, line))

        self.pyoutput(self.create_new_feature(feature, 'DEFAULT'))

    def create_new_feature(self, feature: fmeobjects.FMEFeature, loadModel: str):
        out_feature = feature.clone()
        out_feature.setAttribute("LoadModelName", loadModel)
        return out_feature

    def close(self):
        pass

    def process_group(self):
        pass

    def reject_feature(self, feature: fmeobjects.FMEFeature, code: str, message: str):
        feature.setAttribute("fme_rejection_code", code)
        feature.setAttribute("fme_rejection_message", message)
        self.pyoutput(feature, output_tag="<Rejected>")
