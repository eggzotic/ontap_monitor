//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
  String get name => toString()?.split('.')?.last;
  // create from index
  static ApiOntapStorageAggregateBlockStorageDiskClass fromIndex(int index) =>
      index != null
          ? ApiOntapStorageAggregateBlockStorageDiskClass.values
              .firstWhere((v) => v.index == index)
          : null;
  // create from name
  static ApiOntapStorageAggregateBlockStorageDiskClass fromName(String name) =>
      name != null
          ? ApiOntapStorageAggregateBlockStorageDiskClass.values
              .firstWhere((v) => v.name == name.toLowerCase())
          : null;
}
