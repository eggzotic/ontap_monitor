//
enum ApiOntapStorageDiskClass {
  unknown,
  capacity,
  performance,
  archive,
  solid_state,
  array,
  virtual,
}

extension ApiOntapStorageDiskClassMembers on ApiOntapStorageDiskClass {
  //
  String get name => toString().split('.').last;
  // create from index
  static ApiOntapStorageDiskClass fromIndex(int index) =>
      ApiOntapStorageDiskClass.values.firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageDiskClass fromName(String name) =>
      ApiOntapStorageDiskClass.values.firstWhere((v) => v.name == name.toLowerCase());
}
