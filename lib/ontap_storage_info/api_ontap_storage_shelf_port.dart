//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_cable.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_port_designator.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_port_module_id.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_port_remote.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_port_state.dart';

class ApiOntapStorageShelfPort {
  ApiOntapStorageShelfPort._private({
    this.cable,
    this.designator,
    this.id,
    this.internal,
    this.macAddress,
    this.moduleId,
    this.remote,
    this.state,
    this.wwn,
  });

  final ApiOntapStorageShelfCable cable;
  final ApiOntapStorageShelfPortDesignator designator;
  final int id;
  final bool internal;
  final String macAddress;
  final ApiOntapStorageShelfPortModuleId moduleId;
  final ApiOntapStorageShelfPortRemote remote;
  final ApiOntapStorageShelfPortState state;
  final String wwn;

  factory ApiOntapStorageShelfPort.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelfPort._private(
              cable: ApiOntapStorageShelfCable.fromMap(json["cable"]),
              designator: ApiOntapStorageShelfPortDesignatorMembers.fromName(
                  json["designator"]),
              id: json["id"],
              internal: json["internal"],
              macAddress: json["mac_address"],
              moduleId: ApiOntapStorageShelfPortModuleIdMembers.fromName(
                json["module_id"],
              ),
              remote: ApiOntapStorageShelfPortRemote.fromMap(json["remote"]),
              state:
                  ApiOntapStorageShelfPortStateMembers.fromName(json["state"]),
              wwn: json["wwn"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "cable": cable?.toMap,
        "designator": designator?.name,
        "id": id,
        "internal": internal,
        "mac_address": macAddress,
        "module_id": moduleId?.name,
        "remote": remote?.toMap,
        "state": state?.name,
        "wwn": wwn,
      };
}
