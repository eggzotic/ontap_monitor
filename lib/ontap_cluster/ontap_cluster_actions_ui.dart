import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_action_card.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_select_actions_page.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);
    final actionIds = actionStore.sortedIds(
      cluster.actionIds
          .where(
            (id) => actionStore.existsForId(id),
          )
          .toList(),
    );
    final actionsCount = actionIds.length;

    if (actionsCount == 0) {
      // offer a "Select actions" tile
      return ListView(
        children: [
          Card(
            child: ListTile(
              title: Text('Select Actions'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // clear the search filter
                actionStore.setFilterText('');
                // then open the action-selector
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                      value: cluster,
                      child: OntapClusterSelectActionsPage(),
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
          ),
        ],
      );
    }
    // main case when some actions are already selected
    return ListView.builder(
      itemCount: actionsCount,
      itemBuilder: (context, index) {
        final action = actionStore.forId(actionIds[index]);
        final onError = (String e) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Error',
                      style: Theme.of(context).textTheme.headline6),
                  content:
                      Text('$e', style: Theme.of(context).textTheme.bodyText1),
                  actions: [
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                );
              });
        };
        return ChangeNotifierProvider.value(
          value: action,
          builder: (_, __) {
            print('API responseModel = ${action.api.responseModel}');
            //
            final model = action.api.responseModel;
            if (model == ApiOntapCluster)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapCluster>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapCluster),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) => OntapClusterActionCard<ApiOntapCluster>(),
              );
            if (model == ApiOntapLicensePackage)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapLicensePackage>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapLicensePackage),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) =>
                    OntapClusterActionCard<ApiOntapLicensePackage>(),
              );
            if (model == ApiOntapNode)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapNode>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapNode),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) => OntapClusterActionCard<ApiOntapNode>(),
              );
            if (model == ApiOntapNetworkEthernetPort)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapNetworkEthernetPort>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapNetworkEthernetPort),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) =>
                    OntapClusterActionCard<ApiOntapNetworkEthernetPort>(),
              );
            if (model == ApiOntapStorageDisk)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapStorageDisk>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapStorageDisk),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) =>
                    OntapClusterActionCard<ApiOntapStorageDisk>(),
              );
            if (model == ApiOntapStorageAggregate)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapStorageAggregate>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapStorageAggregate),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) =>
                    OntapClusterActionCard<ApiOntapStorageAggregate>(),
              );
            if (model == ApiOntapStorageCluster)
              return ChangeNotifierProvider(
                create: (_) => OntapApiReporter<ApiOntapStorageCluster>(
                  owner: cluster,
                  dataStore: Provider.of<SuperStore>(context)
                      .storeForType(ApiOntapStorageCluster),
                  actionId: action.id,
                  onError: onError,
                ),
                builder: (_, __) =>
                    OntapClusterActionCard<ApiOntapStorageCluster>(),
              );
            return Center(
              child: Text('Unknown Data-model for API ${action.api.name}'),
            );
          },
        );
      },
    );
  }
}
