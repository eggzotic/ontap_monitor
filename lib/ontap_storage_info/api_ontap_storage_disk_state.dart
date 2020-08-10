//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
  String get name => toString()?.split('.')?.last;
//
  // create from index
  static ApiOntapStorageDiskState fromIndex(int index) => index != null
      ? ApiOntapStorageDiskState.values.firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapStorageDiskState fromName(String name) => name != null
      ? ApiOntapStorageDiskState.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
