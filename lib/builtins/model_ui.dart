//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_action_card.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster_info/ontap_cluster_info_card.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_license_info/ontap_cluster_licensing_card.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_network_info/ontap_cluster_network_ethernet_ports_card.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_node_info/ontap_cluster_nodes_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregates_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disks_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_port.dart';
import 'package:ontap_monitor/ontap_storage_info/ontap_api_storage_ports_card.dart';
import 'package:provider/provider.dart';

class ModelUi {
  static ModelUi _shared;
  ModelUi._private();

  // a Singleton getter
  static get shared {
    _shared ??= ModelUi._private();
    return _shared;
  }

  //
  final Map<
      Type,
      Widget Function({
    void Function() toRefresh,
    void Function() toReset,
  })> _uiForType = {
    ApiOntapCluster: ({toRefresh, toReset}) =>
        OntapClusterInfoCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapLicensePackage: ({toRefresh, toReset}) =>
        OntapClusterLicensingCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapNode: ({toRefresh, toReset}) =>
        OntapClusterNodesCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapNetworkEthernetPort: ({toRefresh, toReset}) =>
        OntapClusterNetworkEthernetPortsCard(
            toRefresh: toRefresh, toReset: toReset),
    ApiOntapStorageDisk: ({toRefresh, toReset}) =>
        ApiOntapStorageDisksCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapStorageAggregate: ({toRefresh, toReset}) =>
        ApiOntapStorageAggregatesCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapStorageCluster: ({toRefresh, toReset}) =>
        ApiOntapStorageClusterCard(toRefresh: toRefresh, toReset: toReset),
    ApiOntapStoragePort: ({toRefresh, toReset}) =>
        ApiOntapStoragePortCard(toRefresh: toRefresh, toReset: toReset),
  };
  //
  Widget uiForModel(
    Type t, {
    void Function() toRefresh,
    void Function() toReset,
  }) {
    if (!_uiForType.containsKey(t))
      return Center(
        child: Text('Unknown UI for $t'),
      );
    return _uiForType[t](toRefresh: toRefresh, toReset: toReset);
  }

  //
  Widget preUiForModel<T extends StorableItem>({
    BuildContext context,
    OntapCluster owner,
    ItemStore<T> dataStore,
    String actionId,
  }) {
    if (!_uiForType.containsKey(T))
      return Center(
        child: Text('Unknown Data-model $T'),
      );
    return ChangeNotifierProvider(
      create: (_) => OntapApiReporter<T>(
        owner: owner,
        dataStore: Provider.of<SuperStore>(context).storeForType(T),
        actionId: actionId,
      ),
      builder: (_, __) => OntapClusterActionCard<T>(),
    );
  }
}
