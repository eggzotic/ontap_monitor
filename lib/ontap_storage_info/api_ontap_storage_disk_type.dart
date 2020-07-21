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
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageDiskType fromString(String text) {
    return ApiOntapStorageDiskType.values.firstWhere(
      (t) => t.name == text,
      orElse: () => ApiOntapStorageDiskType.unknown,
    );
  }

  //
  static ApiOntapStorageDiskType fromIndex(int index) {
    return ApiOntapStorageDiskType.values.firstWhere(
      (v) => v.index == index,
      orElse: () => ApiOntapStorageDiskType.unknown,
    );
  }
}
