//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregateSpaceBlockStorage {
  ApiOntapStorageAggregateSpaceBlockStorage._private({
    this.size,
    this.available,
    this.used,
    this.fullThresholdPercent,
  });

  final int size;
  final int available;
  final int used;
  final int fullThresholdPercent;

  factory ApiOntapStorageAggregateSpaceBlockStorage.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateSpaceBlockStorage._private(
              size: json["size"],
              available: json["available"],
              used: json["used"],
              fullThresholdPercent: json["full_threshold_percent"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "size": size,
        "available": available,
        "used": used,
        "full_threshold_percent": fullThresholdPercent,
      };
}
