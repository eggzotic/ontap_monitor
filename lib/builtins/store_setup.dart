import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';

class StoreSetup {
  // a factory constructor posing as a Singleton
  factory StoreSetup.shared({SuperStore superStore}) {
    _shared ??= StoreSetup._private(superStore);
    return _shared;
  }
  StoreSetup._private(SuperStore superStore)
      : assert(superStore != null),
        this._superStore = superStore {
    _setupItemStores();
    _setupBuiltinApis();
    _setupBuiltinActions();
  }
  final SuperStore _superStore;
  static StoreSetup _shared;
  //
  void _setupItemStores() {
    print('_addItemStores beginning');
    //
    _superStore.add(
      type: ClusterCredentials,
      store: ItemStore<ClusterCredentials>(
        itemIdPrefix: 'cluster-credential_',
        itemFromMap: (map, {ownerId}) => ClusterCredentials.fromMap(map),
      ),
    );
    //
    _superStore.add(
      type: OntapApi,
      store: ItemStore<OntapApi>(
        // do not leave itemIdPrefix blank(!), even though we're not storing these
        itemIdPrefix: 'ontap-api_',
        itemFromMap: (_, {ownerId}) => null,
      ),
    );
    //
    _superStore.add(
      type: OntapAction,
      store: ItemStore<OntapAction>(
        itemIdPrefix: 'ontap-action_',
        itemFromMap: (map, {ownerId}) => OntapAction.fromMap(map),
      ),
    );
    //
    _superStore.add(
      type: OntapCluster,
      store: ItemStore<OntapCluster>(
        itemIdPrefix: 'ontap-cluster_',
        itemFromMap: (map, {ownerId}) => OntapCluster.fromMap(map),
      ),
    );
    // below here, these are all cached, as all originate from API responses
    _superStore.add(
      type: ApiOntapCluster,
      store: ItemStore<ApiOntapCluster>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-cluster_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapCluster.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapLicensePackage,
      store: ItemStore<ApiOntapLicensePackage>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-license-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapLicensePackage.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapNode,
      store: ItemStore<ApiOntapNode>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-node-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapNode.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapNetworkEthernetPort,
      store: ItemStore<ApiOntapNetworkEthernetPort>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-network-ethernet-port-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapNetworkEthernetPort.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapStorageDisk,
      store: ItemStore<ApiOntapStorageDisk>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-disk-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageDisk.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapStorageAggregate,
      store: ItemStore<ApiOntapStorageAggregate>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-aggregate-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageAggregate.fromMap(map, ownerId: ownerId),
      ),
    );
    _superStore.add(
      type: ApiOntapStorageCluster,
      store: ItemStore<ApiOntapStorageCluster>(
        isCacheData: true,
        itemIdPrefix: 'api-ontap-storage-cluster-response_',
        itemFromMap: (map, {ownerId}) =>
            ApiOntapStorageCluster.fromMap(map, ownerId: ownerId),
      ),
    );
    print('_addItemStores ending');
  }

  //
  void _setupBuiltinActions() {
    //
    print('_setupBuiltinActions beginning');
    final actionStore = _superStore.storeForType(OntapAction);
    final apiStore = _superStore.storeForType(OntapApi);
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Cluster Info')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET cluster')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Cluster Licenses')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET cluster/licensing/licenses')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Cluster Nodes')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET cluster/nodes')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Ethernet Ports')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET network/ethernet/ports')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Disks')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET storage/disks')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Aggregates')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET storage/aggregates')),
      neverStore: true,
    );
    actionStore.add(
      OntapAction(builtin: true)
        ..setName('Cluster Storage Summary')
        ..setDescription('Builtin Action')
        ..setApi(apiStore.forId('GET storage/cluster')),
      neverStore: true,
    );
    print('_setupBuiltinActions ending');
  }

  //
  void _setupBuiltinApis() {
    final apiStore = _superStore.storeForType(OntapApi);
    print('_setupBuiltinApis beginning');
    apiStore.add(
      OntapApi<ApiOntapCluster>(name: 'cluster'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapLicensePackage>(name: 'cluster/licensing/licenses'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapNode>(name: 'cluster/nodes'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapNetworkEthernetPort>(name: 'network/ethernet/ports'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapStorageDisk>(name: 'storage/disks'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapStorageAggregate>(name: 'storage/aggregates'),
      neverStore: true,
    );
    apiStore.add(
      OntapApi<ApiOntapStorageCluster>(name: 'storage/cluster'),
      neverStore: true,
    );
    print('_setupBuiltinApis ending');
  }
}
