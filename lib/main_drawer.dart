import 'package:flutter/material.dart';
import 'package:ontap_monitor/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_page.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
// import 'package:ontap_monitor/ontap_api_actions/ontap_action_page.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clusterStore = Provider.of<DataStore<OntapCluster>>(context);
    final actionStore = Provider.of<DataStore<OntapAction>>(context);
    final iconColor = Theme.of(context).accentColor;
    //
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline, color: iconColor),
            title: Text('About Ontap Monitor'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutOntapMonitor(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock_outline, color: iconColor),
            title: Text('Manage Credentials'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ClusterCredentialPage()),
              );
            },
          ),
          // Disabling Action-editing for now
          //
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.directions_run, color: iconColor),
          //   title: Text('Manage Actions'),
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     Navigator.of(context).push(
          //       MaterialPageRoute(builder: (_) => OntapActionPage()),
          //     );
          //   },
          // ),
          Divider(),
          ListTile(
            leading: Icon(Icons.cached, color: iconColor),
            title: Text('Clear Cache'),
            onTap: () {
              // this code should probably be moved somewhere else...?
              // Clear the cached-items datastores
              final cacheCounters = DataStore.clearCaches();
              //
              // Count & clear Stale Action IDs still attached to clusters
              int deletedStaleActionIds = 0;
              clusterStore.idsSorted.forEach((id) {
                final cluster = clusterStore.forId(id);
                deletedStaleActionIds +=
                    cluster.clearStaleActionIds(usingActionStore: actionStore);
              });

              // insert other cache-clearings above here
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cache-Clear Report'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ],
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ...cacheCounters.keys
                          .map((type) => Text('$type: ${cacheCounters[type]}'))
                          .toList(),
                      Text('Stale action IDs: $deletedStaleActionIds'),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
