//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfModuleType fromName(String name) => name != null
      ? ApiOntapStorageShelfModuleType.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfModuleType.unknown,
        )
      : null;
  //
  static ApiOntapStorageShelfModuleType fromIndex(int index) => index != null
      ? ApiOntapStorageShelfModuleType.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfModuleType.unknown,
        )
      : null;
}
