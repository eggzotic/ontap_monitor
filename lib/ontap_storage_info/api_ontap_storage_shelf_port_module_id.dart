//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfPortModuleId {
  a,
  b,
}

//
extension ApiOntapStorageShelfPortModuleIdMembers
    on ApiOntapStorageShelfPortModuleId {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfPortModuleId fromName(String text) =>
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
