import 'package:flutter/material.dart';
import 'package:ontap_monitor/api_request_state.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_response.dart';
import 'package:ontap_monitor/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_licensing_ui.dart';
import 'package:ontap_monitor/ontap_cluster_info/ontap_cluster_info_ui.dart';
import 'package:provider/provider.dart';

class OntapClusterActionCard<T extends DataItem> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapClusterActionCard build for $T');
    final credentialStore = Provider.of<DataStore<ClusterCredentials>>(context);
    final cluster = Provider.of<OntapCluster>(context);
    final action = Provider.of<OntapAction>(context);
    final apiModelStore = Provider.of<DataStore<T>>(context);
    final cachedId = cluster.cachedResultIdFor(action.id);
    final cachedItem = apiModelStore.forId(cachedId);
    final isCached = cachedItem != null;
    print('Result is cached: $isCached');
    final reporter = Provider.of<OntapApiReporter<T>>(context);
    final cred = credentialStore.forId(cluster.credentialsId);
    final toRun = () {
      action.execute(
        host: cluster.adminLifAddress,
        credentials: cred,
        reporter: reporter,
      );
    };
    return !isCached &&
            (reporter.status == ApiRequestState.started ||
                reporter.status == ApiRequestState.notStarted)
        ? Card(
            child: ListTile(
              title: Text(action.name),
              trailing: reporter.status == ApiRequestState.started
                  ? CircularProgressIndicator()
                  : Icon(
                      Icons.directions_run,
                      color: Theme.of(context).accentColor,
                    ),
              onTap: () {
                // if the cluster does not have a valid set of credentials
                //  assigned, we take the user to the define-creds screen
                if (cred == null) {
                  print('Creds required');
                  cluster.setCredentialsRequired(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          OntapClusterEditPage(clusterId: cluster.id),
                    ),
                  );
                  return;
                }
                try {
                  toRun();
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
          )
        : ChangeNotifierProvider.value(
            value: cachedItem ?? reporter.responseObject,
            // ***RLS*** need to have corresponding UI pages to show for the different actions/api-models?
            builder: (_, __) {
              switch (action.api.responseModel) {
                case ApiOntapCluster:
                  return OntapClusterInfoUi(toRefresh: toRun);
                case ApiOntapLicenseResponse:
                  return OntapClusterLicensingUi(toRefresh: toRun);
                default:
                  return Center(
                    child: Text('Unknown Action Card for API ${action.api.id}'),
                  );
              }
            },
            // builder: (_, __) => OntapClusterLicensingUi(toRefresh: toRun),
          );
  }
}
