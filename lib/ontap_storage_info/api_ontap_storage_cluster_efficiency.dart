class ApiOntapStorageClusterEfficiency {
  ApiOntapStorageClusterEfficiency({
    this.savings,
    this.ratio,
    this.logicalUsed,
  });

  final int savings;
  final num ratio;
  final int logicalUsed;

  factory ApiOntapStorageClusterEfficiency.fromMap(Map<String, dynamic> json) => ApiOntapStorageClusterEfficiency(
        savings: json["savings"],
        ratio: json["ratio"],
        logicalUsed: json["logical_used"],
      );

  Map<String, dynamic> get toMap => {
        "savings": savings,
        "ratio": ratio,
        "logical_used": logicalUsed,
      };
}
