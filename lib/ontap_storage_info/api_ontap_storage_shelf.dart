//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_bay.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_connection_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_drawer.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_fru.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_module_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_path.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_port.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_state.dart';

class ApiOntapStorageShelf extends StorableItem {
  ApiOntapStorageShelf._private({
    this.bays,
    this.connectionType,
    this.diskCount,
    this.drawers,
    this.frus,
    this.id,
    this.internal,
    this.model,
    this.moduleType,
    this.name,
    this.paths,
    this.ports,
    this.serialNumber,
    this.state,
    this.uid,
  });

  final List<ApiOntapStorageShelfBay> bays;
  final ApiOntapStorageShelfConnectionType connectionType;
  final int diskCount;
  final List<ApiOntapStorageShelfDrawer> drawers;
  final List<ApiOntapStorageShelfFru> frus;
  final String id;
  final bool internal;
  final String model;
  final ApiOntapStorageShelfModuleType moduleType;
  final String name;
  final List<ApiOntapStorageShelfPath> paths;
  final List<ApiOntapStorageShelfPort> ports;
  final String serialNumber;
  final ApiOntapStorageShelfState state;
  final String uid;

  factory ApiOntapStorageShelf.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelf._private(
              bays: json["bays"]
                  ?.map((x) => ApiOntapStorageShelfBay.fromMap(x))
                  ?.toList(),
              connectionType:
                  ApiOntapStorageShelfConnectionTypeMembers.fromName(
                      json["connection_type"]),
              diskCount: json["disk_count"],
              drawers: json["drawers"]
                  ?.map((x) => ApiOntapStorageShelfDrawer.fromMap(x))
                  ?.toList(),
              frus: json["frus"]
                  ?.map((x) => ApiOntapStorageShelfFru.fromMap(x))
                  ?.toList(),
              id: json["id"],
              internal: json["internal"] ?? false,
              model: json["model"],
              moduleType: ApiOntapStorageShelfModuleTypeMembers.fromName(
                  json["module_type"]),
              name: json["name"],
              paths: json["paths"]
                  ?.map((x) => ApiOntapStorageShelfPath.fromMap(x))
                  ?.toList(),
              ports: json["ports"]
                  ?.map((x) => ApiOntapStorageShelfPort.fromMap(x))
                  ?.toList(),
              serialNumber: json["serial_number"],
              state: ApiOntapStorageShelfStateMembers.fromName(json["state"]),
              uid: json["uid"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "bays": bays?.map((x) => x?.toMap)?.toList(),
        "connection_type": connectionType?.name,
        "disk_count": diskCount,
        "drawers": drawers?.map((x) => x?.toMap)?.toList(),
        "frus": frus?.map((x) => x?.toMap)?.toList(),
        "id": id,
        "internal": internal,
        "model": model,
        "module_type": moduleType?.name,
        "name": name,
        "paths": paths?.map((x) => x?.toMap)?.toList(),
        "ports": ports?.map((x) => x?.toMap)?.toList(),
        "serial_number": serialNumber,
        "state": state?.name,
        "uid": uid,
      };
}
