import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster_card.dart';
import 'package:ontap_monitor/ontap_cluster_store.dart';
import 'package:provider/provider.dart';

class OntapClusterListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clusterStore = Provider.of<OntapClusterStore>(context);
    final clusterIds = clusterStore.idsSorted;
    final clusterCount = clusterStore.clusterCount;
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
