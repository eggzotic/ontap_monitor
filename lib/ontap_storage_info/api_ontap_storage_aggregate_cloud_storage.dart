//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregateCloudStorage {
  ApiOntapStorageAggregateCloudStorage({
    this.attachEligible,
    this.tieringFullnessThreshold,
  });

  final bool attachEligible;
  final int tieringFullnessThreshold;

  factory ApiOntapStorageAggregateCloudStorage.fromMap(
          Map<String, dynamic> json) =>
      ApiOntapStorageAggregateCloudStorage(
        attachEligible: json["attach_eligible"],
      );

  Map<String, dynamic> get toMap => {
        "attach_eligible": attachEligible,
        'tiering_fullness_threshold': tieringFullnessThreshold,
      };
}
