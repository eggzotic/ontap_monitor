//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:provider/provider.dart';

//
class OntapClusterInfoCard extends StatelessWidget {
  OntapClusterInfoCard({
    Key key,
    @required this.toRefresh,
    @required this.toReset,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;

  /// [toReset] is a callback that should reset any previous error condition
  ///  which should trigger the tile to be reset to it's original state, ready
  ///  for a re-run
  final void Function() toReset;
  //
  @override
  Widget build(BuildContext context) {
    final resultList = Provider.of<List<ApiOntapCluster>>(context);
    if (resultList.isEmpty) return NoResultsFoundTile(toReset: toReset);
    final apiOntapCluster = resultList.first;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Info'),
        leading: ShowApiResultsButton(),
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
