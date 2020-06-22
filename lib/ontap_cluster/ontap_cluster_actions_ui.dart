import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_action_card.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final actionStore = Provider.of<OntapActionStore>(context);
    final actionIds = actionStore.sortedIds(cluster.actionIds);

    return ListView.builder(
      itemCount: actionIds.length,
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
