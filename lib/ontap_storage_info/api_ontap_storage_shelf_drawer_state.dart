enum ApiOntapStorageShelfDrawerState {
  ok,
  error,
}

//
extension ApiOntapStorageShelfDrawerStateMembers
    on ApiOntapStorageShelfDrawerState {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfDrawerState fromName(String text) =>
      ApiOntapStorageShelfDrawerState.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfDrawerState.error,
      );
  //
  static ApiOntapStorageShelfDrawerState fromIndex(int index) =>
      ApiOntapStorageShelfDrawerState.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfDrawerState.error,
      );
}
