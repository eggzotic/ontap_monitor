//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/misc/about_ontap_monitor.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_page.dart';
import 'package:ontap_monitor/misc/cache_info_clear_tile.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_page.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).accentColor;
    //
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline, color: iconColor),
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
            leading: Icon(Icons.lock_outline, color: iconColor),
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
            leading: Icon(Icons.directions_run, color: iconColor),
            title: Text('View Action List'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => OntapActionPage()),
              );
            },
          ),
          Divider(),
          CacheInfoClearTile(),
          Divider(),
        ],
      ),
    );
  }
}
