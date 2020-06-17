import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_select_credentials_ui.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
import 'package:provider/provider.dart';

//
class OntapClusterEditUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapClusterEditUi build');
    final cluster = Provider.of<OntapCluster>(context);
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.name,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Cluster Name'),
            onChanged: (newName) => cluster.setName(newName),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.description,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (newName) => cluster.setDescription(newName),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: cluster.adminLifAddress,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Admin LIF Address'),
            onChanged: (newName) => cluster.setAdminLifAddress(newName),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: ClusterSelectCredentialsUi()
        ),
      ],
    );
  }
}
