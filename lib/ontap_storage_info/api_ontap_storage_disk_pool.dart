enum ApiOntapStorageDiskPool {
  pool0,
  pool1,
  failed,
  none,
}

extension ApiOntapDiskPoolMembers on ApiOntapStorageDiskPool {
  String get name => toString().split('.').last;
  //
  static ApiOntapStorageDiskPool fromString(String text) {
    return ApiOntapStorageDiskPool.values.firstWhere((v) => v.name == text,
        orElse: () => ApiOntapStorageDiskPool.none);
  }

  //
  static ApiOntapStorageDiskPool fromIndex(int index) {
    return ApiOntapStorageDiskPool.values.firstWhere((v) => v.index == index,
        orElse: () => ApiOntapStorageDiskPool.none);
  }
}
