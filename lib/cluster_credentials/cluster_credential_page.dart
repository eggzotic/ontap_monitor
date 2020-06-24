import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_edit_page.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_list_ui.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_store.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:provider/provider.dart';

class ClusterCredentialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credentialStore = Provider.of<ClusterCredentialStore>(context);
    final credentialCount = credentialStore.credentialCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Credentials ($credentialCount)'),
        actions: [
          // a '+' button to launch the "create credential" page
          if (credentialCount > 0)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    final newCredential = ClusterCredentials();
                    return ChangeNotifierProvider.value(
                      value: newCredential,
                      builder: (_, __) => ClusterCredentialEditPage(),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      body: ClusterCredentialListUi(),
    );
  }
}
