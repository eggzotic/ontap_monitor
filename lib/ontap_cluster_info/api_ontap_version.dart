//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
//
import 'package:flutter/foundation.dart';

class ApiOntapVersion {
  final String full;
  final int generation;
  final int major;
  final int minor;
  //
  ApiOntapVersion._private(
    this.full,
    this.generation,
    this.major,
    this.minor,
  );
  factory ApiOntapVersion({
    @required String full,
    @required int generation,
    @required int major,
    int minor = 0,
  }) {
    return ApiOntapVersion._private(full, generation, major, minor);
  }
  //
  factory ApiOntapVersion.fromMap(Map<String, dynamic> json) {
    final String full = json['full'];
    final int generation = json['generation'];
    final int major = json['major'];
    final int minor = json['minor'];
    return ApiOntapVersion(
      full: full,
      generation: generation,
      major: major,
      minor: minor,
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
