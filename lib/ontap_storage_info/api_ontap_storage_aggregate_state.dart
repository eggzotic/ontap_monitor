//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateState {
  online,
  onlining,
  offline,
  offlining,
  relocating,
  unmounted,
  restricted,
  inconsistent,
  failed,
  unknown,
}

//
extension ApiOntapStorageAggregateStateMembers
    on ApiOntapStorageAggregateState {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapStorageAggregateState fromIndex(int index) => index != null
      ? ApiOntapStorageAggregateState.values.firstWhere(
          (v) => v.index == index,
          orElse: () => ApiOntapStorageAggregateState.unknown,
        )
      : null;
  // create from name
  static ApiOntapStorageAggregateState fromName(String name) => name != null
      ? ApiOntapStorageAggregateState.values.firstWhere(
          (v) => v.name == name.toLowerCase(),
          orElse: () => ApiOntapStorageAggregateState.unknown,
        )
      : null;
}
