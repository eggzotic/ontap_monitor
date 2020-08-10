//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateBlockStorageDiskType {
  fc,
  lun,
  nl_sas,
  nvme_ssd,
  sas,
  sata,
  scsi,
  ssd,
  vm_disk,
}

//
extension ApiOntapStorageAggregateBlockStorageDiskTypeMembers
    on ApiOntapStorageAggregateBlockStorageDiskType {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapStorageAggregateBlockStorageDiskType fromIndex(int index) =>
      index != null
          ? ApiOntapStorageAggregateBlockStorageDiskType.values
              .firstWhere((v) => v.index == index)
          : null;
  // create from name
  static ApiOntapStorageAggregateBlockStorageDiskType fromName(String name) =>
      name != null
          ? ApiOntapStorageAggregateBlockStorageDiskType.values
              .firstWhere((v) => v.name == name.toLowerCase())
          : null;
}
