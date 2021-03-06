//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfDrawerState {
  ok,
  error,
}

//
extension ApiOntapStorageShelfDrawerStateMembers
    on ApiOntapStorageShelfDrawerState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfDrawerState fromName(String name) => name != null
      ? ApiOntapStorageShelfDrawerState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfDrawerState.error,
        )
      : null;
  //
  static ApiOntapStorageShelfDrawerState fromIndex(int index) => index != null
      ? ApiOntapStorageShelfDrawerState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfDrawerState.error,
        )
      : null;
}
