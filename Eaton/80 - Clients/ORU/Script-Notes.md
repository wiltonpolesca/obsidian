# ADMS_Export.py

[Github Repository]([sandialabs/Python-Automation-with-CymPy: Customizable python scripts for automating electric power grid analyses in CYME using the CymPy library](https://github.com/sandialabs/Python-Automation-with-CymPy))
###### Copilot summary

This script is a data extraction tool designed to export power system network data from the **CYME** engineering software into specific CSV formats, likely for an **ADMS** (Advanced Distribution Management System) or a system named "DEW".

It uses the `cympy` Python library to query the currently loaded network model and generates five distinct CSV files.

### High-Level Workflow

1. **Iterate**: It loops through specific types of network objects (Sources, Underground Cables, Capacitors).
2. **Filter**: It applies logic to select specific items (e.g., only "Substation" sources or Cables that are "Bus Bars").
3. **Query**: It extracts specific electrical and asset data (Voltage, Resistance, Phasing, FIDs).
4. **Transform**: It converts values (e.g., changing phasing 'ABC' to number '7.0', or calculating Line-to-Line voltage).
5. **Write**: It saves the data to semicolon-separated CSV files.

### Detailed Output Breakdown

The script generates the following files in `C:\Projets\Gateways\ORU\Export_ADMS\TestOutput\`:

#### 1. `dew_connection.csv`

- **Purpose**: Defines the connectivity (topology) of the network.
- **Logic**:
    - Starts at "Substation" sources.
    - Traverses the network downstream using `NetworkIterator`.
    - Records pairs of devices (`fida;fidb`) that are connected to each other.
    - Includes logic to detect and skip duplicate connections.

#### 2. `dew_sources.csv`

- **Purpose**: Exports details about the power sources (Substation feeder heads).[[]]
- **Data Extracted**:
    - Impedance values: Positive/Zero sequence Resistance (`r1`, `r0`) and Reactance (`x1`, `x0`).
    - Operating Voltage (`OperatingKV`).
    - Component Name and ID.

#### 3. `dew_busbar.csv`

- **Purpose**: Exports short connector segments within substations.
- **Logic**:
    - Loops through all "Underground" devices.
    - **Filters IN** devices where `CmpType` is "Bus Bar" or "Rated BusBar".
- **Data Extracted**: Length, Voltage, Phasing.

#### 4. `dew_primary.csv`

- **Purpose**: Exports the main underground distribution lines.
- **Logic**:
    - Loops through all "Underground" devices (same list as above).
    - **Filters OUT** the Bus Bars (processing everything else).
- **Data Extracted**: Construction type, Phase Material, Phase Size, Length.

#### 5. `dew_capacitor.csv`

- **Purpose**: Exports capacitor bank data.
- **Transformations**:
    - **Voltage**: Converts Line-to-Neutral (`CapKVLN`) to Line-to-Line (`* sqrt(3)`).
    - **Control Type**: Maps to 'Fixed' or 'Switched'.
    - **Phasing Map**: Converts string phases (e.g., 'ABC', 'A', 'BC') into numeric codes (7.0, 4.0, 3.0, etc.).
    - **Connection**: Maps 'Yg'/'Y' to 'Wye' and 'D' to 'Delta'.

### Observations on Code Quality

- **Hardcoded Paths**: The file paths are hardcoded to a specific user directory (`C:\Projets...`), which will break if run on a different machine.
- **Error Handling**: The `try...except` block at the end is very broad. It catches _all_ errors and simply prints "Error" without showing what went wrong, which makes debugging very difficult.
- **Commented Logic**: There are several commented-out lines (like `# Reactivate next 2 lines...`) indicating this script might be in a temporary testing state or relies on an external runner to load the network first.