//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmNis {
  ApiOntapSvmNis._private({
    this.domain,
    this.enabled,
    this.servers,
  });

  final String domain;
  final bool enabled;
  final List<String> servers;

  factory ApiOntapSvmNis.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapSvmNis._private(
          domain: json["domain"],
          enabled: json["enabled"],
          servers: json["servers"]?.map<String>((x) => x?.toString())?.toList(),
        )
      : null;

  Map<String, dynamic> get toMap => {
        "domain": domain,
        "enabled": enabled,
        "servers": servers?.map<String>((x) => x)?.toList(),
      };
}
