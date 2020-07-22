class ApiOntapStorageAggregateSpaceBlockStorage {
  ApiOntapStorageAggregateSpaceBlockStorage({
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
      ApiOntapStorageAggregateSpaceBlockStorage(
        size: json["size"],
        available: json["available"],
        used: json["used"],
        fullThresholdPercent: json["full_threshold_percent"],
      );

  Map<String, dynamic> get toMap => {
        "size": size,
        "available": available,
        "used": used,
        "full_threshold_percent": fullThresholdPercent,
      };
}
