import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_response.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_page.dart';
import 'package:provider/provider.dart';

// this is required when working with self-signed certs, such as an
//  out-of-the-box ONTAP system will have based on the final solution by pepie
//  at https://github.com/flutter/flutter/issues/19588
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // here's we we hook it into our app
  HttpOverrides.global = new MyHttpOverrides();
  // and then run the app, as usual
  runApp(OntapMonitorApp());
}

class OntapMonitorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final datastore = DataStore<OntapApi>(
              // these are placeholder values since we're not using persistent stg
              itemFromMap: (map) => null,
              itemIdPrefix: '',
            );
            // add the builtin actions to the store here
            OntapApi.addBuiltins(datastore);
            return datastore;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => DataStore<ClusterCredentials>(
            itemFromMap: (map) => ClusterCredentials.fromMap(map),
            itemIdPrefix: ClusterCredentials.idPrefix,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) {
            final datastore = DataStore<OntapAction>(
              itemFromMap: (map) => OntapAction.fromMap(map),
              itemIdPrefix: OntapAction.idPrefix,
            );
            // add the builtin actions to the store here
            OntapAction.addBuiltins(datastore);
            // OntapAction.builinActions.forEach((action) {
            //   datastore.add(action, storeNow: false, neverStore: true);
            // });
            return datastore;
          },
        ),
        ChangeNotifierProvider(
          create: (_) => DataStore<OntapCluster>(
            itemFromMap: (map) => OntapCluster.fromMap(map),
            itemIdPrefix: OntapCluster.idPrefix,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DataStore<ApiOntapCluster>(
            itemFromMap: (map) => ApiOntapCluster.fromMap(map),
            itemIdPrefix: ApiOntapCluster.idPrefix,
            // include this for all cached-data stores - allows user to clear them
            isCacheData: true,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DataStore<ApiOntapLicenseResponse>(
            itemFromMap: (map) => ApiOntapLicenseResponse.fromMap(map),
            itemIdPrefix: ApiOntapLicenseResponse.idPrefix,
            // include this for all cached-data stores - allows user to clear them
            isCacheData: true,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'ONTAP Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OntapClusterPage(),
      ),
    );
  }
}
