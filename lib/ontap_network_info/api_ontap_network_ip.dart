//
class ApiOntapNetworkIp {
  ApiOntapNetworkIp({this.address});
  final String address;
  factory ApiOntapNetworkIp.fromMap(Map<String, dynamic> json) => ApiOntapNetworkIp(
        address: json["address"],
      );
  Map<String, dynamic> get toMap => {
        "address": address,
      };
}