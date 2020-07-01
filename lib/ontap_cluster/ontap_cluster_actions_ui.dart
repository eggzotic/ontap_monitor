import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_response.dart';
import 'package:ontap_monitor/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_action_card.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_select_actions_page.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final actionStore = Provider.of<DataStore<OntapAction>>(context);
    // final resultStore = Provider.of<DataStore<ApiOntapCluster>>(context);
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
        return ChangeNotifierProvider.value(
          value: action,
          builder: (_, __) {
            switch (action.api.responseModel) {
              case ApiOntapCluster:
                return ChangeNotifierProvider(
                  create: (_) => OntapApiReporter<ApiOntapCluster>(
                    fromMap: ApiOntapCluster.constructFromMap,
                    owner: cluster,
                    dataStore: Provider.of<DataStore<ApiOntapCluster>>(context),
                    actionId: action.id,
                  ),
                  builder: (_, __) => OntapClusterActionCard<ApiOntapCluster>(),
                );
              case ApiOntapLicenseResponse:
                return ChangeNotifierProvider(
                  create: (_) => OntapApiReporter<ApiOntapLicenseResponse>(
                    fromMap: ApiOntapLicenseResponse.constructFromMap,
                    owner: cluster,
                    dataStore: Provider.of<DataStore<ApiOntapLicenseResponse>>(
                        context),
                    actionId: action.id,
                  ),
                  builder: (_, __) => OntapClusterActionCard<ApiOntapLicenseResponse>(),
                );
              // insert further types here
              default:
                return Center(
                  child: Text('Unknown Data-model for API ${action.api.name}'),
                );
            }
          },
        );
      },
    );
  }
}
