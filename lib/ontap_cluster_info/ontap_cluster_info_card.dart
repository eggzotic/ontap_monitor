import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';
import 'package:provider/provider.dart';

//
class OntapClusterInfoCard extends StatelessWidget {
  OntapClusterInfoCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  @override
  Widget build(BuildContext context) {
    final apiOntapCluster = Provider.of<List<ApiOntapCluster>>(context).first;
    if (apiOntapCluster == null)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Info'),
        title: Text('Cluster Info (${apiOntapCluster.name})'),
        subtitle: Text(
          'Last updated: ' +
              apiOntapCluster.lastUpdated.toString().substring(0, 19),
        ),
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
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
