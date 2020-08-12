//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_interface_location.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_interface_service.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_interface_service_policy.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ip.dart';

class ApiOntapNetworkInterface {
  ApiOntapNetworkInterface._private({
    this.uuid,
    this.name,
    this.ip,
    this.location,
    this.services,
    this.servicePolicy,
  });

  final String uuid;
  final String name;
  final ApiOntapNetworkIp ip;
  final ApiOntapNetworkInterfaceLocation location;
  final List<ApiOntapNetworkInterfaceService> services;
  final ApiOntapNetworkInterfaceServicePolicy servicePolicy;

  factory ApiOntapNetworkInterface.fromMap(Map<String, dynamic> json) => json !=
          null
      ? ApiOntapNetworkInterface._private(
          uuid: json["uuid"],
          name: json["name"],
          ip: ApiOntapNetworkIp.fromMap(json["ip"]),
          location: ApiOntapNetworkInterfaceLocation.fromMap(json['location']),
          services: json["services"]
              ?.map<ApiOntapNetworkInterfaceService>(
                  (x) => ApiOntapNetworkInterfaceServiceMembers.fromName(x))
              ?.toList(),
          servicePolicy: ApiOntapNetworkInterfaceServicePolicyMembers.fromName(
              json['service_policy']),
        )
      : null;

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "ip": ip?.toMap,
        'location': location?.toMap,
        "services": services?.map((x) => x?.toString())?.toList(),
        'service_policy': servicePolicy?.name,
      };
}
