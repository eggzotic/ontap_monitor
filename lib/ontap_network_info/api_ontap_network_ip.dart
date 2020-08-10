//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapNetworkIp {
  ApiOntapNetworkIp._private({
    this.address,
    this.netmask,
  });
  //
  final String address;
  final String netmask;
  //
  factory ApiOntapNetworkIp.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapNetworkIp._private(
          address: json["address"],
          netmask: json['netmask']?.toString(),
        )
      : null;
  Map<String, dynamic> get toMap => {
        "address": address,
        'netmask': netmask,
      };
}
