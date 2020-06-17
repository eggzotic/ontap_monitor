import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credential_card.dart';
import 'package:ontap_monitor/cluster_credential_store.dart';
import 'package:provider/provider.dart';

class ClusterCredentialListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final credentialStore = Provider.of<ClusterCredentialStore>(context);
    final credentialIds = credentialStore.idsSorted;
    final credentialCount = credentialStore.credentialCount;
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
