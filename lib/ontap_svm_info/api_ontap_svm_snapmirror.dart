//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmSnapmirror {
  ApiOntapSvmSnapmirror({
    this.isProtected,
    this.protectedVolumesCount,
  });

  final bool isProtected;
  final int protectedVolumesCount;

  factory ApiOntapSvmSnapmirror.fromMap(Map<String, dynamic> json) => ApiOntapSvmSnapmirror(
        isProtected: json["is_protected"],
        protectedVolumesCount: json["protected_volumes_count"],
      );

  Map<String, dynamic> get toMap => {
        "is_protected": isProtected,
        "protected_volumes_count": protectedVolumesCount,
      };
}