import 'package:flutter/material.dart';
import 'package:ontap_monitor/builtins/model_ui.dart';
import 'package:ontap_monitor/ontap_api_models/api_request_state.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';

class OntapClusterActionCard<T extends StorableItem> extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemStore<ClusterCredentials> credentialStore =
        Provider.of<SuperStore>(context).storeForType(ClusterCredentials);
    final cluster = Provider.of<OntapCluster>(context);
    final action = Provider.of<OntapAction>(context);
    final ItemStore<T> apiModelStore =
        Provider.of<SuperStore>(context).storeForType(T);
    final cachedIds = cluster.cachedResultIdsFor(action.id);
    print('Cached $T IDs: $cachedIds');
    final cachedItems = apiModelStore.forIds(cachedIds.toList());
    final isCached = cachedIds != null && cachedIds.isNotEmpty;
    final reporter = Provider.of<OntapApiReporter<T>>(context);
    final cred = credentialStore.forId(cluster.credentialsId);
    final toRun = () async {
      await action.execute(
        host: cluster.adminLifAddress,
        credentials: cred,
        reporter: reporter,
      );
    };
    final toReset = reporter.reset;
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
                //  assigned, we take the user to the define/associate-creds screen
                if (cred == null) {
                  cluster.setCredentialsRequired(true);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          OntapClusterEditPage(clusterId: cluster.id),
                    ),
                  );
                  return;
                }
                toRun();
              },
            ),
          )
        : MultiProvider(
            providers: [
              Provider.value(value: cachedItems ?? reporter.responseObject),
              Provider.value(value: reporter.status == ApiRequestState.started),
            ],
            child: ModelUi.shared().uiForModel(
              action.api.responseModel,
              toRefresh: toRun,
              toReset: toReset,
            ),
          );
  }
}
