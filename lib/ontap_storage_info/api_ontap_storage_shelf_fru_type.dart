//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfFruType {
  module,
  psu,
}

//
extension ApiOntapStorageShelfFruTypeMembers on ApiOntapStorageShelfFruType {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfFruType fromName(String name) => name != null
      ? ApiOntapStorageShelfFruType.values.firstWhere(
          (v) => v.name == name,
          orElse: () => null,
        )
      : null;
  //
  static ApiOntapStorageShelfFruType fromIndex(int index) => index != null
      ? ApiOntapStorageShelfFruType.values.firstWhere(
          (v) => v.index == index,
          orElse: () => null,
        )
      : null;
}
