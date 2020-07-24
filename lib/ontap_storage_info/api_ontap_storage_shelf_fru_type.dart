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
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfFruType fromName(String text) =>
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
