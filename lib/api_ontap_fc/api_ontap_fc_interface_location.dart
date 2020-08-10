//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/api_ontap_fc/api_ontap_fc_port.dart';

class ApiOntapFcInterfaceLocation {
  final ApiOntapFcPort port;
  //
  ApiOntapFcInterfaceLocation._private({this.port});
  //
  factory ApiOntapFcInterfaceLocation.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapFcInterfaceLocation._private(port: json['port']);
  }
  //
  Map<String, dynamic> get toMap => {
        'port': port?.toMap,
      };
}
