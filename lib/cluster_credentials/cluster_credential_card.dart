import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_edit_page.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:provider/provider.dart';

class ClusterCredentialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credential = Provider.of<ClusterCredentials>(context);
    return Card(
      child: ListTile(
        title: Text(credential.name),
        subtitle: Text(credential.userName),
        trailing: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
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
