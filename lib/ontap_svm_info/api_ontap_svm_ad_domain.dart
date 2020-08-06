//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmAdDomain {
  ApiOntapSvmAdDomain({
    this.fqdn,
    this.organizationalUnit,
  });

  final String fqdn;
  final String organizationalUnit;

  factory ApiOntapSvmAdDomain.fromMap(Map<String, dynamic> json) =>
      ApiOntapSvmAdDomain(
        fqdn: json["fqdn"],
        organizationalUnit: json["organizational_unit"],
      );

  Map<String, dynamic> get toMap => {
        "fqdn": fqdn,
        "organizational_unit": organizationalUnit,
      };
}
