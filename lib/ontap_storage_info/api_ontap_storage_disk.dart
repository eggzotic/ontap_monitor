//

import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_pool.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_container_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_class.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf.dart';

class ApiOntapStorageDisk extends StorableItem {
  ApiOntapStorageDisk._private({
    this.name,
    this.uid,
    this.serialNumber,
    this.model,
    this.vendor,
    this.firmwareVersion,
    this.usableSize,
    this.rpm,
    this.type,
    this.diskClass,
    this.containerType,
    this.pool,
    this.state,
    this.node,
    this.homeNode,
    this.aggregates,
    this.bay,
    this.selfEncrypting,
    this.fipsCertified,
    this.ownerId,
    this.shelf,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);
  //
  @override
  String get id => ownerId + '_' + uid;
  @override
  String ownerId;
  @override
  final String name;
  final String uid;
  final String serialNumber;
  final String model;
  final String vendor;
  final String firmwareVersion;
  final int usableSize;
  final int rpm;
  final ApiOntapStorageDiskType type;
  final ApiOntapStorageDiskClass diskClass;
  final ApiOntapStorageContainerType containerType;
  final ApiOntapStorageDiskPool pool;
  final ApiOntapStorageDiskState state;
  final ApiOntapNode node;
  final ApiOntapNode homeNode;
  final List<ApiOntapStorageAggregate> aggregates;
  final int bay;
  final bool selfEncrypting;
  final bool fipsCertified;
  final ApiOntapStorageShelf shelf;

  factory ApiOntapStorageDisk.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    return ApiOntapStorageDisk._private(
      name: json["name"],
      uid: json["uid"],
      serialNumber: json["serial_number"],
      model: json["model"],
      vendor: json["vendor"],
      firmwareVersion: json["firmware_version"],
      usableSize: json["usable_size"],
      rpm: json["rpm"],
      type: json["type"] == null
          ? null
          : ApiOntapStorageDiskTypeMembers.fromName(json["type"]),
      diskClass: json["class"] == null
          ? null
          : ApiOntapStorageDiskClassMembers.fromName(json["class"]),
      containerType: json["container_type"] == null
          ? null
          : ApiOntapStorageContainerTypeMembers.fromName(
              json["container_type"]),
      pool: json["pool"] == null
          ? null
          : ApiOntapDiskPoolMembers.fromName(json["pool"]),
      state: json["state"] == null
          ? null
          : ApiOntapDiskStateMembers.fromName(json["state"]),
      node: json["node"] == null
          ? null
          : ApiOntapNode.fromMap(json["node"], ownerId: ownerId),
      homeNode: json["home_node"] == null
          ? null
          : ApiOntapNode.fromMap(json["home_node"], ownerId: ownerId),
      aggregates: json["aggregates"] == null
          ? null
          : List<ApiOntapStorageAggregate>.from(json["aggregates"].map(
              (x) => ApiOntapStorageAggregate.fromMap(x, ownerId: ownerId))),
      bay: json["bay"],
      selfEncrypting: json["self_encrypting"] ?? false,
      fipsCertified: json["fips_certified"] ?? false,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
      ownerId: json['ownerId'] ?? ownerId,
      shelf: json['shelf'] == null
          ? null
          : ApiOntapStorageShelf.fromMap(json['shelf']),
    );
  }

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "name": name,
        "uid": uid,
        "serial_number": serialNumber,
        "model": model,
        "vendor": vendor,
        "firmware_version": firmwareVersion,
        "usable_size": usableSize,
        "rpm": rpm,
        "type": type?.name,
        "class": diskClass?.name,
        "container_type": containerType?.name,
        "pool": pool?.name,
        "state": state?.name,
        "node": node?.toMap,
        "home_node": homeNode?.toMap,
        "aggregates": aggregates?.map((x) => x?.toMap)?.toList(),
        "bay": bay,
        "self_encrypting": selfEncrypting,
        "fips_certified": fipsCertified,
        'shelf': shelf?.toMap,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
