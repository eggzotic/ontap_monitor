enum ApiOntapDiskState {
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

extension ApiOntapDiskStateMembers on ApiOntapDiskState {
  String get name => toString().split('.').last;
//
  // create from index
  static ApiOntapDiskState fromIndex(int index) =>
      ApiOntapDiskState.values.firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapDiskState fromName(String name) =>
      ApiOntapDiskState.values.firstWhere((v) => v.name == name.toLowerCase());
}
