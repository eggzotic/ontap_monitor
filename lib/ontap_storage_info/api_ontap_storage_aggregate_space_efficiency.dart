//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageAggregateSpaceEfficiency {
  final int logicalUsed;
  final num ratio;
  final int savings;
  //
  ApiOntapStorageAggregateSpaceEfficiency._private({
    this.logicalUsed,
    this.ratio,
    this.savings,
  });
  //
  Map<String, dynamic> get toMap => {
        'logical_used': logicalUsed,
        'ratio': ratio,
        'savings': savings,
      };
  //
  factory ApiOntapStorageAggregateSpaceEfficiency.fromMap(
      Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapStorageAggregateSpaceEfficiency._private(
      logicalUsed: json['logical_used'],
      ratio: json['ratio'],
      savings: json['savings'],
    );
  }
}
