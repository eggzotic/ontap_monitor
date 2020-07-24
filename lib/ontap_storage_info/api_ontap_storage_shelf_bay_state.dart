//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfBayState {
  unknown,
  ok,
  error,
}

//
extension ApiOntapStorageShelfBayStateMembers on ApiOntapStorageShelfBayState {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfBayState fromName(String text) =>
      ApiOntapStorageShelfBayState.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfBayState.unknown,
      );
  //
  static ApiOntapStorageShelfBayState fromIndex(int index) =>
      ApiOntapStorageShelfBayState.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfBayState.unknown,
      );
}
