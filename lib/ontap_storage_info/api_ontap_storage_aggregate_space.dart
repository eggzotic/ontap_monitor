//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_space_block_storage.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_space_cloud_storage.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_space_efficiency.dart';

class ApiOntapStorageAggregateSpace {
  ApiOntapStorageAggregateSpace._private({
    this.blockStorage,
    this.cloudStorage,
    this.efficiency,
    this.efficiencyWithoutSnapshots,
    this.footprint,
  });

  final ApiOntapStorageAggregateSpaceBlockStorage blockStorage;
  final ApiOntapStorageAggregateSpaceCloudStorage cloudStorage;
  final ApiOntapStorageAggregateSpaceEfficiency efficiency;
  final ApiOntapStorageAggregateSpaceEfficiency efficiencyWithoutSnapshots;
  final int footprint;

  factory ApiOntapStorageAggregateSpace.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateSpace._private(
              blockStorage: ApiOntapStorageAggregateSpaceBlockStorage.fromMap(
                  json["block_storage"]),
              cloudStorage: ApiOntapStorageAggregateSpaceCloudStorage.fromMap(
                  json["cloud_storage"]),
              efficiency: ApiOntapStorageAggregateSpaceEfficiency.fromMap(
                  json["efficiency"]),
              efficiencyWithoutSnapshots:
                  ApiOntapStorageAggregateSpaceEfficiency.fromMap(
                      json["efficiency_without_snapshots"]),
              footprint: json['footprint'],
            )
          : null;

  Map<String, dynamic> get toMap => {
        "block_storage": blockStorage?.toMap,
        "cloud_storage": cloudStorage?.toMap,
        "efficiency": efficiency?.toMap,
        "efficiency_without_snapshots": efficiencyWithoutSnapshots?.toMap,
        'footprint': footprint,
      };
}
