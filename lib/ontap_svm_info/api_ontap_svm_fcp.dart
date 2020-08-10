//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmFcp {
  ApiOntapSvmFcp._private({this.enabled});

  final bool enabled;

  factory ApiOntapSvmFcp.fromMap(Map<String, dynamic> json) =>
      json != null ? ApiOntapSvmFcp._private(enabled: json["enabled"]) : null;

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
      };
}
