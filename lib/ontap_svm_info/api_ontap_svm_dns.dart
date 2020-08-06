//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmDns {
  ApiOntapSvmDns({
    this.domains,
    this.servers,
  });

  final List<String> domains;
  final List<String> servers;

  factory ApiOntapSvmDns.fromMap(Map<String, dynamic> json) => ApiOntapSvmDns(
        domains: json["domains"]?.map((x) => x.toString())?.toList(),
        servers: json["servers"]?.map((x) => x.toString())?.toList(),
      );

  Map<String, dynamic> get toMap => {
        "domains": domains,
        "servers": servers,
      };
}
