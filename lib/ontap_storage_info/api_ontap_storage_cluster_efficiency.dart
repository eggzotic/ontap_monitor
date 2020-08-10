//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapStorageClusterEfficiency {
  ApiOntapStorageClusterEfficiency._private({
    this.savings,
    this.ratio,
    this.logicalUsed,
  });

  final int savings;
  final num ratio;
  final int logicalUsed;

  factory ApiOntapStorageClusterEfficiency.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageClusterEfficiency._private(
              savings: json["savings"],
              ratio: json["ratio"],
              logicalUsed: json["logical_used"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "savings": savings,
        "ratio": ratio,
        "logical_used": logicalUsed,
      };
}
