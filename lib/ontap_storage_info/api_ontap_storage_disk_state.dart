enum ApiOntapStorageDiskState {
  broken,
  copy,
  maintenance,
  partner,
  pending,
  present,
  reconstructing,
  removed,
  spare,
  unfail,
  zeroing,
}

extension ApiOntapDiskStateMembers on ApiOntapStorageDiskState {
  String get name => toString().split('.').last;
//
  // create from index
  static ApiOntapStorageDiskState fromIndex(int index) =>
      ApiOntapStorageDiskState.values.firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageDiskState fromName(String name) =>
      ApiOntapStorageDiskState.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
