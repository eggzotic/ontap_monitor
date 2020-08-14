//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class CacheInfoClearTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).accentColor;
    return ListTile(
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
                  textColor: Colors.red,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Theme.of(context).accentColor),
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
    );
  }
}
