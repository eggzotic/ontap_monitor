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
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfPortState fromName(String text) =>
      ApiOntapStorageShelfPortState.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfPortState.disconnected,
      );
  //
  static ApiOntapStorageShelfPortState fromIndex(int index) =>
      ApiOntapStorageShelfPortState.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfPortState.disconnected,
      );
}
