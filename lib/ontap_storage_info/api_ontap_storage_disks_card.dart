//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_class.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_container_type.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

//
class ApiOntapStorageDisksCard extends StatelessWidget {
  ApiOntapStorageDisksCard({
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
  //
  // Select the disk-state icon & color
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
      case ApiOntapStorageDiskState.present:
        _diskStateIcon = FontAwesomeIcons.hdd;
        _diskStateColor = Colors.green;
        return;
      case ApiOntapStorageDiskState.broken:
        _diskStateIcon = Icons.sentiment_very_dissatisfied;
        _diskStateColor = Colors.red;
        return;
      case ApiOntapStorageDiskState.spare:
        _diskStateIcon = FontAwesomeIcons.wrench;
        _diskStateColor = Colors.blue;
        return;
      case ApiOntapStorageDiskState.zeroing:
        _diskStateIcon = Icons.threesixty;
        _diskStateColor = Colors.blue;
        return;
      case ApiOntapStorageDiskState.maintenance:
        _diskStateIcon = Icons.group_work;
        _diskStateColor = Theme.of(context).iconTheme.color;
        return;
      case ApiOntapStorageDiskState.reconstructing:
        _diskStateIcon = Icons.healing;
        _diskStateColor = Colors.orange;
        return;
      default:
        _diskStateIcon = Icons.warning;
        _diskStateColor = Theme.of(context).iconTheme.color;
        return;
    }
  }

  String _toGb(int bytes) => bytes == null
      ? ''
      : ('  ' + (bytes / gigabyte).round().toString() + ' GiB');

  //
  @override
  Widget build(BuildContext context) {
    final disks = Provider.of<List<ApiOntapStorageDisk>>(context);
    if (disks == null || disks.isEmpty)
      return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = disks.first.lastUpdated;
    //
    // final controller = Provider.of<ExpandedTileController>(context);
    return Card(
      child: ExpansionTile(
      // child: ExpandedTile(controller: controller,
        key: PageStorageKey('Disks'),
        leading: ShowApiResultsButton(),
        title: Text('Disks (${disks.length})'),
        // subtitle: Text(
        //   'Last updated: ' + lastUpdated.toString().substring(0, 19),
        // ),
        children: [
        // content: Container(
        //   child: Column(
        //     children: [
              ...disks.map(
                (disk) {
                  _diskState(context, disk);
                  return ExpansionTile(
                    key: PageStorageKey(disk.name),
                    leading: FaIcon(_diskStateIcon, color: _diskStateColor),
                    title: Text(disk.name + ' ' + _toGb(disk?.usableSize)),
                    subtitle: Text((disk.node?.name ?? 'unassigned') +
                        (disk.containerType ==
                                ApiOntapStorageContainerType.aggregate
                            ? (': ' +
                                (disk.aggregates
                                    .map((a) => a.name)
                                    .toList()
                                    .join(', ')))
                            : '')),
                    children: [
                      ListTile(
                        title: Text(disk.vendor),
                        subtitle: Text('Vendor'),
                      ),
                      if (disk.type?.name != null)
                        ListTile(
                          title: Text(
                              disk.type.name + ' / ' + disk.diskClass.name),
                          subtitle: Text('Disk type / class'),
                        ),
                      ListTile(
                        title: Text(disk.containerType.name),
                        subtitle: Text('Container type'),
                      ),
                      ListTile(
                        title: Text(disk.model),
                        subtitle: Text('Model'),
                      ),
                      ListTile(
                        title: Text(disk.usableSize != null
                            ? ((disk.usableSize / gigabyte).ceil().toString() +
                                ' GiB')
                            : '-'),
                        subtitle: Text('Usable Size'),
                      ),
                      ListTile(
                        title: Text((disk.shelf?.name ?? '-') +
                            ' / ' +
                            disk.bay.toString()),
                        subtitle: Text('Shelf / Bay'),
                      ),
                      // ListTile(
                      //   title: Text(''), subtitle: Text(''),
                      // ),
                    ],
                  );
                },
              ),
              RefreshResultsTile(toRefresh: toRefresh),
            ],
          ),
      //   ),
      // ),
    );
  }
}
