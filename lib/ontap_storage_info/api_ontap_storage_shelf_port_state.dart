//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfPortState {
  connected,
  disconnected,
  error,
}

//
extension ApiOntapStorageShelfPortStateMembers
    on ApiOntapStorageShelfPortState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfPortState fromName(String name) => name != null
      ? ApiOntapStorageShelfPortState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfPortState.disconnected,
        )
      : null;
  //
  static ApiOntapStorageShelfPortState fromIndex(int index) => index != null
      ? ApiOntapStorageShelfPortState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfPortState.disconnected,
        )
      : null;
}
