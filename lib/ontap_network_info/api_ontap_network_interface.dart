//
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ip.dart';

class ApiOntapNetworkInterface {
  ApiOntapNetworkInterface({
    this.uuid,
    this.name,
    this.ip,
  });

  final String uuid;
  final String name;
  final ApiOntapNetworkIp ip;

  factory ApiOntapNetworkInterface.fromMap(Map<String, dynamic> json) =>
      ApiOntapNetworkInterface(
        uuid: json["uuid"],
        name: json["name"],
        ip: json["ip"] == null ? null : ApiOntapNetworkIp.fromMap(json["ip"]),
      );

  Map<String, dynamic> get toMap => {
        "uuid": uuid,
        "name": name,
        "ip": ip?.toMap,
      };
}
