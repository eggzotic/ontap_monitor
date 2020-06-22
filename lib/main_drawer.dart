import 'package:flutter/material.dart';
import 'package:ontap_monitor/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About Ontap Monitor'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutOntapMonitor(),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Manage Credentials'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => ClusterCredentialPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            // leading: Icon(Icons.offline_bolt),
            leading: Icon(Icons.directions_run),
            title: Text('Manage Actions'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OntapActionPage()),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
