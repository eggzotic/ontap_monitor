import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_card.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';

class OntapClusterListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemStore<OntapCluster> clusterStore =
        Provider.of<SuperStore>(context).storeForType(OntapCluster);
    final clusterIds = clusterStore.idsSorted;
    final clusterCount = clusterStore.itemCount;
    //
    if (clusterCount == 0) {
      return Card(
        child: ListTile(
          title: Text('Add an ONTAP cluster'),
          trailing: Icon(Icons.add),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                final newCluster = OntapCluster();
                return ChangeNotifierProvider.value(
                  value: newCluster,
                  builder: (_, __) => OntapClusterEditPage(),
                );
              },
            ),
          ),
        ),
      );
    }
    //
    return ListView.builder(
      itemCount: clusterCount,
      itemBuilder: (context, index) {
        final id = clusterIds[index];
        return Dismissible(
          key: ValueKey(id),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.delete_sweep, color: Colors.white),
            alignment: Alignment.centerRight,
            color: Colors.red,
          ),
          onDismissed: (direction) => clusterStore.deleteForId(id),
          child: ChangeNotifierProvider.value(
            value: clusterStore.forId(id),
            builder: (_, __) => OntapClusterCard(),
          ),
        );
      },
    );
  }
}
