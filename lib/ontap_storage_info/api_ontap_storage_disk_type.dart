//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageDiskType {
  ata,
  bsas,
  fcal,
  fsas,
  lun,
  sas,
  msata,
  ssd,
  vmdisk,
  unknown,
  ssd_nvm,
}

extension ApiOntapStorageDiskTypeMembers on ApiOntapStorageDiskType {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageDiskType fromName(String name) {
    if (name == null) return null;
    return ApiOntapStorageDiskType.values.firstWhere(
      (t) => t.name == name,
      orElse: () => ApiOntapStorageDiskType.unknown,
    );
  }

  //
  static ApiOntapStorageDiskType fromIndex(int index) {
    if (index == null) return null;
    return ApiOntapStorageDiskType.values.firstWhere(
      (v) => v.index == index,
      orElse: () => ApiOntapStorageDiskType.unknown,
    );
  }
}
