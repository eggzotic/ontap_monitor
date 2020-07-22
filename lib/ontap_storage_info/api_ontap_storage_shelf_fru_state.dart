enum ApiOntapStorageShelfFruState { ok, error }
//

extension ApiOntapStorageShelfFruStateMembers on ApiOntapStorageShelfFruState {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageShelfFruState fromName(String text) =>
      ApiOntapStorageShelfFruState.values.firstWhere(
        (v) => v.name == text,
        orElse: () => ApiOntapStorageShelfFruState.error,
      );
  //
  static ApiOntapStorageShelfFruState fromIndex(int index) =>
      ApiOntapStorageShelfFruState.values.firstWhere(
        (v) => v.index == index,
        orElse: () => ApiOntapStorageShelfFruState.error,
      );
}
