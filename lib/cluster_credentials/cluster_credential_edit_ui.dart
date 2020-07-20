import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:provider/provider.dart';

class ClusterCredentialEditUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credential = Provider.of<ClusterCredentials>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: credential.name,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Credential Name'),
            onChanged: (newName) => credential.setName(newName),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: credential.description,
            readOnly: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (newDescription) =>
                credential.setDescription(newDescription),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: credential.userName,
            readOnly: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'User Name'),
            onChanged: (newUser) => credential.setUserName(newUser),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: credential.passwordMasked,
            readOnly: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Password'),
            onChanged: (newPass) => credential.setPassword(newPass),
          ),
        ),
      ],
    );
  }
}
