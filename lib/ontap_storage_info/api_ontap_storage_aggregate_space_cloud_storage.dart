//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregateSpaceCloudStorage {
  ApiOntapStorageAggregateSpaceCloudStorage._private({this.used});
  final int used;
  //
  factory ApiOntapStorageAggregateSpaceCloudStorage.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateSpaceCloudStorage._private(
              used: json["used"],
            )
          : null;
  Map<String, dynamic> get toMap => {
        "used": used,
      };
}
