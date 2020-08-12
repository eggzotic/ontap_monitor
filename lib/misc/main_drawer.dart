//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/misc/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_page.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
// import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final ItemStore<OntapAction> actionStore =
    //     superStore.storeForType(OntapAction);
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
          // Disabling Action-editing for now - builtins only
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
            title: Text('Cache Report'),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (context) {
                  final superStore = Provider.of<SuperStore>(context);
                  final ItemStore<OntapCluster> clusterStore =
                      superStore.storeForType(OntapCluster);
                  final cacheCounters = superStore.cacheCounts();
                  return AlertDialog(
                    title: Text('Cached Items'),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          superStore.clearCaches();
                          clusterStore.idsSorted.forEach((id) {
                            final cluster = clusterStore.forId(id);
                            // deletedStaleActionIds += cluster.clearStaleActionIds(
                            //     usingStore: actionStore);
                            cluster.clearCachedResultIds();
                            // insert other cache-clearing ops above here
                            //
                          });
                        },
                        child: Text('Clear Now'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Close',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: cacheCounters.keys
                          .map((type) => Text('$type: ${cacheCounters[type]}'))
                          .toList(),
                    ),
                  );
                },
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
