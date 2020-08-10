//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
//
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_controller.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_interface.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node_state.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_version.dart';

class ApiOntapNode extends StorableItem {
  ApiOntapNode._private({
    this.uuid,
    this.name,
    this.serialNumber,
    this.location,
    this.model,
    this.version,
    this.date,
    this.uptime,
    this.state,
    this.membership,
    this.managementInterfaces,
    this.clusterInterfaces,
    this.controller,
    this.ownerId,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);

  @override
  String ownerId;
  @override
  String get id => (ownerId ?? '') + '_' + uuid;
  final String uuid;
  final String name;
  final String serialNumber;
  final String location;
  final String model;
  final ApiOntapVersion version;
  final DateTime date;
  final int uptime;
  final ApiOntapNodeState state;
  final String membership;
  final List<ApiOntapNetworkInterface> managementInterfaces;
  final List<ApiOntapNetworkInterface> clusterInterfaces;
  final ApiOntapController controller;

  factory ApiOntapNode.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    if (json == null) return null;
    return ApiOntapNode._private(
      uuid: json["uuid"],
      name: json["name"],
      serialNumber: json["serial_number"],
      location: json["location"],
      model: json["model"],
      version: ApiOntapVersion.fromMap(json["version"]),
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      uptime: json["uptime"],
      state: ApiOntapNodeStateMembers.fromName(json['state']),
      membership: json["membership"],
      managementInterfaces: json["management_interfaces"]
          ?.map((x) => ApiOntapNetworkInterface.fromMap(x))
          ?.toList(),
      clusterInterfaces: json["cluster_interfaces"]
          ?.map((x) => ApiOntapNetworkInterface.fromMap(x))
          ?.toList(),
      controller: ApiOntapController.fromMap(json["controller"]),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
      ownerId: json['ownerId'] ?? ownerId,
    );
  }

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "serial_number": serialNumber,
        "location": location,
        "model": model,
        "version": version?.toMap,
        "date": date?.toIso8601String(),
        "uptime": uptime,
        "state": state?.name,
        "membership": membership,
        "management_interfaces":
            managementInterfaces?.map((x) => x?.toMap)?.toList(),
        "cluster_interfaces": clusterInterfaces?.map((x) => x?.toMap)?.toList(),
        "controller": controller?.toMap,
        'lastUpdated': lastUpdated?.toIso8601String(),
        'ownerId': ownerId,
      };
}
