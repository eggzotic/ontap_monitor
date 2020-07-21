//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';

class SuperStore with ChangeNotifier {
  SuperStore() {
    _addStores();
  }
  final Map<Type, ItemStore> _allItemStores = {};
  //
  int get storeCount => _allItemStores.length;
  ItemStore storeForType(Type t) => _allItemStores[t];
  //

  void add({
    @required Type type,
    @required ItemStore store,
  }) {
    _allItemStores[type] = store;
    store.addListener(() {
      notifyListeners();
    });
    if (store.isCacheData) _cachedDataStores.add(store);
    notifyListeners();
  }

  // right now I don't have a use-case for deleting an ItemStore...
  // void remove({Type type}) {
  //   final store = _allItemStores.remove(type);
  //   store.removeListener(() {
  //     notifyListeners();
  //   });
  //   _cachedDataStores.remove(store);
  //   notifyListeners();
  // }

  Set<ItemStore> _cachedDataStores = {};
  Map<Type, int> clearCaches() {
    final Map<Type, int> cacheCount = {};
    // empty the cached-data stores
    _cachedDataStores.forEach((dataStore) {
      cacheCount[dataStore.itemType] = dataStore.clear();
    });
    return cacheCount;
  }

  //
  // initialize some ItemStores
  void _addStores() {
    print('_addStores beginning');
    //
    add(
      type: ClusterCredentials,
      store: ItemStore<ClusterCredentials>(
          itemIdPrefix: 'cluster-credential_',
          itemFromMap: (map, {ownerId}) => ClusterCredentials.fromMap(map)),
    );
    //
    final actionStore = ItemStore<OntapAction>(
      itemIdPrefix: 'ontap-action_',
      itemFromMap: (map, {ownerId}) => OntapAction.fromMap(map),
    );
    OntapAction.addBuiltins(actionStore);
    add(type: OntapAction, store: actionStore);
    //
    final apiStore = ItemStore<OntapApi>(
      // as all APIs are currently "builtin", we will not be writing to storage, or reading them back in
      // but do not leave itemIdPrefix blank(!) or it will cause false-positives
      itemIdPrefix: 'ontap-api_',
      itemFromMap: (_, {ownerId}) => null,
    );
    OntapApi.addBuiltins(apiStore);
    add(type: OntapApi, store: apiStore);
    //
    add(
      type: OntapCluster,
      store: ItemStore<OntapCluster>(
        itemIdPrefix: 'ontap-cluster_',
        itemFromMap: (map, {ownerId}) => OntapCluster.fromMap(map),
      ),
    );
    // below here, these are all cached, as all originate as API responses
    //  so the idPrefix arg will be required in the fromMap constructor call
    add(
      type: ApiOntapCluster,
      store: ItemStore<ApiOntapCluster>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-cluster_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapCluster.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapLicensePackage,
      store: ItemStore<ApiOntapLicensePackage>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-license-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapLicensePackage.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapNode,
      store: ItemStore<ApiOntapNode>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-node-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapNode.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapNetworkEthernetPort,
      store: ItemStore<ApiOntapNetworkEthernetPort>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-network-ethernet-port-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapNetworkEthernetPort.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapStorageDisk,
      store: ItemStore<ApiOntapStorageDisk>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-disk-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageDisk.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapStorageAggregate,
      store: ItemStore<ApiOntapStorageAggregate>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-aggregate-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageAggregate.fromMap(map, ownerId: ownerId),
      ),
    );
    add(
      type: ApiOntapStorageCluster,
      store: ItemStore<ApiOntapStorageCluster>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-cluster-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageCluster.fromMap(map, ownerId: ownerId),
      ),
    );
    // add(
    //   type: ,
    //   store: ItemStore<>(
    //     isCacheData: true,
    //     itemIdPrefix: null,
    //     itemFromMap: null,
    //   ),
    // );
    print('_addStores ending');
  }
}
