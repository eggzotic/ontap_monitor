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
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapStorageAggregateBlockStorageDiskType fromIndex(int index) =>
      ApiOntapStorageAggregateBlockStorageDiskType.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageAggregateBlockStorageDiskType fromString(String name) =>
      ApiOntapStorageAggregateBlockStorageDiskType.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
