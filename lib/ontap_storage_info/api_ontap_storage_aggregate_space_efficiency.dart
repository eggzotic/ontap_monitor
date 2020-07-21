class ApiOntapStorageAggregateSpaceEfficiency {
  final int logicalUsed;
  final num ratio;
  final int savings;
  //
  ApiOntapStorageAggregateSpaceEfficiency({
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
    return ApiOntapStorageAggregateSpaceEfficiency(
      logicalUsed: json['logical_used'],
      ratio: json['ratio'],
      savings: json['savings'],
    );
  }
}
