//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';

class ApiOntapFcPort {
  final String name;
  final String uuid;
  final ApiOntapNode node;
  //
  ApiOntapFcPort._private({
    this.name,
    this.uuid,
    this.node,
  });
  //
  factory ApiOntapFcPort.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapFcPort._private(
      name: json['name'],
      uuid: json['uuid'],
      node: ApiOntapNode.fromMap(json['node']),
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'name': name,
        'uuid': uuid,
        'node': node?.toMap,
      };
}
