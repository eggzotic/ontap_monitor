enum ApiOntapStorageShelfPortModuleId {
  a,
  b,
}

//
extension ApiOntapStorageShelfPortModuleIdMembers
    on ApiOntapStorageShelfPortModuleId {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfPortModuleId fromString(String text) =>
      ApiOntapStorageShelfPortModuleId.values.firstWhere(
        (v) => v.name == text,
        orElse: () => null,
      );
  //
  static ApiOntapStorageShelfPortModuleId fromIndex(int index) =>
      ApiOntapStorageShelfPortModuleId.values.firstWhere(
        (v) => v.index == index,
        orElse: () => null,
      );
}
