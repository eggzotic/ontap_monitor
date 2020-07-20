enum ApiOntapStorageShelfFruType {
  module,
  psu,
}

//
extension ApiOntapStorageShelfFruTypeMembers on ApiOntapStorageShelfFruType {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfFruType fromString(String text) =>
      ApiOntapStorageShelfFruType.values.firstWhere(
        (v) => v.name == text,
        orElse: () => null,
      );
  //
  static ApiOntapStorageShelfFruType fromIndex(int index) =>
      ApiOntapStorageShelfFruType.values.firstWhere(
        (v) => v.index == index,
        orElse: () => null,
      );
}
