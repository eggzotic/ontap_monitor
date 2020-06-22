import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credential_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';
import 'package:rest_client/rest_client.dart' as rc;

class OntapClusterActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapClusterActionCard build');
    final credentialStore = Provider.of<ClusterCredentialStore>(context);
    final cluster = Provider.of<OntapCluster>(context);
    final action = Provider.of<OntapAction>(context);

    if (action == null)
      return Center(
        child: CircularProgressIndicator(),
      );

    return Card(
      child: ListTile(
        title: Text(action.name),
        onTap: () async {
          final reporter = OntapApiReporter();
          final client = rc.Client(reporter: reporter);
          final url = Uri(
            scheme: 'https',
            host: cluster.adminLifAddress,
            path: action.path,
            // queryParameters: // need to put a Map here when query params are involved
          );
          final request = rc.Request(
            url: url.toString(),
            method: action.method.requestMethod,
          );
          final cred = credentialStore.forId(cluster.credentialsId);
          // if the cluster does not have a valid set of credentials assigned, we take the user to the define-creds screen
          if (cred == null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OntapClusterEditPage(clusterId: cluster.id),
              ),
            );
            return;
          }
          try {
            final response = await client.execute(
              request: request,
              authorizer: rc.BasicAuthorizer(
                username: cred.userName,
                password: cred.password,
              ),
            );
            final body = response.body;
            print('response body = $body');
          } catch (e) {
            print('Error occurred: $e');
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error',
                        style: Theme.of(context).textTheme.headline6),
                    content: Text('$e',
                        style: Theme.of(context).textTheme.bodyText1),
                    actions: [
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('OK'),
                      ),
                    ],
                  );
                });
            return;
          }
        },
      ),
    );
  }
}
