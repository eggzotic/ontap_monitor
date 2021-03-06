//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_ui.dart';
import 'package:provider/provider.dart';

class OntapClusterEditPage extends StatelessWidget {
  final String clusterId;
  OntapClusterEditPage({
    Key key,
    this.clusterId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemStore<OntapCluster> clusterStore =
        Provider.of<SuperStore>(context).storeForType(OntapCluster);
    final add = clusterId == null;
    final cluster = add
        ? Provider.of<OntapCluster>(context)
        : clusterStore.forId(clusterId);
    return Scaffold(
      appBar: AppBar(
        title: Text(add ? 'Add Cluster' : 'Edit Cluster'),
        leading: IconButton(
          icon: Icon(Icons.done),
          onPressed: !cluster.isValid
              ? null
              : () {
                  if (add) clusterStore.add(cluster);
                  Navigator.of(context).pop();
                },
        ),
        actions: [
          if (add)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
        ],
      ),
      body: clusterId != null && !clusterStore.existsForId(clusterId)
          ? Center(
              child: Column(
                children: [
                  Text('Cannot find Cluster'),
                  RaisedButton(
                    child: Text('Close'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ),
            )
          : ChangeNotifierProvider.value(
              value: cluster,
              builder: (_, __) => OntapClusterEditUi(),
            ),
    );
  }
}
