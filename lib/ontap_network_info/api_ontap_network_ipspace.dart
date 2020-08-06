//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapNetworkIpspace {
  ApiOntapNetworkIpspace({
    this.name,
    this.uuid,
  });

  final String name;
  final String uuid;

  factory ApiOntapNetworkIpspace.fromMap(Map<String, dynamic> json) =>
      ApiOntapNetworkIpspace(
        name: json["name"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> get toMap => {
        "name": name,
        "uuid": uuid,
      };
}
