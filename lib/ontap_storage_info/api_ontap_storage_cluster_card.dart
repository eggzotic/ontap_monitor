//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:provider/provider.dart';

//
class ApiOntapStorageClusterCard extends StatelessWidget {
  ApiOntapStorageClusterCard({
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
  static const gigabyte = 1024 * 1024 * 1024;
  String _toGb(int bytes) =>
      bytes == null ? '' : ((bytes / gigabyte).round().toString() + ' GiB');

  //
  @override
  Widget build(BuildContext context) {
    final resultList = Provider.of<List<ApiOntapStorageCluster>>(context);
    if (resultList.isEmpty) return NoResultsFoundTile(toReset: toReset);
    final clusterStorage = resultList.first;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Storage Summary'),
        leading: ShowApiResultsButton(),
        title: Text('Cluster Storage Summary'),
        subtitle: Text(
          'Last updated: ' +
              clusterStorage.lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ListTile(
            title: Text(
              clusterStorage.efficiency.ratio.toStringAsFixed(2) +
                  ' / ' +
                  _toGb(clusterStorage.efficiency.savings) +
                  ' / ' +
                  _toGb(clusterStorage.efficiency.logicalUsed),
            ),
            subtitle: Text('Efficiency ratio / savings / logical-used'),
          ),
          ListTile(
            title: Text(
              clusterStorage.efficiencyWithoutSnapshots.ratio
                      .toStringAsFixed(2) +
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
                    (media) => Column(
                      mainAxisSize: MainAxisSize.min,
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
