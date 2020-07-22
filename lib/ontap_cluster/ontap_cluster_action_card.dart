import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_models/api_request_state.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_api/ontap_api_reporter.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:ontap_monitor/ontap_license_info/ontap_cluster_licensing_card.dart';
import 'package:ontap_monitor/ontap_network_info/ontap_cluster_network_ethernet_ports_card.dart';
import 'package:ontap_monitor/ontap_node_info/ontap_cluster_nodes_card.dart';
import 'package:ontap_monitor/ontap_cluster_info/ontap_cluster_info_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregates_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_card.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disks_card.dart';
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
            child: () {
              final model = action.api.responseModel;
              if (model == ApiOntapCluster)
                return OntapClusterInfoCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapLicensePackage)
                return OntapClusterLicensingCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapNode)
                return OntapClusterNodesCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapNetworkEthernetPort)
                return OntapClusterNetworkEthernetPortsCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapStorageDisk)
                return ApiOntapStorageDisksCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapStorageAggregate)
                return ApiOntapStorageAggregatesCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              if (model == ApiOntapStorageCluster)
                return ApiOntapStorageClusterCard(
                  toRefresh: toRun,
                  toReset: toReset,
                );
              return Center(
                child: Text('Unknown Action Card for API ${action.api.id}'),
              );
            }(),
            // ),
          );
  }
}
