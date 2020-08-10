//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageDiskPool {
  pool0,
  pool1,
  failed,
  none,
}

extension ApiOntapDiskPoolMembers on ApiOntapStorageDiskPool {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapStorageDiskPool fromName(String name) {
    if (name == null) return null;
    return ApiOntapStorageDiskPool.values.firstWhere((v) => v.name == name,
        orElse: () => ApiOntapStorageDiskPool.none);
  }

  //
  static ApiOntapStorageDiskPool fromIndex(int index) {
    if (index == null) return null;
    return ApiOntapStorageDiskPool.values.firstWhere((v) => v.index == index,
        orElse: () => ApiOntapStorageDiskPool.none);
  }
}
