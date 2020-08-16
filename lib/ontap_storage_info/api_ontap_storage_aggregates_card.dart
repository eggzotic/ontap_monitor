//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/misc/branded_widget.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_class.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_block_storage_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_raid_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_state.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:provider/provider.dart';

class ApiOntapStorageAggregatesCard extends StatelessWidget {
  ApiOntapStorageAggregatesCard({
    Key key,
    @required this.toRefresh,
    @required this.toReset,
  }) : super(key: key);
  //
  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;

  /// [toReset] is a callback that should reset any previous error condition
  ///  which should trigger the tile to be reset to it's original state, ready
  ///  for a re-run
  final void Function() toReset;
  //
  static const gigabyte = 1024 * 1024 * 1024;

  //
  // Select the disk-state icon
  final List<IconData> _aggrStateIconList = [Icons.ac_unit];
  IconData get _aggrStateIcon => _aggrStateIconList.first;
  set _aggrStateIcon(IconData icon) => _aggrStateIconList[0] = icon;
  //
  final List<Color> _aggrStateColorList = [Colors.green];
  Color get _aggrStateColor => _aggrStateColorList.first;
  set _aggrStateColor(Color color) => _aggrStateColorList[0] = color;
  //
  void _aggrState(BuildContext context, ApiOntapStorageAggregate aggr) {
    if (aggr.state == null) {
      _aggrStateIcon = Icons.help;
      _aggrStateColor = Theme.of(context).buttonColor;
      return;
    }
    // non-null cases
    switch (aggr.state) {
      case ApiOntapStorageAggregateState.online:
        _aggrStateIcon = Icons.check;
        _aggrStateColor = Colors.green;
        return;
      case ApiOntapStorageAggregateState.failed:
        _aggrStateIcon = Icons.sentiment_very_dissatisfied;
        _aggrStateColor = Colors.red;
        return;
      case ApiOntapStorageAggregateState.onlining:
        _aggrStateIcon = Icons.more_horiz;
        _aggrStateColor = Colors.blue;
        return;
      case ApiOntapStorageAggregateState.inconsistent:
      case ApiOntapStorageAggregateState.offline:
        _aggrStateIcon = Icons.block;
        _aggrStateColor = Colors.orange;
        return;
      case ApiOntapStorageAggregateState.restricted:
        _aggrStateIcon = Icons.group_work;
        _aggrStateColor = Colors.orange;
        return;
      default:
        _aggrStateIcon = Icons.warning;
        _aggrStateColor = Theme.of(context).iconTheme.color;
        return;
    }
  }

  String _toGb(int bytes) =>
      bytes == null ? '' : ((bytes / gigabyte).round().toString() + ' GiB');

  //
  @override
  Widget build(BuildContext context) {
    final aggrs = Provider.of<List<ApiOntapStorageAggregate>>(context);
    if (aggrs == null || aggrs.isEmpty)
      return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = aggrs.first.lastUpdated;
    return Card(
      child: BrandedWidget(
        child: ExpansionTile(
          key: PageStorageKey('Aggregates'),
          leading: ShowApiResultsButton(),
          title: Text('Aggregates (${aggrs.length})'),
          subtitle: Text(
            'Last updated: ' + lastUpdated.toString().substring(0, 19),
          ),
          children: [
            ...aggrs.map(
              (aggr) {
                _aggrState(context, aggr);
                return ExpansionTile(
                  key: PageStorageKey(aggr.name),
                  leading: Icon(
                    _aggrStateIcon,
                    color: _aggrStateColor,
                  ),
                  title: Text(
                    aggr.name +
                        ' ' +
                        (aggr?.space?.blockStorage?.size != null
                            ? ('  ' +
                                _toGb(aggr.space.blockStorage.size).toString())
                            : ''),
                  ),
                  subtitle: Text(aggr.node?.name != null ? aggr.node.name : ''),
                  children: [
                    if (aggr?.space?.blockStorage?.available != null)
                      ListTile(
                        title: Text(_toGb(aggr.space.blockStorage.available) +
                            ' / ' +
                            _toGb(aggr.space.blockStorage.size).toString() +
                            ' / ' +
                            ((100 *
                                        aggr.space.blockStorage.used /
                                        aggr.space.blockStorage.size)
                                    .round()
                                    .toString() +
                                '%')),
                        subtitle: Text('Available / Size / Used %'),
                      ),
                    ListTile(
                      title: Text(aggr?.state?.name ?? 'unknown'),
                      subtitle: Text('State'),
                    ),
                    if (aggr.blockStorage?.primary?.raidType?.name != null)
                      ListTile(
                        title: Text(
                          aggr.blockStorage.primary.raidType.name +
                              ' / ' +
                              aggr.blockStorage.primary.raidSize.toString(),
                        ),
                        subtitle: Text('RAID type / size'),
                      ),
                    if (aggr.blockStorage?.primary?.diskCount != null)
                      ListTile(
                        title: Text(
                          aggr.blockStorage.primary.diskCount.toString() +
                              ' / ' +
                              aggr.blockStorage.primary.diskType.name +
                              ' / ' +
                              aggr.blockStorage.primary.diskClass.name,
                        ),
                        subtitle: Text('Disk count / type / class'),
                      ),
                    // ListTile(
                    //   title: Text(),
                    //   subtitle: Text(''),
                    // ),
                  ],
                );
              },
            ),
            RefreshResultsTile(toRefresh: toRefresh),
          ],
        ),
      ),
    );
  }
}
