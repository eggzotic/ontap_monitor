enum ApiOntapStorageShelfConnectionType {
  unknown,
  fc,
  sas,
  nvme,
}

extension ApiOntapStorageShelfConnectionTypeMembers
    on ApiOntapStorageShelfConnectionType {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfConnectionType fromName(String text) =>
      ApiOntapStorageShelfConnectionType.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfConnectionType.unknown,
      );
  //
  static ApiOntapStorageShelfConnectionType fromIndex(int index) =>
      ApiOntapStorageShelfConnectionType.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfConnectionType.unknown,
      );
}
