import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_card.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_edit_page.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:provider/provider.dart';

class ClusterCredentialListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemStore<ClusterCredentials> credentialStore =
        Provider.of<SuperStore>(context).storeForType(ClusterCredentials);
    final credentialIds = credentialStore.idsSorted;
    final credentialCount = credentialStore.itemCount;
    //
    if (credentialCount == 0) {
      return Card(
        child: ListTile(
          title: Text('Create some credentials'),
          trailing: Icon(Icons.add),
          onTap: () => Navigator.of(context).push(
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
      );
    }
    //
    return ListView.builder(
      itemCount: credentialCount,
      itemBuilder: (context, index) {
        final id = credentialIds[index];
        return Dismissible(
          key: ValueKey(id),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.delete_sweep, color: Colors.white),
            alignment: Alignment.centerRight,
            color: Colors.red,
          ),
          onDismissed: (direction) => credentialStore.deleteForId(id),
          child: ChangeNotifierProvider.value(
            value: credentialStore.forId(id),
            builder: (_, __) => ClusterCredentialCard(),
          ),
        );
      },
    );
  }
}
