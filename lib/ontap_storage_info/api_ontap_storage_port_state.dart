//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStoragePortState {
  online,
  offline,
  error,
}

//
extension ApiOntapStoragePortStateMembers on ApiOntapStoragePortState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStoragePortState fromName(String name) => name != null
      ? ApiOntapStoragePortState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStoragePortState.error,
        )
      : null;
}
