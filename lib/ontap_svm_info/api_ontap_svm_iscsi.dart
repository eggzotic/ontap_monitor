//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmIscsi {
  ApiOntapSvmIscsi._private({
    this.enabled,
  });

  final bool enabled;

  factory ApiOntapSvmIscsi.fromMap(Map<String, dynamic> json) =>
      json != null ? ApiOntapSvmIscsi._private(enabled: json["enabled"]) : null;

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
      };
  String get serviceName => enabled ? 'iSCSI' : '';
}
