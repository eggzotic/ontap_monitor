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
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapStorageAggregateMirrorState fromIndex(int index) =>
      ApiOntapStorageAggregateMirrorState.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageAggregateMirrorState fromName(String name) =>
      ApiOntapStorageAggregateMirrorState.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
