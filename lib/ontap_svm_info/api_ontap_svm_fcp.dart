//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmFcp {
  ApiOntapSvmFcp({
    this.enabled,
  });

  final bool enabled;

  factory ApiOntapSvmFcp.fromMap(Map<String, dynamic> json) => ApiOntapSvmFcp(
        enabled: json["enabled"],
      );

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
      };
}
