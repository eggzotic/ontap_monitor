//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_select_actions_ui.dart';
import 'package:provider/provider.dart';

class OntapClusterSelectActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);
    final name = cluster.name.isNotEmpty ? cluster.name : '(New)';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.done),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(name + ': Select Actions'),
        actions: [
          if (actionStore.itemCount > 0)
            IconButton(
              icon: Icon(actionStore.showSelectedOnly
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                actionStore.toggleSelectedOnly();
              },
            ),
        ],
      ),
      body: OntapClusterSelectActionsUi(),
    );
  }
}
