import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/main_drawer.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_list_ui.dart';
import 'package:provider/provider.dart';

class OntapClusterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clusterCount =
        Provider.of<SuperStore>(context).storeForType(OntapCluster).itemCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clusters ($clusterCount)'),
        actions: [
          // a '+' button to launch the "add cluster" page
          if (clusterCount > 0)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  final newCluster = OntapCluster();
                  return ChangeNotifierProvider.value(
                    value: newCluster,
                    builder: (_, __) => OntapClusterEditPage(),
                  );
                }),
              ),
            ),
        ],
      ),
      drawer: MainDrawer(),
      body: OntapClusterListUi(),
    );
  }
}
