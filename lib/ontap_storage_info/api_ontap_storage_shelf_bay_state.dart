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
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfBayState fromName(String name) => name != null
      ? ApiOntapStorageShelfBayState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfBayState.unknown,
        )
      : null;
  //
  static ApiOntapStorageShelfBayState fromIndex(int index) => index != null
      ? ApiOntapStorageShelfBayState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfBayState.unknown,
        )
      : null;
}
