enum ApiOntapStorageAggregateBlockStorageDiskClass {
  capacity,
  performance,
  archive,
  solid_state,
  array,
  virtual,
  data_center,
  capacity_flash,
}

//
extension ApiOntapStorageAggregateBlockStorageDiskClassMembers
    on ApiOntapStorageAggregateBlockStorageDiskClass {
  //
  String get name => toString().split('.').last;
  // create from index
  static ApiOntapStorageAggregateBlockStorageDiskClass fromIndex(int index) =>
      ApiOntapStorageAggregateBlockStorageDiskClass.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageAggregateBlockStorageDiskClass fromName(String name) =>
      ApiOntapStorageAggregateBlockStorageDiskClass.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
