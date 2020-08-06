//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cable.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_port_error.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_port_state.dart';

class ApiOntapStoragePort extends StorableItem {
  ApiOntapStoragePort({
    this.ownerId,
    this.boardName,
    this.cable,
    this.description,
    this.error,
    this.macAddress,
    this.name,
    this.node,
    this.partNumber,
    this.serialNumber,
    this.speed,
    this.state,
    this.wwn,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);

  @override
  final String ownerId;
  final String boardName;
  final ApiOntapStorageCable cable;
  final String description;
  final ApiOntapStoragePortError error;
  final String macAddress;
  @override
  final String name;
  final ApiOntapNode node;
  final String partNumber;
  final String serialNumber;
  final num speed;
  final ApiOntapStoragePortState state;
  final String wwn;
  @override
  String get id => ownerId + '_' + name;

  factory ApiOntapStoragePort.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) =>
      ApiOntapStoragePort(
        ownerId: json['ownerId'] ?? ownerId,
        boardName: json["board_name"],
        cable: json["cable"] == null
            ? null
            : ApiOntapStorageCable.fromMap(json["cable"]),
        description: json["description"],
        error: json["error"] == null
            ? null
            : ApiOntapStoragePortError.fromMap(json["error"]),
        macAddress: json["mac_address"],
        name: json["name"],
        node: json["node"] == null ? null : ApiOntapNode.fromMap(json["node"]),
        partNumber: json["part_number"],
        serialNumber: json["serial_number"],
        speed: json["speed"],
        state: json["state"] == null
            ? null
            : ApiOntapStoragePortStateMembers.fromName(json["state"]),
        wwn: json["wwn"],
      );

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "board_name": boardName,
        "cable": cable == null ? null : cable?.toMap,
        "description": description,
        "error": error == null ? null : error?.toMap,
        "mac_address": macAddress,
        "name": name,
        "node": node == null ? null : node?.toMap,
        "part_number": partNumber,
        "serial_number": serialNumber,
        "speed": speed,
        "state": state?.name,
        "wwn": wwn,
      };
}
