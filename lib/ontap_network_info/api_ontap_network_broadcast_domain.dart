import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ipspace.dart';

class ApiOntapNetworkBroadcastDomain {
  ApiOntapNetworkBroadcastDomain({
    this.uuid,
    this.name,
    this.ipspace,
  });

  final String uuid;
  final String name;
  final ApiOntapNetworkIpspace ipspace;

  factory ApiOntapNetworkBroadcastDomain.fromMap(Map<String, dynamic> json) =>
      ApiOntapNetworkBroadcastDomain(
        uuid: json["uuid"],
        name: json["name"],
        ipspace: json["ipspace"] == null
            ? null
            : ApiOntapNetworkIpspace.fromMap(json["ipspace"]),
      );

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "ipspace": ipspace?.toMap,
      };
}
