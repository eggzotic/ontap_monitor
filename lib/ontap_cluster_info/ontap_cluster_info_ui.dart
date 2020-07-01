import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
import 'package:provider/provider.dart';

//
class OntapClusterInfoUi extends StatelessWidget {
  OntapClusterInfoUi({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);
  final void Function() toRefresh;
  @override
  Widget build(BuildContext context) {
    final apiOntapCluster = Provider.of<ApiOntapCluster>(context);

    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text('Cluster Info'),
        children: [
          ListTile(title: Text(apiOntapCluster.name), subtitle: Text('Name')),
          ListTile(
              title: Text(apiOntapCluster.location),
              subtitle: Text('Location')),
          ListTile(
            title: Text(apiOntapCluster.version.full),
            subtitle: Text('Version'),
          ),
          ListTile(title: Text(apiOntapCluster.uuid), subtitle: Text('UUID')),
          ListTile(
            title: Text(apiOntapCluster.lastConnected
                .toIso8601String()
                .substring(0, 19)),
            subtitle: Text('Last updated'),
            trailing: Icon(
              Icons.refresh,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => toRefresh(),
          ),
        ],
      ),
    );
  }
}
