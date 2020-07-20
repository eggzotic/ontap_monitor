enum ApiOntapDiskPool {
  pool0,
  pool1,
  failed,
  none,
}

extension ApiOntapDiskPoolMembers on ApiOntapDiskPool {
  String get name => toString().split('.').last;
  //
  static ApiOntapDiskPool fromString(String text) {
    return ApiOntapDiskPool.values
        .firstWhere((v) => v.name == text, orElse: () => ApiOntapDiskPool.none);
  }

  //
  static ApiOntapDiskPool fromIndex(int index) {
    return ApiOntapDiskPool.values.firstWhere((v) => v.index == index,
        orElse: () => ApiOntapDiskPool.none);
  }
}
