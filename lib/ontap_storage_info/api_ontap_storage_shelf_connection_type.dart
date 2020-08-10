//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfConnectionType {
  unknown,
  fc,
  sas,
  nvme,
}

extension ApiOntapStorageShelfConnectionTypeMembers
    on ApiOntapStorageShelfConnectionType {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfConnectionType fromName(String name) =>
      name != null
          ? ApiOntapStorageShelfConnectionType.values.firstWhere(
              (v) => v.name == name,
              orElse: () => ApiOntapStorageShelfConnectionType.unknown,
            )
          : null;
  //
  static ApiOntapStorageShelfConnectionType fromIndex(int index) =>
      index != null
          ? ApiOntapStorageShelfConnectionType.values.firstWhere(
              (v) => v.index == index,
              orElse: () => ApiOntapStorageShelfConnectionType.unknown,
            )
          : null;
}
