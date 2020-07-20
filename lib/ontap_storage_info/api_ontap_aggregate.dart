import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';

class ApiOntapAggregate extends StorableItem {
  ApiOntapAggregate._private({
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
  final ApiOntapSpace space;
  final String state;
  final String snaplockType;
  final DateTime createTime;
  final ApiOntapDataEncryption dataEncryption;
  final ApiOntapAggregateBlockStorage blockStorage;
  final List<ApiOntapPlex> plexes;
  final ApiOntapAggregateCloudStorage cloudStorage;

  factory ApiOntapAggregate.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    assert(ownerId != null || json['ownerId'] != null);
    return ApiOntapAggregate._private(
      uuid: json["uuid"],
      name: json["name"],
      node: json["node"] == null ? null : ApiOntapNode.fromMap(json["node"]),
      homeNode: json["home_node"] == null
          ? null
          : ApiOntapNode.fromMap(json["home_node"]),
      space:
          json["space"] == null ? null : ApiOntapSpace.fromMap(json["space"]),
      state: json["state"] == null ? null : json["state"],
      snaplockType:
          json["snaplock_type"] == null ? null : json["snaplock_type"],
      createTime: json["create_time"] == null
          ? null
          : DateTime.parse(json["create_time"]),
      dataEncryption: json["data_encryption"] == null
          ? null
          : ApiOntapDataEncryption.fromMap(json["data_encryption"]),
      blockStorage: json["block_storage"] == null
          ? null
          : ApiOntapAggregateBlockStorage.fromMap(json["block_storage"]),
      plexes: json["plexes"] == null
          ? null
          : List<ApiOntapPlex>.from(
              json["plexes"].map((x) => ApiOntapPlex.fromMap(x))),
      cloudStorage: json["cloud_storage"] == null
          ? null
          : ApiOntapAggregateCloudStorage.fromMap(json["cloud_storage"]),
      ownerId: json['ownerId'] ?? ownerId,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "uuid": uuid == null ? null : uuid,
        "name": name == null ? null : name,
        "node": node == null ? null : node.toMap,
        "home_node": homeNode == null ? null : homeNode.toMap,
        "space": space == null ? null : space.toMap(),
        "state": state == null ? null : state,
        "snaplock_type": snaplockType == null ? null : snaplockType,
        "create_time": createTime == null ? null : createTime.toIso8601String(),
        "data_encryption":
            dataEncryption == null ? null : dataEncryption.toMap(),
        "block_storage": blockStorage == null ? null : blockStorage.toMap(),
        "plexes": plexes == null
            ? null
            : List<dynamic>.from(plexes.map((x) => x.toMap())),
        "cloud_storage": cloudStorage == null ? null : cloudStorage.toMap(),
        'lastUpdated': lastUpdated.toIso8601String(),
      };
}

class ApiOntapAggregateBlockStorage {
  ApiOntapAggregateBlockStorage({
    this.primary,
    this.hybridCache,
    this.mirror,
  });

  final Primary primary;
  final HybridCache hybridCache;
  final Mirror mirror;

  factory ApiOntapAggregateBlockStorage.fromMap(Map<String, dynamic> json) =>
      ApiOntapAggregateBlockStorage(
        primary:
            json["primary"] == null ? null : Primary.fromMap(json["primary"]),
        hybridCache: json["hybrid_cache"] == null
            ? null
            : HybridCache.fromMap(json["hybrid_cache"]),
        mirror: json["mirror"] == null ? null : Mirror.fromMap(json["mirror"]),
      );

  Map<String, dynamic> toMap() => {
        "primary": primary == null ? null : primary.toMap(),
        "hybrid_cache": hybridCache == null ? null : hybridCache.toMap(),
        "mirror": mirror == null ? null : mirror.toMap(),
      };
}

class HybridCache {
  HybridCache({
    this.enabled,
  });

  final bool enabled;

  factory HybridCache.fromMap(Map<String, dynamic> json) => HybridCache(
        enabled: json["enabled"] == null ? null : json["enabled"],
      );

  Map<String, dynamic> toMap() => {
        "enabled": enabled == null ? null : enabled,
      };
}

class Mirror {
  Mirror({
    this.enabled,
    this.state,
  });

  final bool enabled;
  final String state;

  factory Mirror.fromMap(Map<String, dynamic> json) => Mirror(
        enabled: json["enabled"] == null ? null : json["enabled"],
        state: json["state"] == null ? null : json["state"],
      );

  Map<String, dynamic> toMap() => {
        "enabled": enabled == null ? null : enabled,
        "state": state == null ? null : state,
      };
}

class Primary {
  Primary({
    this.diskCount,
    this.diskClass,
    this.raidType,
    this.raidSize,
    this.checksumStyle,
    this.diskType,
  });

  final int diskCount;
  final String diskClass;
  final String raidType;
  final int raidSize;
  final String checksumStyle;
  final String diskType;

  factory Primary.fromMap(Map<String, dynamic> json) => Primary(
        diskCount: json["disk_count"] == null ? null : json["disk_count"],
        diskClass: json["disk_class"] == null ? null : json["disk_class"],
        raidType: json["raid_type"] == null ? null : json["raid_type"],
        raidSize: json["raid_size"] == null ? null : json["raid_size"],
        checksumStyle:
            json["checksum_style"] == null ? null : json["checksum_style"],
        diskType: json["disk_type"] == null ? null : json["disk_type"],
      );

  Map<String, dynamic> toMap() => {
        "disk_count": diskCount == null ? null : diskCount,
        "disk_class": diskClass == null ? null : diskClass,
        "raid_type": raidType == null ? null : raidType,
        "raid_size": raidSize == null ? null : raidSize,
        "checksum_style": checksumStyle == null ? null : checksumStyle,
        "disk_type": diskType == null ? null : diskType,
      };
}

class ApiOntapAggregateCloudStorage {
  ApiOntapAggregateCloudStorage({
    this.attachEligible,
  });

  final bool attachEligible;

  factory ApiOntapAggregateCloudStorage.fromMap(Map<String, dynamic> json) =>
      ApiOntapAggregateCloudStorage(
        attachEligible:
            json["attach_eligible"] == null ? null : json["attach_eligible"],
      );

  Map<String, dynamic> toMap() => {
        "attach_eligible": attachEligible == null ? null : attachEligible,
      };
}

class ApiOntapDataEncryption {
  ApiOntapDataEncryption({
    this.softwareEncryptionEnabled,
    this.driveProtectionEnabled,
  });

  final bool softwareEncryptionEnabled;
  final bool driveProtectionEnabled;

  factory ApiOntapDataEncryption.fromMap(Map<String, dynamic> json) =>
      ApiOntapDataEncryption(
        softwareEncryptionEnabled: json["software_encryption_enabled"] == null
            ? null
            : json["software_encryption_enabled"],
        driveProtectionEnabled: json["drive_protection_enabled"] == null
            ? null
            : json["drive_protection_enabled"],
      );

  Map<String, dynamic> toMap() => {
        "software_encryption_enabled": softwareEncryptionEnabled == null
            ? null
            : softwareEncryptionEnabled,
        "drive_protection_enabled":
            driveProtectionEnabled == null ? null : driveProtectionEnabled,
      };
}

class ApiOntapPlex {
  ApiOntapPlex({this.name});
  final String name;
  factory ApiOntapPlex.fromMap(Map<String, dynamic> json) => ApiOntapPlex(
        name: json["name"],
      );
  Map<String, dynamic> toMap() => {
        "name": name,
      };
}

class ApiOntapSpace {
  ApiOntapSpace({
    this.blockStorage,
    this.cloudStorage,
  });

  final ApiOntapSpaceBlockStorage blockStorage;
  final ApiOntapSpaceCloudStorage cloudStorage;

  factory ApiOntapSpace.fromMap(Map<String, dynamic> json) => ApiOntapSpace(
        blockStorage: json["block_storage"] == null
            ? null
            : ApiOntapSpaceBlockStorage.fromMap(json["block_storage"]),
        cloudStorage: json["cloud_storage"] == null
            ? null
            : ApiOntapSpaceCloudStorage.fromMap(json["cloud_storage"]),
      );

  Map<String, dynamic> toMap() => {
        "block_storage": blockStorage == null ? null : blockStorage.toMap(),
        "cloud_storage": cloudStorage == null ? null : cloudStorage.toMap(),
      };
}

class ApiOntapSpaceBlockStorage {
  ApiOntapSpaceBlockStorage({
    this.size,
    this.available,
    this.used,
    this.fullThresholdPercent,
  });

  final int size;
  final int available;
  final int used;
  final int fullThresholdPercent;

  factory ApiOntapSpaceBlockStorage.fromMap(Map<String, dynamic> json) =>
      ApiOntapSpaceBlockStorage(
        size: json["size"],
        available: json["available"],
        used: json["used"],
        fullThresholdPercent: json["full_threshold_percent"],
      );

  Map<String, dynamic> toMap() => {
        "size": size,
        "available": available,
        "used": used,
        "full_threshold_percent": fullThresholdPercent,
      };
}

class ApiOntapSpaceCloudStorage {
  ApiOntapSpaceCloudStorage({this.used});
  final int used;
  factory ApiOntapSpaceCloudStorage.fromMap(Map<String, dynamic> json) =>
      ApiOntapSpaceCloudStorage(
        used: json["used"],
      );
  Map<String, dynamic> toMap() => {
        "used": used,
      };
}
