//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_checksum_style.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_class.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_raid_type.dart';

class ApiOntapStorageAggregateBlockStoragePrimary {
  ApiOntapStorageAggregateBlockStoragePrimary._private({
    this.diskCount,
    this.diskClass,
    this.raidType,
    this.raidSize,
    this.checksumStyle,
    this.diskType,
  });

  final int diskCount;
  final ApiOntapStorageAggregateBlockStorageDiskClass diskClass;
  final ApiOntapStorageAggregateRaidType raidType;
  final int raidSize;
  final ApiOntapStorageAggregateBlockStorageChecksumStyle checksumStyle;
  final ApiOntapStorageAggregateBlockStorageDiskType diskType;

  factory ApiOntapStorageAggregateBlockStoragePrimary.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateBlockStoragePrimary._private(
              diskCount: json["disk_count"],
              diskClass:
                  ApiOntapStorageAggregateBlockStorageDiskClassMembers.fromName(
                      json["disk_class"]),
              raidType: ApiOntapStorageAggregateRaidTypeMembers.fromName(
                  json["raid_type"]),
              raidSize: json["raid_size"],
              checksumStyle:
                  ApiOntapStorageAggregateBlockStorageChecksumStyleMembers
                      .fromName(json["checksum_style"]),
              diskType:
                  ApiOntapStorageAggregateBlockStorageDiskTypeMembers.fromName(
                      json["disk_type"]),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "disk_count": diskCount,
        "disk_class": diskClass?.name,
        "raid_type": raidType?.name,
        "raid_size": raidSize,
        "checksum_style": checksumStyle?.name,
        "disk_type": diskType?.name,
      };
}
