import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_state.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port_type.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';
import 'package:provider/provider.dart';

class OntapClusterNetworkEthernetPortsCard extends StatelessWidget {
  OntapClusterNetworkEthernetPortsCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  @override
  Widget build(BuildContext context) {
    final ports = Provider.of<List<ApiOntapNetworkEthernetPort>>(context);
    if (ports == null || ports.isEmpty)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );
    final lastUpdated = ports.first.lastUpdated;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Ethernet Ports'),
        title: Text('Ethernet Ports (${ports.length})'),
        subtitle: Text(
          'Last updated: ' + lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ...ports.map(
                (port) => ExpansionTile(
                  key: PageStorageKey(port.node.name + ': ' + port.name),
                  leading: port.state == ApiOntapNetworkEthernetPortState.up
                      ? Icon(Icons.check, color: Colors.green)
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
