//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfBayType {
  unknown,
  single_disk,
  multi_lun,
}

//
extension ApiOntapStorageShelfBayTypeMembers on ApiOntapStorageShelfBayType {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfBayType fromName(String text) =>
      ApiOntapStorageShelfBayType.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfBayType.unknown,
      );
  //
  static ApiOntapStorageShelfBayType fromIndex(int index) =>
      ApiOntapStorageShelfBayType.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfBayType.unknown,
      );
}
