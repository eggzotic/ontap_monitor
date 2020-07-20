import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node_state.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';
import 'package:provider/provider.dart';

class OntapClusterNodesCard extends StatelessWidget {
  OntapClusterNodesCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);
  final void Function() toRefresh;
  //
  String _formattedDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inDays)} days $twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  } //

  @override
  Widget build(BuildContext context) {
    final nodes = Provider.of<List<ApiOntapNode>>(context);
    if (nodes == null || nodes.isEmpty)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );
    final lastUpdated = nodes.first.lastUpdated;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Nodes'),
        title: Text('Cluster Nodes (${nodes.length})'),
        subtitle: Text(
          'Last updated: ' + lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ...nodes.map(
            (node) => ExpansionTile(
              key: PageStorageKey(node.name),
              title: Text(node.name),
              leading: node.state == ApiOntapNodeState.up
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.warning, color: Colors.red),
              subtitle: Text(node.model ?? 'unknown'),
              children: [
                ListTile(
                  title: Text(node.serialNumber ?? 'unknown'),
                  subtitle: Text('Node serial #'),
                ),
                ListTile(
                  title: Text(node.version.full ?? 'unknown'),
                  subtitle: Text('Node software'),
                ),
                ListTile(
                  title: Text(node.uptime != null
                      ? _formattedDuration(Duration(seconds: node.uptime))
                      : 'unknown'),
                  subtitle: Text('Node uptime'),
                ),
                ListTile(
                  title: Text(node?.managementInterfaces?.first?.ip?.address ??
                      'unknown'),
                  subtitle: Text('Node management LIF'),
                ),
                ListTile(
                  title: Text(node.state.name),
                  subtitle: Text('Node state'),
                ),
                // ListTile(
                //   title: Text(''),
                //   subtitle: Text(''),
                // ),
              ],
            ),
          ),
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
