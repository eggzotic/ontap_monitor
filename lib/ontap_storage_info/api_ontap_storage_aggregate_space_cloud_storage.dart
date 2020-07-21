class ApiOntapStorageAggregateSpaceCloudStorage {
  ApiOntapStorageAggregateSpaceCloudStorage({this.used});
  final int used;
  factory ApiOntapStorageAggregateSpaceCloudStorage.fromMap(
          Map<String, dynamic> json) =>
      ApiOntapStorageAggregateSpaceCloudStorage(
        used: json["used"],
      );
  Map<String, dynamic> get toMap => {
        "used": used,
      };
}
