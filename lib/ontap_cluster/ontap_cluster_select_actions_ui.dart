//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_page.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class OntapClusterSelectActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);
    final searchEnabled = !actionStore.showSelectedOnly;
    final visibleActionIds = searchEnabled
        ? actionStore.filteredActionsIds
        : actionStore.sortedIds(cluster.actionIds);

    if (actionStore.itemCount == 0) {
      return Card(
        child: ListTile(
          title: Text('Create actions'),
          trailing: Icon(Icons.add),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => OntapActionPage()),
            );
          },
        ),
      );
    }

    return FloatingSearchBar.builder(
      itemCount: visibleActionIds.length,
      itemBuilder: (context, index) {
        final action = actionStore.forId(visibleActionIds[index]);
        final checked = cluster.hasActionId(action.id);
        return ListTile(
          leading: Icon(
            checked ? Icons.check_circle : Icons.radio_button_unchecked,
            color: Theme.of(context).accentColor,
          ),
          title: Text(action.name),
          onTap: () => cluster.toggleActionId(action.id),
        );
      },
      onChanged: (text) => actionStore.setFilterText(text),
      decoration: InputDecoration.collapsed(
        hintText:
            searchEnabled ? 'Action search...' : '(showing selected actions)',
        enabled: searchEnabled,
      ),
    );
  }
}
