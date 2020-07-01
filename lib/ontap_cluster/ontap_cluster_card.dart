import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_actions_page.dart';
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
        trailing: Icon(
          Icons.chevron_right,
          color: Theme.of(context).accentColor,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider.value(
                      value: cluster,
                      child: OntapClusterActionsPage(),
                    )),
          );
        },
      ),
    );
  }
}
