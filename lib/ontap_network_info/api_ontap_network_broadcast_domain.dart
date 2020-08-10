//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
      json != null
          ? ApiOntapNetworkBroadcastDomain(
              uuid: json["uuid"],
              name: json["name"],
              ipspace: ApiOntapNetworkIpspace.fromMap(json["ipspace"]),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "ipspace": ipspace?.toMap,
      };
}
