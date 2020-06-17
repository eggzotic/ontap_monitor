import 'package:flutter/material.dart';
import 'package:ontap_monitor/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credential_page.dart';

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
        ],
      ),
    );
  }
}
