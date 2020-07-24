//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_primary.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_hybrid_cache.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_mirror.dart';

class ApiOntapStorageAggregateBlockStorage {
  ApiOntapStorageAggregateBlockStorage({
    this.primary,
    this.hybridCache,
    this.mirror,
  });

  final ApiOntapStorageAggregateBlockStoragePrimary primary;
  final ApiOntapStorageAggregateHybridCache hybridCache;
  final ApiOntapStorageAggregateMirror mirror;

  factory ApiOntapStorageAggregateBlockStorage.fromMap(
          Map<String, dynamic> json) =>
      ApiOntapStorageAggregateBlockStorage(
        primary: json["primary"] == null
            ? null
            : ApiOntapStorageAggregateBlockStoragePrimary.fromMap(
                json["primary"]),
        hybridCache: json["hybrid_cache"] == null
            ? null
            : ApiOntapStorageAggregateHybridCache.fromMap(json["hybrid_cache"]),
        mirror: json["mirror"] == null
            ? null
            : ApiOntapStorageAggregateMirror.fromMap(json["mirror"]),
      );

  Map<String, dynamic> get toMap => {
        "primary": primary?.toMap,
        "hybrid_cache": hybridCache?.toMap,
        "mirror": mirror?.toMap,
      };
}
