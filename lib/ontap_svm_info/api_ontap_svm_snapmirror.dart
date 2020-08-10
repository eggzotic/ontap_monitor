//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSvmSnapmirror {
  ApiOntapSvmSnapmirror._private({
    this.isProtected,
    this.protectedVolumesCount,
  });

  final bool isProtected;
  final int protectedVolumesCount;

  factory ApiOntapSvmSnapmirror.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapSvmSnapmirror._private(
              isProtected: json["is_protected"],
              protectedVolumesCount: json["protected_volumes_count"],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "is_protected": isProtected,
        "protected_volumes_count": protectedVolumesCount,
      };
}
