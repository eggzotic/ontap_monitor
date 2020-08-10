//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmNvme {
  ApiOntapSvmNvme._private({
    this.enabled,
  });

  final bool enabled;

  factory ApiOntapSvmNvme.fromMap(Map<String, dynamic> json) =>
      json != null ? ApiOntapSvmNvme._private(enabled: json["enabled"]) : null;

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
      };
}
