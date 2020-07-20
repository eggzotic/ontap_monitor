import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/cluster_select_credentials_ui.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_select_actions_page.dart';
import 'package:provider/provider.dart';

//
class OntapClusterEditUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);

    if (cluster.credentialsRequired) {
      cluster.setCredentialsRequired(false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          title: 'Credentials Required',
          message: 'Select or Create Credentials',
          duration: Duration(seconds: 2),
        )..show(context);
      });
    }

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.name,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Cluster Name'),
            onChanged: (newName) => cluster.setName(newName),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.description,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (newName) => cluster.setDescription(newName),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.adminLifAddress,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Admin LIF Address'),
            onChanged: (newName) => cluster.setAdminLifAddress(newName),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Credentials',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                .copyWith(color: Colors.black54),
          ),
        ),
        Padding(
            padding: EdgeInsets.all(8.0), child: ClusterSelectCredentialsUi()),
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
        if (cluster.actionCount > 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Actions',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.black54)),
          ),
        // list all the actions currently associated with this cluster, and
        //  allow swipe-left to remove them
        ...actionStore
            .sortedIds(cluster.actionIds)
            .map(
              (id) => Dismissible(
                key: ValueKey(id),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => cluster.toggleActionId(id),
                child: Card(
                  child: ListTile(
                    title: Text(actionStore.forId(id).name),
                    trailing: Icon(Icons.chevron_left),
                  ),
                ),
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.delete_sweep, color: Colors.white),
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
