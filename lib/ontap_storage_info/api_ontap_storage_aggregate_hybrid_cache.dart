//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_raid_type.dart';

class ApiOntapStorageAggregateHybridCache {
  ApiOntapStorageAggregateHybridCache._private({
    this.enabled,
    this.diskCount,
    this.raidType,
    this.size,
    this.used,
  });

  final bool enabled;
  final int diskCount;
  final ApiOntapStorageAggregateRaidType raidType;
  final int size;
  final int used;

  factory ApiOntapStorageAggregateHybridCache.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateHybridCache._private(
              enabled: json["enabled"],
              diskCount: json['disk_count'],
              raidType: ApiOntapStorageAggregateRaidTypeMembers.fromName(
                  json['raid_type']),
              size: json['size'],
              used: json['used'],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
        'disk_count': diskCount,
        'raid_type': raidType?.name,
        'size': size,
        'used': used,
      };
}
