enum ApiOntapStorageShelfModuleType {
  unknown,
  iom6,
  iom6e,
  iom12,
  iom12e,
  iom12f,
  nsm100,
  psm3e,
}

//
extension ApiOntapStorageShelfModuleTypeMembers
    on ApiOntapStorageShelfModuleType {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfModuleType fromString(String text) =>
      ApiOntapStorageShelfModuleType.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfModuleType.unknown,
      );
  //
  static ApiOntapStorageShelfModuleType fromIndex(int index) =>
      ApiOntapStorageShelfModuleType.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfModuleType.unknown,
      );
}
