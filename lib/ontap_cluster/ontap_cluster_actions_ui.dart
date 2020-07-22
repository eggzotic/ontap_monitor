import 'package:flutter/material.dart';
import 'package:ontap_monitor/builtins/model_ui.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
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
              return ModelUi.shared().preUiForModel<ApiOntapCluster>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapLicensePackage)
              return ModelUi.shared().preUiForModel<ApiOntapLicensePackage>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapNode)
              return ModelUi.shared().preUiForModel<ApiOntapNode>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapNetworkEthernetPort)
              return ModelUi.shared().preUiForModel<ApiOntapNetworkEthernetPort>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapStorageDisk)
              return ModelUi.shared().preUiForModel<ApiOntapStorageDisk>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapStorageAggregate)
              return ModelUi.shared().preUiForModel<ApiOntapStorageAggregate>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
              );
            if (model == ApiOntapStorageCluster)
              return ModelUi.shared().preUiForModel<ApiOntapStorageCluster>(
                context: context,
                owner: cluster,
                dataStore: Provider.of<SuperStore>(context).storeForType(model),
                actionId: action.id,
                onError: onError,
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
