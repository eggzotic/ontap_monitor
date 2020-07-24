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
  ApiOntapStorageShelfPort({
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
      ApiOntapStorageShelfPort(
        cable: json["cable"] == null
            ? null
            : ApiOntapStorageShelfCable.fromMap(json["cable"]),
        designator: json["designator"] == null
            ? null
            : ApiOntapStorageShelfPortDesignatorMembers.fromName(
                json["designator"]),
        id: json["id"],
        internal: json["internal"],
        macAddress: json["mac_address"],
        moduleId: json["module_id"] == null
            ? null
            : ApiOntapStorageShelfPortModuleIdMembers.fromName(
                json["module_id"],
              ),
        remote: json["remote"] == null
            ? null
            : ApiOntapStorageShelfPortRemote.fromMap(json["remote"]),
        state: json["state"] == null
            ? null
            : ApiOntapStorageShelfPortStateMembers.fromName(json["state"]),
        wwn: json["wwn"],
      );

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
