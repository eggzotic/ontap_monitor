//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmS3 {
  final bool enabled;
  final String name;
  //
  ApiOntapSvmS3._private({
    this.enabled,
    this.name,
  });
  //
  factory ApiOntapSvmS3.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapSvmS3._private(
      enabled: json['enabled'],
      name: json['name'],
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'enabled': enabled,
        'name': name,
      };
}
