import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_block_storage.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_efficiency.dart';

class ApiOntapStorageCluster extends StorableItem {
  ApiOntapStorageCluster({
    this.efficiency,
    this.efficiencyWithoutSnapshots,
    this.blockStorage,
    this.ownerId,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);

  final ApiOntapStorageClusterEfficiency efficiency;
  final ApiOntapStorageClusterEfficiency efficiencyWithoutSnapshots;
  final ApiOntapStorageClusterBlockStorage blockStorage;
  @override
  final String ownerId;
  @override
  String get id => ownerId + '_' + name;
  @override
  final String name = "Cluster Efficiency";
  //
  factory ApiOntapStorageCluster.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) =>
      ApiOntapStorageCluster(
        efficiency: json["efficiency"] == null
            ? null
            : ApiOntapStorageClusterEfficiency.fromMap(json["efficiency"]),
        efficiencyWithoutSnapshots: json["efficiency_without_snapshots"] == null
            ? null
            : ApiOntapStorageClusterEfficiency.fromMap(
                json["efficiency_without_snapshots"]),
        blockStorage: json["block_storage"] == null
            ? null
            : ApiOntapStorageClusterBlockStorage.fromMap(json["block_storage"]),
        ownerId: json['ownerId'] ?? ownerId,
        lastUpdated: json['lastUpdated'] != null
            ? DateTime.parse(json['lastUpdated'])
            : null,
      );

  Map<String, dynamic> get toMap => {
        "efficiency": efficiency?.toMap,
        "efficiency_without_snapshots": efficiencyWithoutSnapshots?.toMap,
        "block_storage": blockStorage?.toMap,
        'ownerId': ownerId,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
