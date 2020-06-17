import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';

class OntapClusterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapClusterCard build');
    final cluster = Provider.of<OntapCluster>(context);
    return Card(
      child: ListTile(
        title: Text(cluster.name),
        subtitle: Text(cluster.adminLifAddress),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  OntapClusterEditPage(clusterId: cluster.id),
            ),
          );
        },
      ),
    );
  }
}