import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_action_card.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_select_actions_page.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final actionStore = Provider.of<OntapActionStore>(context);
    final actionIds = actionStore.sortedIds(cluster.actionIds);
    final actionsCount = actionIds.length;

    if (actionsCount == 0) {
      // offer a button to create
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

    return ListView.builder(
      itemCount: actionsCount,
      itemBuilder: (context, index) {
        final action = actionStore.forId(actionIds[index]);
        return ChangeNotifierProvider.value(
          value: action,
          child: OntapClusterActionCard(),
        );
      },
    );
  }
}
