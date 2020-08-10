//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmAdDomain {
  ApiOntapSvmAdDomain._private({
    this.fqdn,
    this.organizationalUnit,
  });

  final String fqdn;
  final String organizationalUnit;

  factory ApiOntapSvmAdDomain.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapSvmAdDomain._private(
          fqdn: json["fqdn"],
          organizationalUnit: json["organizational_unit"],
        )
      : null;

  Map<String, dynamic> get toMap => {
        "fqdn": fqdn,
        "organizational_unit": organizationalUnit,
      };
}
