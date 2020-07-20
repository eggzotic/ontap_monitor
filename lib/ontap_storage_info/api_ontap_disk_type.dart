enum ApiOntapDiskType {
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

extension ApiOntapDiskTypeMembers on ApiOntapDiskType {
  String get name => toString().split('.').last;
  //
  static ApiOntapDiskType fromString(String text) {
    return ApiOntapDiskType.values.firstWhere(
      (t) => t.name == text,
      orElse: () => ApiOntapDiskType.unknown,
    );
  }

  //
  static ApiOntapDiskType fromIndex(int index) {
    return ApiOntapDiskType.values.firstWhere(
      (v) => v.index == index,
      orElse: () => ApiOntapDiskType.unknown,
    );
  }
}
