enum ApiOntapStorageShelfState {
  connected,
  disconnected,
  error,
}

//
extension ApiOntapStorageShelfStateMembers on ApiOntapStorageShelfState {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfState fromString(String text) =>
      ApiOntapStorageShelfState.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfState.disconnected,
      );
  //
  static ApiOntapStorageShelfState fromIndex(int index) =>
      ApiOntapStorageShelfState.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfState.disconnected,
      );
}
