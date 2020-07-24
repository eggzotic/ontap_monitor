//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_actions_ui.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cluster - ${cluster.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OntapClusterEditPage(clusterId: cluster.id),
              ),
            ),
          ),
        ],
      ),
      body: OntapClusterActionsUi(),
    );
  }
}
