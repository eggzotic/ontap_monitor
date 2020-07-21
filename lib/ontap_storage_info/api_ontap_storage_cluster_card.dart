import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';
import 'package:provider/provider.dart';

//
class ApiOntapStorageClusterCard extends StatelessWidget {
  ApiOntapStorageClusterCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  static const gigabyte = 1024 * 1024 * 1024;
  String _toGb(int bytes) =>
      bytes == null ? '' : ((bytes / gigabyte).round().toString() + ' GiB');

  //
  @override
  Widget build(BuildContext context) {
    final clusterStorage =
        Provider.of<List<ApiOntapStorageCluster>>(context).first;
    if (clusterStorage == null)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Storage Summary'),
        title: Text('Cluster Storage Summary'),
        subtitle: Text(
          'Last updated: ' +
              clusterStorage.lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ListTile(
            title: Text(
              clusterStorage.efficiency.ratio.toString() +
                  ' / ' +
                  _toGb(clusterStorage.efficiency.savings) +
                  ' / ' +
                  _toGb(clusterStorage.efficiency.logicalUsed),
            ),
            subtitle: Text('Efficiency ratio / savings / logical-used'),
          ),
          ListTile(
            title: Text(
              clusterStorage.efficiencyWithoutSnapshots.ratio.toString() +
                  ' / ' +
                  _toGb(clusterStorage.efficiencyWithoutSnapshots.savings) +
                  ' / ' +
                  _toGb(clusterStorage.efficiencyWithoutSnapshots.logicalUsed),
            ),
            isThreeLine: true,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('(without snapshots)'),
                Text('Efficiency ratio / savings / logical-used'),
              ],
            ),
          ),
          ExpansionTile(
              key: PageStorageKey('Block Storage Summary'),
              title: Text(
                _toGb(clusterStorage.blockStorage.size) +
                    ' / ' +
                    _toGb(clusterStorage.blockStorage.used) +
                    ' / ' +
                    _toGb(clusterStorage.blockStorage.inactiveData),
              ),
              subtitle: Text('Block Storage / used / inactive'),
              children: clusterStorage.blockStorage.medias
                  .map(
                    (media) => Column(mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(),
                        ListTile(
                          title: Text(
                              '${media.efficiency.ratio} / ${_toGb(media.efficiency.savings)} / ${_toGb(media.efficiency.logicalUsed)}'),
                          subtitle: Text(media.type.toUpperCase() +
                              ' Efficiency ratio / savings / logical-used'),
                        ),
                        ListTile(
                          title: Text(
                              '${_toGb(media.size)} / ${_toGb(media.used)} / ${_toGb(media.available)}'),
                          subtitle: Text(media.type.toUpperCase() +
                              ' Size / used / available'),
                        ),
                      ],
                    ),
                  )
                  .toList()),
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
