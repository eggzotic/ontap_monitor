//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapNetworkIpspace {
  ApiOntapNetworkIpspace({this.name});
  final String name;
  factory ApiOntapNetworkIpspace.fromMap(Map<String, dynamic> json) =>
      ApiOntapNetworkIpspace(
        name: json["name"],
      );
  Map<String, dynamic> get toMap => {
        "name": name,
      };
}
