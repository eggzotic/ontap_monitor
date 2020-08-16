//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/builtins/model_ui.dart';
import 'package:ontap_monitor/misc/branded_widget.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_error.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_status_code.dart';
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
import 'package:rest_client/rest_client.dart';

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
    // print('Cached $T IDs: $cachedIds');
    final cachedItems = apiModelStore.forIds(cachedIds.toList());
    final isCached = cachedIds != null && cachedIds.isNotEmpty;
    final reporter = Provider.of<OntapApiReporter<T>>(context);
    final cred = credentialStore.forId(cluster.credentialsId);
    final toRun = () async {
      try {
        await action.execute(
          host: cluster.adminLifAddress,
          credentials: cred,
          reporter: reporter,
        );
      } on RestException catch (e) {
        showDialog(
            context: context,
            builder: (context) {
              // try to find the specific error
              final charOne = e.response.body.toString().substring(0, 1);
              OntapApiError error;
              if (charOne == '{') {
                error = OntapApiError.fromMap(e.response.body['error']);
              }
              // just in case, find the generic error
              final code = e.response.statusCode;
              final status = OntapApiStatusCodeMembers.fromCode(code);
              // use the specific, otherwise the generic
              final message =
                  error?.message ?? '${status.name}: ${status.description}';
              return AlertDialog(
                title:
                    Text('Error', style: Theme.of(context).textTheme.headline6),
                content: Text('$message',
                    style: Theme.of(context).textTheme.bodyText1),
                actions: [
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              );
            });
      } catch (e) {
        // last resort error
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:
                  Text('Error', style: Theme.of(context).textTheme.headline6),
              content: Text('$e', style: Theme.of(context).textTheme.bodyText1),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    };
    final toReset = reporter.reset;
    return !isCached &&
            (reporter.status == ApiRequestState.started ||
                reporter.status == ApiRequestState.notStarted)
        ? Card(
            child: BrandedWidget(
              child: ListTile(
                leading: ChangeNotifierProvider.value(
                  value: action,
                  builder: (_, __) => ShowApiResultsButton(),
                ),
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
            ),
          )
        : MultiProvider(
            providers: [
              Provider.value(value: cachedItems ?? reporter.responseObject),
              Provider.value(value: reporter.status == ApiRequestState.started),
            ],
            child: ModelUi.shared.uiForModel(
              action.api.responseModel,
              toRefresh: toRun,
              toReset: toReset,
            ),
          );
  }
}
