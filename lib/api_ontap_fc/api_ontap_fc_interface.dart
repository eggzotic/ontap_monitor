//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/api_ontap_fc/api_ontap_fc_interface_location.dart';
import 'package:ontap_monitor/api_ontap_fc/api_ontap_fc_protocol.dart';

class ApiOntapFcInterface {
  final ApiOntapFcProtocol dataProtocol;
  final ApiOntapFcInterfaceLocation location;
  final String name;
  final String uuid;
  //
  // ***RLS*** main concrete constructor is ._private
  ApiOntapFcInterface._private({
    this.dataProtocol,
    this.location,
    this.name,
    this.uuid,
  });
  //
  // ***RLS*** fromMap (i.e. from JSON) constructor is factory,
  //           and always begins with null-check/early-exit
  factory ApiOntapFcInterface.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapFcInterface._private(
      dataProtocol: json['data_protocol'],
      location: json['location'],
      name: json['name'],
      uuid: json['uuid'],
    );
  }
  //
  // ***RLS*** toMap (i.e. to JSON) is a getter (not function)
  //           all non-primitive types are handled with null-safety
  Map<String, dynamic> get toMap => {
        'data_protocol': dataProtocol?.name,
        'location': location?.toMap,
        'name': name,
        'uuid': uuid,
      };
}
