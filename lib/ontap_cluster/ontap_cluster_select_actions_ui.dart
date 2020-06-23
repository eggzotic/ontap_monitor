import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class OntapClusterSelectActionsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final actionStore = Provider.of<OntapActionStore>(context);
    final searchEnabled = !actionStore.showSelectedOnly;
    final visibleActionIds = searchEnabled
        ? actionStore.filteredActionsIds
        : actionStore.sortedIds(cluster.actionIds);

    if (actionStore.actionCount == 0) {
      return Card(
        child: ListTile(
          title: Text('Create some actions'),
          trailing: Icon(Icons.chevron_right),
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
          leading: checked
              ? Icon(Icons.check_circle)
              : Icon(Icons.radio_button_unchecked),
          title: Text(action.name),
          onTap: () => cluster.toggleActionId(action.id),
        );
      },
      onChanged: (text) => actionStore.setFilterText(text),
      decoration: InputDecoration.collapsed(
        hintText: searchEnabled ? 'Search...' : '(showing selected actions)',
        enabled: searchEnabled,
      ),
    );
  }
}
