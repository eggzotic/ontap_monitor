//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
  String get name => toString()?.split('.')?.last;
  // create from index
  static ApiOntapStorageDiskClass fromIndex(int index) => index != null
      ? ApiOntapStorageDiskClass.values.firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapStorageDiskClass fromName(String name) => name != null
      ? ApiOntapStorageDiskClass.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
