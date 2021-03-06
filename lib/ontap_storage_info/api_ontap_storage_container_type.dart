//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageContainerType {
  aggregate,
  broken,
  foreign,
  labelmaint,
  maintenance,
  shared,
  spare,
  unassigned,
  unknown,
  unsupported,
  remote,
  mediator,
}

//
extension ApiOntapStorageContainerTypeMembers on ApiOntapStorageContainerType {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapStorageContainerType fromIndex(int index) => index != null
      ? ApiOntapStorageContainerType.values.firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapStorageContainerType fromName(String name) => name != null
      ? ApiOntapStorageContainerType.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
