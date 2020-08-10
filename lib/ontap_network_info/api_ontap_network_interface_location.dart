//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_broadcast_domain.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';

class ApiOntapNetworkInterfaceLocation {
  final ApiOntapNetworkBroadcastDomain broadcastDomain;
  final ApiOntapNode homeNode;
  //
  ApiOntapNetworkInterfaceLocation._private({
    this.broadcastDomain,
    this.homeNode,
  });
  //
  factory ApiOntapNetworkInterfaceLocation.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapNetworkInterfaceLocation._private(
      broadcastDomain:
          ApiOntapNetworkBroadcastDomain.fromMap(json['broadcast_domain']),
      homeNode: ApiOntapNode.fromMap(json['home_node']),
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'broadcast_domain': broadcastDomain?.toMap,
        'home_node': homeNode?.toMap,
      };
}
