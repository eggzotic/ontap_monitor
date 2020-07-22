import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_cloud_storage.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_data_encryption.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_plex.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_snaplock_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_space.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_state.dart';

class ApiOntapStorageAggregate extends StorableItem {
  ApiOntapStorageAggregate._private({
    this.ownerId,
    this.uuid,
    this.name,
    this.node,
    this.homeNode,
    this.space,
    this.state,
    this.snaplockType,
    this.createTime,
    this.dataEncryption,
    this.blockStorage,
    this.plexes,
    this.cloudStorage,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);
  @override
  String get id => ownerId + '_' + uuid;

  @override
  String ownerId;
  final String uuid;
  @override
  final String name;
  final ApiOntapNode node;
  final ApiOntapNode homeNode;
  final ApiOntapStorageAggregateSpace space;
  final ApiOntapStorageAggregateState state;
  final ApiOntapStorageAggregateSnaplockType snaplockType;
  final DateTime createTime;
  final ApiOntapStorageAggregateDataEncryption dataEncryption;
  final ApiOntapStorageAggregateBlockStorage blockStorage;
  final List<ApiOntapStorageAggregatePlex> plexes;
  final ApiOntapStorageAggregateCloudStorage cloudStorage;

  factory ApiOntapStorageAggregate.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    assert(ownerId != null || json['ownerId'] != null);
    return ApiOntapStorageAggregate._private(
      uuid: json["uuid"],
      name: json["name"],
      node: json["node"] == null ? null : ApiOntapNode.fromMap(json["node"]),
      homeNode: json["home_node"] == null
          ? null
          : ApiOntapNode.fromMap(json["home_node"]),
      space: json["space"] == null
          ? null
          : ApiOntapStorageAggregateSpace.fromMap(json["space"]),
      state: json["state"] == null
          ? null
          : ApiOntapStorageAggregateStateMembers.fromName(json["state"]),
      snaplockType: json["snaplock_type"] == null
          ? null
          : ApiOntapStorageAggregateSnaplockTypeMembers.fromName(
              json["snaplock_type"]),
      createTime: json["create_time"] == null
          ? null
          : DateTime.parse(json["create_time"]),
      dataEncryption: json["data_encryption"] == null
          ? null
          : ApiOntapStorageAggregateDataEncryption.fromMap(
              json["data_encryption"]),
      blockStorage: json["block_storage"] == null
          ? null
          : ApiOntapStorageAggregateBlockStorage.fromMap(json["block_storage"]),
      plexes: json["plexes"] == null
          ? null
          : List<ApiOntapStorageAggregatePlex>.from(json["plexes"]
              .map((x) => ApiOntapStorageAggregatePlex.fromMap(x))),
      cloudStorage: json["cloud_storage"] == null
          ? null
          : ApiOntapStorageAggregateCloudStorage.fromMap(json["cloud_storage"]),
      ownerId: json['ownerId'] ?? ownerId,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "uuid": uuid,
        "name": name,
        "node": node?.toMap,
        "home_node": homeNode?.toMap,
        "space": space?.toMap,
        "state": state?.name,
        "snaplock_type": snaplockType?.name,
        "create_time": createTime?.toIso8601String(),
        "data_encryption": dataEncryption?.toMap,
        "block_storage": blockStorage?.toMap,
        "plexes": plexes?.map((x) => x?.toMap)?.toList(),
        "cloud_storage": cloudStorage?.toMap,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
