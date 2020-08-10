//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageShelfFruState { ok, error }
//

extension ApiOntapStorageShelfFruStateMembers on ApiOntapStorageShelfFruState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageShelfFruState fromName(String name) => name != null
      ? ApiOntapStorageShelfFruState.values.firstWhere(
          (v) => v.name == name,
          orElse: () => ApiOntapStorageShelfFruState.error,
        )
      : null;
  //
  static ApiOntapStorageShelfFruState fromIndex(int index) => index != null
      ? ApiOntapStorageShelfFruState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageShelfFruState.error,
        )
      : null;
}
