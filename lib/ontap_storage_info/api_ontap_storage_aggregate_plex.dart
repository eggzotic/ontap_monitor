//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregatePlex {
  ApiOntapStorageAggregatePlex({this.name});
  final String name;
  factory ApiOntapStorageAggregatePlex.fromMap(Map<String, dynamic> json) =>
      ApiOntapStorageAggregatePlex(
        name: json["name"],
      );
  Map<String, dynamic> get toMap => {
        "name": name,
      };
}
