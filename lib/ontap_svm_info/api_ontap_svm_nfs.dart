//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmNfs {
  ApiOntapSvmNfs._private({
    this.enabled,
  });

  final bool enabled;

  factory ApiOntapSvmNfs.fromMap(Map<String, dynamic> json) =>
      json != null ? ApiOntapSvmNfs._private(enabled: json["enabled"]) : null;

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
      };
  String get serviceName => enabled ? 'NFS' : '';
}
