//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateMirrorState {
  unmirrored,
  normal,
  degraded,
  resynchronizing,
  failed,
}

//
extension ApiOntapStorageAggregateMirrorStateMembers
    on ApiOntapStorageAggregateMirrorState {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapStorageAggregateMirrorState fromIndex(int index) =>
      index != null
          ? ApiOntapStorageAggregateMirrorState.values
              .firstWhere((v) => v.index == index)
          : null;
  // create from name
  static ApiOntapStorageAggregateMirrorState fromName(String name) =>
      name != null
          ? ApiOntapStorageAggregateMirrorState.values
              .firstWhere((v) => v.name == name.toLowerCase())
          : null;
}
