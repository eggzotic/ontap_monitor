import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_edit_page.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';

class ClusterSelectCredentialsUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credentialStore = Provider.of<DataStore<ClusterCredentials>>(context);
    final cluster = Provider.of<OntapCluster>(context);

    return DropdownButton<String>(
      // if there's a stale credential ID (e.g. one that's since been deleted),
      //  then use ''
      value: credentialStore.existsForId(cluster.credentialsId)
          ? cluster.credentialsId
          : '',
      iconEnabledColor: Theme.of(context).accentColor,
      onChanged: (id) {
        // selected the "Create new credentials"
        if (id.isEmpty) {
          final newCredential = ClusterCredentials();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ChangeNotifierProvider.value(
                  value: newCredential,
                  builder: (_, __) => ClusterCredentialEditPage(),
                );
              },
            ),
          ).then(
            (_) {
              final newCredentialId = newCredential.id;
              if (credentialStore.existsForId(newCredentialId))
                cluster.setCredentialsId(newCredentialId);
            },
          );
          return;
        }
        // regular "selected an existing credentials"
        cluster.setCredentialsId(id);
      },
      items: [
            DropdownMenuItem(
              key: ValueKey(''),
              child: Text('Create new credentials...'),
              value: '',
            ),
          ] +
          credentialStore.idsSorted.map(
            (id) {
              final credential = credentialStore.forId(id);
              return DropdownMenuItem(
                key: ValueKey(id),
                value: id,
                child: Text(credential.name),
              );
            },
          ).toList(),
    );
  }
}
