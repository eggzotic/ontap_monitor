//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmDns {
  ApiOntapSvmDns._private({
    this.domains,
    this.servers,
  });

  final List<String> domains;
  final List<String> servers;

  factory ApiOntapSvmDns.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapSvmDns._private(
          domains: json["domains"]?.map((x) => x.toString())?.toList(),
          servers: json["servers"]?.map((x) => x.toString())?.toList(),
        )
      : null;

  Map<String, dynamic> get toMap => {
        "domains": domains,
        "servers": servers,
      };
}
