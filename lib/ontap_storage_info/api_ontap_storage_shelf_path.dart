//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';

class ApiOntapStorageShelfPath {
  ApiOntapStorageShelfPath({
    this.name,
    this.node,
  });

  final String name;
  final ApiOntapNode node;

  factory ApiOntapStorageShelfPath.fromMap(Map<String, dynamic> json) =>
      ApiOntapStorageShelfPath(
        name: json["name"],
        node: json["node"] == null ? null : ApiOntapNode.fromMap(json["node"]),
      );

  Map<String, dynamic> get toMap => {
        "name": name,
        "node": node?.toMap,
      };
}
