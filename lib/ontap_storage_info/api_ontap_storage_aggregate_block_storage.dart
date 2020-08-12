//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_primary.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_hybrid_cache.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_mirror.dart';

class ApiOntapStorageAggregateBlockStorage {
  ApiOntapStorageAggregateBlockStorage._private({
    this.primary,
    this.hybridCache,
    this.mirror,
  });

  final ApiOntapStorageAggregateBlockStoragePrimary primary;
  final ApiOntapStorageAggregateHybridCache hybridCache;
  final ApiOntapStorageAggregateMirror mirror;

  factory ApiOntapStorageAggregateBlockStorage.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageAggregateBlockStorage._private(
              primary: ApiOntapStorageAggregateBlockStoragePrimary.fromMap(
                  json["primary"]),
              hybridCache: ApiOntapStorageAggregateHybridCache.fromMap(
                  json["hybrid_cache"]),
              mirror: ApiOntapStorageAggregateMirror.fromMap(json["mirror"]),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "primary": primary?.toMap,
        "hybrid_cache": hybridCache?.toMap,
        "mirror": mirror?.toMap,
      };
}
