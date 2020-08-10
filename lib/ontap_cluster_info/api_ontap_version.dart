//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
//
class ApiOntapVersion {
  final String full;
  final int generation;
  final int major;
  final int minor;
  //
  ApiOntapVersion._private({
    this.full,
    this.generation,
    this.major,
    this.minor = 0,
  });
  //
  factory ApiOntapVersion.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapVersion._private(
      full: json['full'],
      generation: json['generation'],
      major: json['major'],
      minor: json['minor'],
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'full': full,
        'generation': generation,
        'major': major,
        'minor': minor,
      };
}
