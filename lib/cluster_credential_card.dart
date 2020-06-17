import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credential_edit_page.dart';
import 'package:ontap_monitor/cluster_credentials.dart';
import 'package:provider/provider.dart';

class ClusterCredentialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CredentialCard build');
    final credential = Provider.of<ClusterCredentials>(context);
    return Card(
      child: ListTile(
        title: Text(credential.name),
        subtitle: Text(credential.userName),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ClusterCredentialEditPage(credentialId: credential.id),
            ),
          );
        },
      ),
    );
  }
}
