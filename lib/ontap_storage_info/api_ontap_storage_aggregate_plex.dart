//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregatePlex {
  ApiOntapStorageAggregatePlex._private({this.name});
  final String name;
  //
  factory ApiOntapStorageAggregatePlex.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregatePlex._private(name: json["name"])
          : null;
  Map<String, dynamic> get toMap => {
        "name": name,
      };
}
