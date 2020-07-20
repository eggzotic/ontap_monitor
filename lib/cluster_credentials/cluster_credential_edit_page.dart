import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_edit_ui.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:provider/provider.dart';

class ClusterCredentialEditPage extends StatelessWidget {
  final String credentialId;
  ClusterCredentialEditPage({
    Key key,
    this.credentialId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemStore<ClusterCredentials> credentialStore =
        Provider.of<SuperStore>(context).storeForType(ClusterCredentials);
    final add = credentialId == null;
    final credential = add
        ? Provider.of<ClusterCredentials>(context)
        : credentialStore.forId(credentialId);
    return Scaffold(
      appBar: AppBar(
        title: Text(add ? 'Create Credentials' : 'Edit Credentials'),
        leading: IconButton(
          icon: Icon(Icons.done),
          onPressed: !credential.isValid
              ? null
              : () {
                  if (add) credentialStore.add(credential);
                  Navigator.of(context).pop();
                },
        ),
        actions: [
          if (add)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
        ],
      ),
      body:
          // edge case where the credential might have been deleted while this
          //  screen is open
          credentialId != null && !credentialStore.existsForId(credentialId)
              ? Center(
                  child: Column(
                    children: [
                      Text('Cannot find Credentials'),
                      RaisedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                )
              // main case where we're editing an existing, or creating a new,
              //  set of credentials
              : ChangeNotifierProvider.value(
                  value: credential,
                  builder: (_, __) => ClusterCredentialEditUi(),
                ),
    );
  }
}
