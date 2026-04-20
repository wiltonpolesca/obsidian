# Cympy

Example about how to use cympy library to export data (ORU client)

```python
# Copyright 2026 Eaton.
# All rights reserved.
#
# Proprietary to Eaton in the U.S. and other countries.
# You are not permitted to use this file without the prior written consent of
# Eaton or without a valid contract with Eaton (CYME).
#
# For additional information, contact: cymesupport@eaton.com

# NAME: ORU exporting ADMS data
# DESCRIPTION: This script exports data from CYME to DEW CSV files.

# PARAMETER: Output directory for the generated DEW CSV files, STRING, c://temp//csv_output

import os
from typing import Iterator, Sequence
from pathlib import Path
import logging
import math
import cympy

LOGGER = logging.getLogger(__name__)

OUTPUT_DIR = Path(cympy.GetParameterAsText(1))

DEW_SOURCE_FILE = "dew_sources.csv"
DEW_CONNECTION_FILE = "dew_connection.csv"
DEW_FEEDERS_FILE = "dew_feeders.csv"
DEW_BUSBAR_FILE = "dew_busbar.csv"
DEW_PRIMARY_FILE = "dew_primary.csv"
DEW_CAPACITOR_FILE = "dew_capacitor.csv"
DEW_REGULATOR_FILE = "dew_regulator.csv"
DEW_REGULATOR_TYPE_FILE = "dew_regulator_type.csv"
DEW_TRANS_FILE = "dew_trans.csv"
DEW_TRANS_TYPE_FILE = "dew_trans_type.csv"
DEW_SWITCHES_FILE = "dew_switches.csv"
DEW_GEOM_FILE = "dew_geom.csv"

SOURCE_NODE_ID_SUBSTRING = "SOURCE_"
CONNECTED = "connected"

CONNECTION_TYPE_MAPPING = {
    "Yg": "Wye",
    "Y": "Wye",
    "D": "Delta",
}

CONNECTION_TYPE_TRANSFORMER_MAPPING = {
    "Yg": "WyeG",
    "Y": "Wye",
    "D": "Delta",
}


FILES = [
    DEW_SOURCE_FILE,
    DEW_CONNECTION_FILE,
    DEW_FEEDERS_FILE,
    DEW_BUSBAR_FILE,
    DEW_PRIMARY_FILE,
    DEW_CAPACITOR_FILE,
    DEW_REGULATOR_FILE,
    DEW_REGULATOR_TYPE_FILE,
    DEW_TRANS_FILE,
    DEW_TRANS_TYPE_FILE,
    DEW_SWITCHES_FILE,
    DEW_GEOM_FILE,
]

HEADERS: dict[str, Sequence[str]] = {}


def main() -> int:
    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s: %(message)s",
    )

    try:
        # Deactivate the GUI refresh
        cympy.app.ActivateRefresh(False)

        _load_headers()

        LOGGER.info(
            "Exporting CYME data to DEW CSV files in directory: %s",
            OUTPUT_DIR,
        )

        export_all(OUTPUT_DIR)
    except Exception:
        LOGGER.exception("Export failed")
        return 1

    # Reactivate modifications history
    cympy.app.ActivateRefresh(True)

    LOGGER.info("Export completed successfully")
    return 0


def export_all(output_dir: Path) -> None:
    seen_connections: set[tuple[str, str]] = set()
    output_dir.mkdir(parents=True, exist_ok=True)

    listSubstations = cympy.db.ListNetworks(cympy.enums.NetworkType.Substation)
    cympy.study.LoadNetworks(listSubstations)

    LOGGER.info(" - Initializing output files...")
    for file in FILES:
        _delete_file_if_exists(output_dir / file)

    for file in FILES:
        _write_to_csv(output_dir / file, HEADERS[file])

    LOGGER.info(" - Getting source info and generating files...")

    for source_node in cympy.study.ListNodes(cympy.enums.NodeType.SourceNode):
        network_id = _query_node("NetworkId", source_node.ID)
        network = cympy.study.GetNetwork(network_id)

        if network.NetworkType != cympy.enums.NetworkType.Substation:
            continue

        if (
            result := get_dew_sources_row(source_node.ID, network_id)
        ) is not None:
            _write_to_csv(output_dir / DEW_SOURCE_FILE, result)

        if (
            result := get_dew_feeders_row(source_node.ID, network_id, None)
        ) is not None:
            _write_to_csv(output_dir / DEW_FEEDERS_FILE, result)

        for connection in get_dew_connection_rows(
            source_node, network_id, seen_connections
        ):
            _write_to_csv(output_dir / DEW_CONNECTION_FILE, connection)

    seen_connections.clear()

    LOGGER.info(" - Getting devices info and generating files...")
    for device in cympy.study.ListDevices(cympy.enums.DeviceType.AllDevices):
        if (result := get_dew_busbar_row(device)) is not None:
            _write_to_csv(output_dir / DEW_BUSBAR_FILE, result)

        if (result := get_dew_primary_row(device)) is not None:
            _write_to_csv(output_dir / DEW_PRIMARY_FILE, result)

        if (result := get_dew_regulator_row(device)) is not None:
            _write_to_csv(output_dir / DEW_REGULATOR_FILE, result)

        if (result := get_dew_regulator_type_row(device)) is not None:
            _write_to_csv(output_dir / DEW_REGULATOR_TYPE_FILE, result)

        if (result := get_dew_switches_row(device)) is not None:
            _write_to_csv(output_dir / DEW_SWITCHES_FILE, result)

        if (result := get_dew_trans_row(device)) is not None:
            _write_to_csv(output_dir / DEW_TRANS_FILE, result)

        if (result := get_dew_trans_type_row(device)) is not None:
            _write_to_csv(output_dir / DEW_TRANS_TYPE_FILE, result)

        if (result := get_dew_capacitor_row(device)) is not None:
            _write_to_csv(output_dir / DEW_CAPACITOR_FILE, result)

        if (result := get_dew_feeders_row(None, None, device)) is not None:
            _write_to_csv(output_dir / DEW_FEEDERS_FILE, result)

        if (result := get_dew_geom_row(device)) is not None:
            _write_to_csv(output_dir / DEW_GEOM_FILE, result)


def get_dew_busbar_row(
    device: cympy.study.Device,
) -> Sequence[str] | None:

    if device.DeviceType != cympy.enums.DeviceType.Underground:
        return None

    BUSBAR_TYPES = {"Bus Bar", "Rated BusBar"}

    if (component_type := _query_device("CmpType", device)) not in BUSBAR_TYPES:
        return None

    return (
        device.SectionID,  # fid
        _query_device("OriginalLength", device),  # Length
        _query_device(
            "DEW_OperatingKV", device
        ),  # OperatingKV TODO: OperatingKV was mapped but it is not available
        component_type,  # CmpType
        _query_device("CmpName", device),  # CmpName
        _map_phase(_query_device("Phase", device)),  # Phasing
        1,  # mainline
    )


def get_dew_primary_row(device: cympy.study.Device) -> Sequence[str] | None:

    if device.DeviceType != cympy.enums.DeviceType.Underground:
        return None

    BUSBAR_TYPES = {"Bus Bar", "Rated BusBar"}

    if (component_type := _query_device("CmpType", device)) in BUSBAR_TYPES:
        return None

    return (
        _query_device("SectionId", device),  # fid
        _query_device("Primary_Construction", device),  # Construction
        _query_device("OriginalLength", device),  # Length
        _query_device(
            "DEW_OperatingKV", device
        ),  # OperatingKV TODO: OperatingKV was mapped but it is not available
        _query_device("Primary_PhaseSize", device),  # PhaseSize
        _query_device("Primary_PhaseMaterial", device),  # PhaseMaterial
        component_type,  # CmpType
        _query_device("CmpName", device),  # CmpName
        _query_device("Primary_PhaseCond", device),  # PhaseCond
        _map_phase(_query_device("Phase", device, "7.0")),  # Phasing
    )


def get_dew_regulator_row(device: cympy.study.Device) -> Sequence[str] | None:

    if device.DeviceType != cympy.enums.DeviceType.Regulator:
        return None

    tapSide = "SECONDARY"  # TODO: TBD
    defaultCmpName = "Voltage Regulator"
    NO_REG_REV_MODE = {
        "No reverse": "no",
        "Locked forward": "no",
        "Locked reverse": "no",
    }

    operatinKv = _to_kv(_query_device("RegKVLN", device))

    priconnection = CONNECTION_TYPE_MAPPING.get(
        _query_device("RegConfig", device)
    )

    return (
        _query_device("FID", device),  # fid
        _query_device("RegVset", device),  # BaseVoltage
        _query_device("EqId", device),  # PartName
        operatinKv,  # OperatingKV
        operatinKv,  # SecVolt
        _query_device("RegKVA", device),  # PerPhKva (A)
        _query_device("RegKVA", device),  # PerPhKva (C)
        _query_device("RegKVA", device),  # PerPhKva (B)
        _query_device("RegBandw", device),  # CtrlBandWidth
        defaultCmpName,  # CmpType
        (
            "1.0"
            if _normalize_and_lower_string(
                _query_device(
                    "EqStatus",
                    device,
                )
            )
            == CONNECTED
            else "0.0"
        ),  # SwitchStatus
        _query_device("EqNo", device),  # CmpName
        _map_phase(_query_device("Phase", device, "7.0")),  # Phasing
        _query_device("RegKVLN", device),  # PriVolt
        priconnection,  # priconnection
        priconnection,  # secconnection
        NO_REG_REV_MODE.get(
            _query_device("RegRevMode", device),
            "yes",
        ),  # bidirectional
        _query_device("RegRevBandw", device),  # bandwidth
        "",  # controlPhase TODO: TBD
        _query_device("RegVset", device),  # desiredVoltage
        0,  # initialtap1
        0,  # initialtap2
        0,  # initialtap3
        tapSide,  # tapside
        _query_device("EqId", device),  # name
        _query_device("FID", device) + "_temp",  # transformer_type
    )


def get_dew_regulator_type_row(
    device: cympy.study.Device,
) -> Sequence[str] | None:

    if device.DeviceType != cympy.enums.DeviceType.Regulator:
        return None

    transformerType = "Regulator"
    NO_REG_REV_MODE = {
        "No reverse": "no",
        "Locked forward": "no",
        "Locked reverse": "no",
    }

    regKVA = _query_device("RegKVA", device)
    regNbtapDividedBy2 = _divide_or_return_zero(
        _query_device("RegNbtap", device), 2.0
    )

    return (
        _query_device("FID", device) + "_temp",  # fid
        _query_device("RegVset", device),  # BaseVoltage
        regKVA,  # PerPhKva (A)
        regKVA,  # PerPhKva (C)
        regKVA,  # PerPhKva (B)
        _query_device("RegBandw", device),  # CtrlBandWidth
        (
            "1.0"
            if _normalize_and_lower_string(_query_device("EqStatus", device))
            == CONNECTED
            else "0.0"
        ),  # SwitchStatus
        NO_REG_REV_MODE.get(
            _query_device("RegRevMode", device), "yes"
        ),  # bidirectional
        0,  # initialtap1
        0,  # initialtap2
        0,  # initialtap3
        regNbtapDividedBy2,  # blockedstep
        regNbtapDividedBy2,  # tapSteps
        regKVA,  # kva
        "",  # summerKVA TODO: TBD
        "",  # summerEmergKva TODO: TBD
        "",  # winterKVA TODO: TBD
        "",  # winterEmergKva TODO: TBD
        "0.051",  # percentresistance
        "0.52",  # percentreactance
        _query_device("FID", device),  # name
        transformerType,  # transformertype
        _map_phase(_query_device("Phase", device, "7.0")),  # phase
        (-1 * regNbtapDividedBy2),  # minTap
        regNbtapDividedBy2,  # maxTap
    )


def get_dew_switches_row(device: cympy.study.Device) -> Sequence[str] | None:

    DEVICE_TYPES = {
        cympy.enums.DeviceType.Breaker,
        cympy.enums.DeviceType.Switch,
        cympy.enums.DeviceType.Fuse,
        cympy.enums.DeviceType.Recloser,
        cympy.enums.DeviceType.Sectionalizer,
    }

    if device.DeviceType not in DEVICE_TYPES:
        return None

    return (
        _query_device("FID", device),  # fid
        _query_device("PartName", device),  # PartName
        "",  # OperatingKV TTODO: TBD
        _query_device("CmpType", device),  # CmpType
        (
            "1.0"
            if _normalize_and_lower_string(_query_device("EqState", device))
            in {"close", "closed"}
            else "0.0"
        ),  # SwitchStatus
        _query_device("ProtAmps", device),  # ratedAmps
        _query_device("EqNo", device),  # CmpName
        _map_phase(_query_device("Phase", device, "7.0")),  # Phasing
        1,  # mainline
    )


def get_dew_trans_row(device: cympy.study.Device) -> Sequence[str] | None:

    DEVICE_TYPES = {
        cympy.enums.DeviceType.Transformer,
        cympy.enums.DeviceType.ThreeWindingTransformer,
    }

    if device.DeviceType not in DEVICE_TYPES:
        return None

    isTwoWinding = device.DeviceType == cympy.enums.DeviceType.Transformer
    S1ConnectionDefault = "28"
    TRANSFORM_CONNECTION = {
        "Yg-Yg": 1,
        "Yg-D": 6,
        "D-Yg": 8,
        "D-D": 10,
    }

    priVolt = _query_device(
        "XfoKVLL1" if isTwoWinding else "TWPrimaryVoltage", device
    )
    priconnection = _query_device(
        "XfoConn" if isTwoWinding else "TWConnection", device
    ).split("-")[0]

    secconnection = _query_device(
        "XfoConn" if isTwoWinding else "TWConnection", device
    ).split("-")[1]

    if priconnection in ("Yg", "Y"):
        priVolt = _to_float(priVolt)
        priVolt = priVolt / math.sqrt(3.0)

    desiredVoltage = ""
    bandwidth = ""
    controlPhase = ""
    initialTap = ""

    if _normalize_and_lower_string(_query_device("XfoIsLTC", device)) == "yes":
        desiredVoltage = (
            _divide_or_return_zero(
                _query_device(
                    "XfoVset" if isTwoWinding else "TWFirstVSet", device
                ),
                100,
            )
            * 120
        )

        if isTwoWinding:
            bandwidth = (
                _divide_or_return_zero(
                    _to_float(_query_device("XfoBand", device))
                    + _to_float(_query_device("XfoLowerBand", device)),
                    100,
                )
                * 120
            )
        else:
            bandwidth = (
                _divide_or_return_zero(
                    _to_float(_query_device("TWFirstUpperband", device))
                    + _to_float(_query_device("TWFirstLowerband", device)),
                    100,
                )
                * 120
            )

        controlPhase = ""  # TODO: TBD
        initialTap = ""  # TODO: TBD

    return (
        _query_device("FID", device),  # fid
        TRANSFORM_CONNECTION.get(
            _query_device("XfoConn", device),
            S1ConnectionDefault,
        ),  # S1Connection TODO: TBD CHECK THE CORRECT PROPERTY NAME
        _query_device("PartName", device),  # PartName
        _query_device(
            "XfoKVLL1" if isTwoWinding else "TWPrimaryVoltage",
            device,
        ),  # OperatingKV
        _query_device(
            "XfoKVLL2" if isTwoWinding else "TWSecondaryVoltage",
            device,
        ),  # SecVolt
        _query_device("CmpType", device),  # CmpType
        _query_device("EqNo", device),  # CmpName
        _map_phase(_query_device("Phase", device, "7.0")),  # Phasing
        priVolt,  # PriVolt
        1,  # mainline
        "",  # S2Connection
        CONNECTION_TYPE_TRANSFORMER_MAPPING.get(
            priconnection, "WyeG"
        ),  # priconnection
        CONNECTION_TYPE_TRANSFORMER_MAPPING.get(
            secconnection, "WyeG"
        ),  # secconnection
        desiredVoltage,  # desiredVoltage
        bandwidth,  # bandwidth
        controlPhase,  # controlPhase
        initialTap,  # initialTap
        _query_device("FID", device) + "_temp",  # fid
        "",  # tapside # TODO: TBD (PRIMARY or  SECONDARY)
        _query_device("PartName", device),  # name
    )


def get_dew_trans_type_row(device: cympy.study.Device) -> Sequence[str] | None:

    DEVICE_TYPES = {
        cympy.enums.DeviceType.Transformer,
        cympy.enums.DeviceType.ThreeWindingTransformer,
    }

    if device.DeviceType not in DEVICE_TYPES:
        return None

    isTwoWinding = device.DeviceType == cympy.enums.DeviceType.Transformer

    automode = ""
    tapSteps = 16
    xfoIsLTC = _query_device("XfoIsLTC", device)

    transformertype = "LTC"
    mintap = ""
    maxtap = ""
    if _normalize_and_lower_string(xfoIsLTC) != "yes":
        transformertype = "Fixed"
        automode = 1
        mintap = ""  # TODO: TBD
        maxtap = ""  # TODO: TBD

    return (
        _query_device("FID", device),  # fid
        "1",  # mainline
        automode,
        "0.0",  # gangctrld
        transformertype,  # transformertype
        tapSteps,  # tapSteps
        _query_device(
            "XfoKVANomTot" if isTwoWinding else "TWPrimaryRatedCapacity",
            device,
        ),  # kva
        (
            ""
            if isTwoWinding
            else _query_device("TWPrimaryCapacityLimit1", device)
        ),  # summerKVA TODO: TBD
        (
            ""
            if isTwoWinding
            else _query_device("TWPrimaryCapacityLimit2", device)
        ),  # summerEmergKva TODO: TBD
        "",  # winterKVA
        "",  # winterEmergKva
        _query_device("XfoR1", device),  # percentresistance
        (
            _to_float(_query_device("XfoR1", device))
            * _to_float(_query_device("XfoX1R1Ratio", device))
        ),  # percentreactance
        _query_device("FID", device),  # name
        _map_phase(_query_device("Phase", device, "7.0")),  # phases
        mintap,  # mintap
        maxtap,  # maxtap
    )


def get_dew_capacitor_row(device: cympy.study.Device) -> Sequence[str] | None:
    if device.DeviceType != cympy.enums.DeviceType.ShuntCapacitor:
        return None

    return (
        _query_device("FID", device),  # fid
        (
            "Fixed"
            if (_normalize_and_lower_string(_query_device("CapCtr", device)))
            == "manual"
            else "Switched"
        ),  # ControlType
        _to_kv(_query_device("CapKVLN", device)),  # OperatingKV
        _query_device("CapKVARC", device),  # KVARsPerStepC
        _query_device("CapKVARB", device),  # KVARsPerStepB
        _query_device("CapKVARA", device),  # KVARsPerStepA
        (
            "1.0"
            if (_normalize_and_lower_string(_query_device("EqStatus", device)))
            == CONNECTED
            else "0.0"
        ),  # witchStatus
        _query_device("EqNo", device),  # CmpName
        _map_phase(_query_device("Phase", device, "7.0")),  # Phasing
        _query_device("CooldownPeriod", device),  # CooldownPeriod
        _query_device("maxoperations", device),  # maxoperations
        _query_device("CapSensingPhase", device),  # controlphase
        1,  # mainline
        CONNECTION_TYPE_MAPPING.get(
            _query_device("CapConfig", device),
            "Unknown",
        ),  # connectionType
    )


def get_dew_sources_row(nodeId: str, networkId: str) -> Sequence[str] | None:
    return (
        _query_node("FID", nodeId),  # fid
        _query_node("SourceR1ohms", nodeId),  # positiveSequenceResistance
        _query_node("SourceKVNom", nodeId),  # OperatingKV
        _query_node("SourceX0ohms", nodeId),  # zeroSequenceReactance
        _query_node("SourceX1ohms", nodeId),  # positiveSequenceReactance
        networkId,  # CmpName
        _query_node("SourceR0ohms", nodeId),  # zeroSequenceResistance
        "True",  # nominalState
    )


def get_dew_feeders_row(
    nodeId: str | None,
    networkId: str | None,
    device: cympy.study.Device | None,
) -> Sequence[str] | None:

    TRANSFORMERS = {
        cympy.enums.DeviceType.Transformer,
        cympy.enums.DeviceType.ThreeWindingTransformer,
    }

    if device is not None:
        if device.DeviceType not in TRANSFORMERS:
            return None

        return (
            _query_device("FID", device),  # fid
            _query_device("EqNo", device),  # CmpName
            1,  # mainline
        )

    # Remove the SOURCE_NODE_ID_SUBSTRING from the nodeId to get the correct feeder name in DEW
    cmpName = nodeId.replace(SOURCE_NODE_ID_SUBSTRING, "")
    return (
        _query_node("FID", nodeId),  # fid
        cmpName,  # CmpName
        "1",  # mainline
    )


def get_dew_connection_rows(
    node: cympy.study.Node,
    networkId: str | None,
    seen_connections: set[tuple[str, str]],
) -> Iterator[Sequence[str]]:

    previous_device_fid = _query_node("NodeId", node.ID)
    previous_unique_id = _format_unique_id(
        node.GetObjType(), previous_device_fid
    )

    downstream_iterator = cympy.study.NetworkIterator(
        node.ID,
        cympy.enums.IterationOption.Downstream,
    )

    while downstream_iterator.Next():
        devices = downstream_iterator.GetDevices()
        if not devices:
            continue

        upstream_identity = _get_upstream_device_identity(devices[0].SectionID)

        if upstream_identity is not None:
            previous_device_fid, previous_unique_id = upstream_identity

        for device in devices:
            device_fid = _query_device("EqNo", device)
            device_unique_id = _format_unique_id(
                device.GetObjType(), device_fid
            )
            connection_key = (previous_unique_id, device_unique_id)

            if connection_key not in seen_connections:
                seen_connections.add(connection_key)
                yield (previous_device_fid, device_fid)

            previous_device_fid = device_fid
            previous_unique_id = device_unique_id


def get_dew_geom_row(
    device: cympy.study.Device,
) -> Sequence[str] | None:

    rotation = "0.0"
    sizeFactor = "1.0"
    geom = ""

    DEVICE_TYPES_WITH_LINESTRING = {
        cympy.enums.DeviceType.Underground,
        cympy.enums.DeviceType.OverheadLine,
        cympy.enums.DeviceType.OverheadLineUnbalanced,
    }

    # Device Info
    deviceInfo = cympy.study.FindDeviceInfo(
        device.DeviceType,
        device.DeviceNumber,
        [device.NetworkID],
    )[0]

    if device.DeviceType in DEVICE_TYPES_WITH_LINESTRING:
        section = cympy.study.GetSection(device.DeviceNumber)
        points = section.ListIntermediatePoints()

        geom = f"LINESTRING({deviceInfo.FromNodePosition.X} {deviceInfo.FromNodePosition.Y}"
        for point in points:
            geom += f", {point.X} {point.Y}"
        geom += (
            f", {deviceInfo.ToNodePosition.X} {deviceInfo.ToNodePosition.Y})"
        )

    else:
        if (
            deviceInfo.ToNodePosition is None
            or deviceInfo.FromNodePosition.X is None
            or deviceInfo.FromNodePosition.Y is None
        ):
            LOGGER.warning(
                "Device %s of type %s does not have valid position information.",
                device.DeviceNumber,
                device.DeviceType,
            )
            return None

        geom = f"POINT({deviceInfo.ToNodePosition.X} {deviceInfo.ToNodePosition.Y})"

    cmpType = _query_device("CmpType", device)

    fid = _query_device("FID", device)
    if cmpType is None or cmpType == "":
        cmpType = "Source Supply Point"

    if fid is None or fid == "":
        fid = deviceInfo.SectionID

    return (
        fid,
        cmpType,
        geom,
        rotation,
        sizeFactor,
    )


def _get_upstream_device_identity(section_id: str) -> tuple[str, str] | None:
    current_section = cympy.study.GetSection(section_id)
    upstream_iterator = cympy.study.NetworkIterator(
        current_section.FromNode.ID,
        cympy.enums.IterationOption.Upstream,
    )
    if not upstream_iterator.Next():
        return None

    upstream_devices = upstream_iterator.GetDevices()
    if not upstream_devices:
        return None

    previous_device = upstream_devices[0]
    previous_device_fid = _query_device("EqNo", previous_device)
    previous_unique_id = _format_unique_id(
        previous_device.GetObjType(),
        previous_device_fid,
    )
    return previous_device_fid, previous_unique_id


def _format_unique_id(object_type: str, object_id: str) -> str:
    return f"{object_type} : {object_id}"


def _map_phase(phase_code: str | None, default: float = 7.0) -> float:
    PHASE_MAPPING = {
        "A": 4.0,
        "B": 2.0,
        "C": 1.0,
        "AB": 6.0,
        "BC": 3.0,
        "CA": 5.0,
        "ABC": 7.0,
    }

    return PHASE_MAPPING.get(phase_code or "", default)


def _to_kv(value: str | None) -> float | str:
    if value in (None, ""):
        return ""

    return _to_float(value) * math.sqrt(3.0)


def _divide_or_return_zero(numerator: str | None, denominator: float) -> float:
    floatNumerator = _to_float(numerator)

    return floatNumerator / denominator


def _to_float(value: str | None) -> float:
    if value in (None, ""):
        return 0.0

    return float(value)


def _write_to_csv(output_path: Path, line: Sequence[str]) -> None:
    with open(output_path, "a", encoding="utf-8") as f:
        f.write(";".join(map(str, line)) + "\n")


def _delete_file_if_exists(file_path: Path) -> None:
    try:
        os.remove(file_path)
    except FileNotFoundError:
        pass


def _query_node(field_name: str, node_id: str, default: str = "") -> str:
    try:
        result = cympy.study.QueryInfoNode(field_name, node_id)
        if result is None:
            return default

        return result
    except Exception as e:
        LOGGER.info(
            "Error querying '%s' for node: %s: %s", field_name, node_id, e
        )
        return default


def _query_device(
    field_name: str, device: cympy.study.Device, default: str = ""
) -> str:

    try:
        result = cympy.study.QueryInfoDevice(
            field_name, device.DeviceNumber, device.DeviceType
        )
        if result is None:
            return default

        return result
    except Exception as e:
        LOGGER.info(
            "Error device: %s, type: %s: %s",
            device.DeviceNumber,
            device.DeviceType,
            e,
        )
        return default


def _normalize_and_lower_string(value: str | None) -> str:
    if value is None:
        return ""
    return value.strip().lower()


def _load_headers() -> None:

    HEADERS[DEW_BUSBAR_FILE] = (
        "fid",
        "Length",
        "OperatingKV",
        "CmpType",
        "CmpName",
        "Phasing",
        "mainline",
    )

    HEADERS[DEW_PRIMARY_FILE] = (
        "fid",
        "Construction",
        "Length",
        "OperatingKV",
        "PhaseSize",
        "PhaseMaterial",
        "CmpType",
        "CmpName",
        "PhaseCond",
        "Phasing",
    )

    HEADERS[DEW_CAPACITOR_FILE] = (
        "fid",
        "ControlType",
        "OperatingKV",
        "KVARsPerStepC",
        "KVARsPerStepB",
        "KVARsPerStepA",
        "SwitchStatus",
        "CmpName",
        "Phasing",
        "CooldownPeriod",
        "maxoperations",
        "controlphase",
        "mainline",
        "connectionType",
    )

    HEADERS[DEW_REGULATOR_FILE] = (
        "fid",
        "BaseVoltage",
        "PartName",
        "OperatingKV",
        "SecVolt",
        "PerPhKva (A)",
        "PerPhKva (C)",
        "PerPhKva (B)",
        "CtrlBandWidth",
        "CmpType",
        "SwitchStatus",
        "CmpName",
        "Phasing",
        "PriVolt",
        "priconnection",
        "secconnection",
        "bidirectional",
        "bandwidth",
        "controlPhase",
        "desiredVoltage",
        "initialtap1",
        "initialtap2",
        "initialtap3",
        "tapside",
        "name",
        "transformer_type",
    )

    HEADERS[DEW_REGULATOR_TYPE_FILE] = (
        "fid",
        "BaseVoltage",
        "PerPhKva (A)",
        "PerPhKva (C)",
        "PerPhKva (B)",
        "CtrlBandWidth",
        "SwitchStatus",
        "bidirectional",
        "initialtap1",
        "initialtap2",
        "initialtap3",
        "blockedstep",
        "tapSteps",
        "kva",
        "summerKVA",
        "summerEmergKva",
        "winterKVA",
        "winterEmergKva",
        "percentresistance",
        "percentreactance",
        "name",
        "transformertype",
        "phases",
        "mintap",
        "maxtap",
    )

    HEADERS[DEW_SWITCHES_FILE] = (
        "fid",
        "PartName",
        "OperatingKV",
        "CmpType",
        "SwitchStatus",
        "ratedAmps",
        "CmpName",
        "Phasing",
        "mainline",
    )

    HEADERS[DEW_TRANS_FILE] = (
        "fid",
        "S1Connection",
        "PartName",
        "OperatingKV",
        "SecVolt",
        "CmpType",
        "CmpName",
        "Phasing",
        "PriVolt",
        "mainline",
        "S2Connection",
        "priconnection",
        "secconnection",
        "desiredVoltage",
        "bandwidth",
        "controlPhase",
        "initialTap",
        "transformertype",
        "tapside",
        "name",
    )

    HEADERS[DEW_TRANS_TYPE_FILE] = (
        "fid",
        "mainline",
        "automode",
        "gangctrld",
        "transformertype",
        "tapSteps",
        "kva",
        "summerKVA",
        "summerEmergKva",
        "winterKVA",
        "winterEmergKva",
        "percentresistance",
        "percentreactance",
        "name",
        "phases",
        "mintap",
        "maxtap",
    )

    HEADERS[DEW_SOURCE_FILE] = (
        "fid",
        "positiveSequenceResistance",
        "OperatingKV",
        "zeroSequenceReactance",
        "positiveSequenceReactance",
        "CmpName",
        "zeroSequenceResistance",
        "nominalState",
    )

    HEADERS[DEW_CONNECTION_FILE] = ("fida", "fidb")

    HEADERS[DEW_FEEDERS_FILE] = ("fid", "CmpName", "mainline")

    HEADERS[DEW_GEOM_FILE] = (
        "fid",
        "CmpType",
        "geom",
        "rotation",
        "sizeFactor",
    )


main()
```