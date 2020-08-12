//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_port.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_port_state.dart';
import 'package:provider/provider.dart';

class ApiOntapStoragePortCard extends StatelessWidget {
  ApiOntapStoragePortCard({
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
  // Select the port-state icon
  final List<IconData> _portStateIconList = [Icons.ac_unit];
  IconData get _portStateIcon => _portStateIconList.first;
  set _portStateIcon(IconData icon) => _portStateIconList[0] = icon;
  //
  final List<Color> _portStateColorList = [Colors.green];
  Color get _portStateColor => _portStateColorList.first;
  set _portStateColor(Color color) => _portStateColorList[0] = color;
  //

  void _portState(BuildContext context, ApiOntapStoragePort port) {
    if (port.state == null) {
      _portStateIcon = Icons.help;
      _portStateColor = Theme.of(context).buttonColor;
      return;
    }
    // non-null cases
    switch (port.state) {
      case ApiOntapStoragePortState.online:
        _portStateIcon = FontAwesomeIcons.plug;
        _portStateColor = Colors.green;
        return;
      case ApiOntapStoragePortState.offline:
        _portStateIcon = Icons.offline_bolt;
        _portStateColor = Theme.of(context).disabledColor;
        return;
      case ApiOntapStoragePortState.error:
        _portStateIcon = Icons.warning;
        _portStateColor = Colors.red;
        return;
      // default:
      //   _portStateIcon = Icons.warning;
      //   _portStateColor = Theme.of(context).iconTheme.color;
      //   return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ports = Provider.of<List<ApiOntapStoragePort>>(context);
    if (ports == null || ports.isEmpty)
      return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = ports.first.lastUpdated;
    return Card(
        child: ExpansionTile(
      key: PageStorageKey('Storage Ports'),
      leading: ShowApiResultsButton(),
      title: Text('Storage Ports (${ports.length})'),
      subtitle: Text(
        'Last updated: ' + lastUpdated.toString().substring(0, 19),
      ),
      children: [
        ...ports.map(
          (port) {
            _portState(context, port);
            return ExpansionTile(
              key: PageStorageKey(port.node.name + ': ' + port.name),
              leading: FaIcon(_portStateIcon, color: _portStateColor),
              title: Text((port?.node?.name ?? '') + ': ' + port.name),
              subtitle: Text(port?.wwn ?? ''),
              children: [
                ListTile(
                  title: Text(port.description),
                  subtitle: Text('Description'),
                ),
                if (port.speed != null)
                  ListTile(
                    title: Text('${port.speed} Gbps'),
                    subtitle: Text('Port speed'),
                  ),
                ListTile(
                  title: Text(port.state.name),
                  subtitle: Text('Port state'),
                ),
              ],
            );
          },
        ),
        RefreshResultsTile(toRefresh: toRefresh),
      ],
    ));
    //
  }
}
