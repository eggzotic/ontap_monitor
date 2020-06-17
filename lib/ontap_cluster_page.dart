import 'package:flutter/material.dart';
import 'package:ontap_monitor/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credential_page.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster_edit_page.dart';
import 'package:ontap_monitor/ontap_cluster_list_ui.dart';
import 'package:ontap_monitor/ontap_cluster_store.dart';
import 'package:provider/provider.dart';

class OntapClusterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clusterStore = Provider.of<OntapClusterStore>(context);
    final clusterCount = clusterStore.clusterCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clusters ($clusterCount)'),
        actions: [
          // a '+' button to launch the "add cluster" page
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
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Ontap Monitor'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AboutOntapMonitor()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock_outline),
              title: Text('Manage Credentials'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ClusterCredentialPage()),
                );
              },
            )
          ],
        ),
      ),
      body: OntapClusterListUi(),
    );
  }
}
