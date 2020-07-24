//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_broadcast_domain.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_state.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_type.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';

class ApiOntapNetworkEthernetPort extends StorableItem {
  ApiOntapNetworkEthernetPort({
    this.uuid,
    this.name,
    this.macAddress,
    this.type,
    this.node,
    this.broadcastDomain,
    this.enabled,
    this.state,
    this.mtu,
    this.speed,
    this.ownerId,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);

  @override
  String get id => ownerId + '_' + uuid;
  final String uuid;
  @override
  final String ownerId;
  final String name;
  final String macAddress;
  final ApiOntapNetworkEthernetPortType type;
  final ApiOntapNode node;
  final ApiOntapNetworkBroadcastDomain broadcastDomain;
  final bool enabled;
  final ApiOntapNetworkEthernetPortState state;
  final int mtu;
  final String speed;

  factory ApiOntapNetworkEthernetPort.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    // must have an owner
    assert(ownerId != null || json['ownerId'] != null);
    return ApiOntapNetworkEthernetPort(
      uuid: json["uuid"],
      name: json["name"],
      macAddress: json["mac_address"],
      type: json["type"] == null
          ? null
          : ApiOntapNetworkEthernetPortTypeMembers.fromName(json["type"]),
      node: json["node"] == null
          ? null
          : ApiOntapNode.fromMap(json["node"], ownerId: ownerId),
      broadcastDomain: json["broadcast_domain"] == null
          ? null
          : ApiOntapNetworkBroadcastDomain.fromMap(json["broadcast_domain"]),
      enabled: json["enabled"],
      state: json["state"] == null
          ? null
          : ApioOntapNetworkEthernetPortStateMembers.fromName(json['state']),
      mtu: json["mtu"],
      speed: json["speed"],
      ownerId: json['ownerId'] ?? ownerId,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "mac_address": macAddress,
        "type": type?.name,
        "node": node?.toMap,
        "broadcast_domain": broadcastDomain?.toMap,
        "enabled": enabled,
        "state": state?.name,
        "mtu": mtu,
        "speed": speed,
        'ownerId': ownerId,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
