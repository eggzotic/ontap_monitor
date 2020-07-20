import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_disk_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_container_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';

import 'package:provider/provider.dart';

//
class ApiOntapStorageDisksCard extends StatelessWidget {
  ApiOntapStorageDisksCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  static const gigabyte = 1024 * 1024 * 1024;
  //
  // Select the disk-state icon
  final List<IconData> _diskStateIconList = [Icons.ac_unit];
  IconData get _diskStateIcon => _diskStateIconList.first;
  set _diskStateIcon(IconData icon) => _diskStateIconList[0] = icon;
  //
  final List<Color> _diskStateColorList = [Colors.green];
  Color get _diskStateColor => _diskStateColorList.first;
  set _diskStateColor(Color color) => _diskStateColorList[0] = color;
  //
  void _diskState(BuildContext context, ApiOntapStorageDisk disk) {
    if (disk.state == null) {
      _diskStateIcon = Icons.help;
      _diskStateColor = Theme.of(context).buttonColor;
      return;
    }
    // non-null cases
    switch (disk.state) {
      case ApiOntapDiskState.present:
        _diskStateIcon = Icons.check;
        _diskStateColor = Colors.green;
        return;
      case ApiOntapDiskState.broken:
        // _diskStateIcon = Icons.mood_bad;
        _diskStateIcon = Icons.sentiment_very_dissatisfied;
        _diskStateColor = Colors.red;
        return;
      case ApiOntapDiskState.spare:
        _diskStateIcon = Icons.more_horiz;
        _diskStateColor = Colors.blue;
        return;
      case ApiOntapDiskState.zeroing:
        _diskStateIcon = Icons.threesixty;
        _diskStateColor = Colors.blue;
        return;
      case ApiOntapDiskState.maintenance:
        _diskStateIcon = Icons.group_work;
        _diskStateColor = Theme.of(context).iconTheme.color;
        return;
      case ApiOntapDiskState.reconstructing:
        _diskStateIcon = Icons.healing;
        _diskStateColor = Colors.orange;
        return;
      default:
        _diskStateIcon = Icons.warning;
        _diskStateColor = Theme.of(context).iconTheme.color;
        return;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final disks = Provider.of<List<ApiOntapStorageDisk>>(context);
    if (disks == null || disks.isEmpty)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );
    final lastUpdated = disks.first.lastUpdated;
    return Card(
        child: ExpansionTile(
      key: PageStorageKey('Disks'),
      title: Text('Disks (${disks.length})'),
      subtitle: Text(
        'Last updated: ' + lastUpdated.toString().substring(0, 19),
      ),
      children: [
        ...disks.map(
          (disk) {
            _diskState(context, disk);
            return ExpansionTile(
              key: PageStorageKey(disk.name),
              leading: Icon(_diskStateIcon, color: _diskStateColor),
              title: Text(disk.name),
              subtitle: Text(disk.node?.name ?? 'unassigned'),
              children: [
                ListTile(
                  title: Text(disk.vendor),
                  subtitle: Text('Vendor'),
                ),
                ListTile(
                  title: Text(disk.type.name),
                  subtitle: Text('Type'),
                ),
                ListTile(
                  title: Text(
                    disk.containerType == ApiOntapStorageContainerType.aggregate
                        ? (disk.aggregates
                            .map((a) => a.name)
                            .toList()
                            .join(', '))
                        : disk.containerType.name,
                  ),
                  subtitle: Text(disk.containerType ==
                          ApiOntapStorageContainerType.aggregate
                      ? 'Aggregate'
                      : 'Container type'),
                ),
                ListTile(
                  title: Text(disk.model),
                  subtitle: Text('Model'),
                ),
                ListTile(
                  title: Text(disk.usableSize != null
                      ? ((disk.usableSize / gigabyte).ceil().toString() + ' GB')
                      : '-'),
                  subtitle: Text('Usable Size'),
                ),
                ListTile(
                  title: Text(
                      (disk.shelf?.name ?? '-') + ' : ' + disk.bay.toString()),
                  subtitle: Text('Shelf : Bay'),
                ),
                // ListTile(
                //   title: Text(''), subtitle: Text(''),
                // ),
                // ListTile(
                //   title: Text(''), subtitle: Text(''),
                // ),
              ],
            );
          },
        ),
        RefreshResultsTile(toRefresh: toRefresh),
      ],
    ));
  }
}
