# CYMDI-5889 - Change rule to determine ConverterACSideNominalVoltage

For DGINT:

From related transformer secondary side voltage

If not found, assume 0.24kV

For LDG, CDG & NJINT:

1)      PC.Final Secondary Voltage (V) (LDG,CDG)
2)      PC.GSU/D XFMR Secondary Voltage (V) (NJINT)
3)      From related transformer secondary side voltage
4)      CEC inverter Database (PC. PV System Inverter Model 1  = EquipmentID)

(make sure to use LL Voltage)

If null, Default to 13.2 (CDG,LDG)

Or, for NJINT, id kW > 50kW à13.2 else 240V

If no GSU around, skip directly to step 3.