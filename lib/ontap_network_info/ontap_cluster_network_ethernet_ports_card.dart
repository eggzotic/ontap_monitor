//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_state.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_type.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:provider/provider.dart';

class OntapClusterNetworkEthernetPortsCard extends StatelessWidget {
  OntapClusterNetworkEthernetPortsCard({
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
    final ports = Provider.of<List<ApiOntapNetworkEthernetPort>>(context);
    if (ports == null || ports.isEmpty)
      return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = ports.first.lastUpdated;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Ethernet Ports'),
        leading: ShowApiResultsButton(),
        title: Text('Ethernet Ports (${ports.length})'),
        subtitle: Text(
          'Last updated: ' + lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ...ports.map(
            (port) => ExpansionTile(
              key: PageStorageKey(port.node.name + ': ' + port.name),
              leading: port.state == ApiOntapNetworkEthernetPortState.up
                  ? Icon(FontAwesomeIcons.networkWired, color: Colors.green)
                  : Icon(Icons.warning, color: Colors.red),
              title: Text(port.node.name + ': ' + port.name),
              subtitle: Text(port.macAddress ?? 'unknown'),
              children: [
                ListTile(
                  title: Text(port.type?.name ?? 'unknown'),
                  subtitle: Text('Port type'),
                ),
                ListTile(
                  title: Text((port.enabled ? 'up' : 'down') +
                      ' / ' +
                      (port.state?.name ?? 'unknown')),
                  subtitle: Text('Admin / Operational state'),
                ),
                ListTile(
                  title: Text((port.speed ?? '-') + ' Mbps'),
                  subtitle: Text('Operational speed'),
                ),
                ListTile(
                  title: Text(port.mtu.toString() + ' bytes'),
                  subtitle: Text('Port MTU'),
                ),
                ListTile(
                  title: Text(port.broadcastDomain.ipspace.name +
                      ' / ' +
                      port.broadcastDomain?.name),
                  subtitle: Text('IPspace / Broadcast domain'),
                ),
              ],
            ),
          ),
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
