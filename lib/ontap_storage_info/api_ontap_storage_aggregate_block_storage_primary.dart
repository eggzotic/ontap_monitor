import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_checksum_style.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_class.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_raid_type.dart';

class ApiOntapStorageAggregateBlockStoragePrimary {
  ApiOntapStorageAggregateBlockStoragePrimary({
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
      ApiOntapStorageAggregateBlockStoragePrimary(
        diskCount: json["disk_count"],
        diskClass: json["disk_class"] == null
            ? null
            : ApiOntapStorageAggregateBlockStorageDiskClassMembers.fromName(json["disk_class"]),
        raidType: json["raid_type"] == null
            ? null
            : ApiOntapStorageAggregateRaidTypeMembers.fromName(
                json["raid_type"]),
        raidSize: json["raid_size"],
        checksumStyle: json["checksum_style"] == null
            ? null
            : ApiOntapStorageAggregateBlockStorageChecksumStyleMembers.fromName(
                json["checksum_style"]),
        diskType: json["disk_type"] == null
            ? null
            : ApiOntapStorageAggregateBlockStorageDiskTypeMembers.fromString(
                json["disk_type"]),
      );

  Map<String, dynamic> get toMap => {
        "disk_count": diskCount,
        "disk_class": diskClass?.name,
        "raid_type": raidType?.name,
        "raid_size": raidSize,
        "checksum_style": checksumStyle?.name,
        "disk_type": diskType?.name,
      };
}
