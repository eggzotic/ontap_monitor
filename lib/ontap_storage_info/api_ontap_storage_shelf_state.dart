//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfState {
  connected,
  disconnected,
  error,
}

//
extension ApiOntapStorageShelfStateMembers on ApiOntapStorageShelfState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfState fromName(String name) => name != null
      ? ApiOntapStorageShelfState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfState.disconnected,
        )
      : null;
  //
  static ApiOntapStorageShelfState fromIndex(int index) => index != null
      ? ApiOntapStorageShelfState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfState.disconnected,
        )
      : null;
}
