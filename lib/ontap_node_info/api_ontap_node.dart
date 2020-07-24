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
  ApiOntapNode({
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
    return ApiOntapNode(
      uuid: json["uuid"],
      name: json["name"],
      serialNumber: json["serial_number"],
      location: json["location"],
      model: json["model"],
      version: json["version"] == null
          ? null
          : ApiOntapVersion.fromMap(json["version"]),
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      uptime: json["uptime"],
      state: json["state"] == null
          ? null
          : ApiOntapNodeStateMembers.fromName(json['state']),
      membership: json["membership"],
      managementInterfaces: json["management_interfaces"] == null
          ? null
          : List<ApiOntapNetworkInterface>.from(json["management_interfaces"]
              .map((x) => ApiOntapNetworkInterface.fromMap(x))),
      clusterInterfaces: json["cluster_interfaces"] == null
          ? null
          : List<ApiOntapNetworkInterface>.from(json["cluster_interfaces"]
              .map((x) => ApiOntapNetworkInterface.fromMap(x))),
      controller: json["controller"] == null
          ? null
          : ApiOntapController.fromMap(json["controller"]),
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
        "management_interfaces": managementInterfaces == null
            ? null
            : List<dynamic>.from(managementInterfaces.map((x) => x.toMap)),
        "cluster_interfaces": clusterInterfaces == null
            ? null
            : List<dynamic>.from(clusterInterfaces.map((x) => x.toMap)),
        "controller": controller?.toMap,
        'lastUpdated': lastUpdated.toIso8601String(),
        'ownerId': ownerId,
      };
}
