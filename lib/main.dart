import 'package:flutter/material.dart';
// import 'package:ontap_monitor/cluster_credential_page.dart';
import 'package:ontap_monitor/cluster_credential_store.dart';
import 'package:ontap_monitor/ontap_cluster_page.dart';
import 'package:ontap_monitor/ontap_cluster_store.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ClusterCredentialStore()),
        ChangeNotifierProvider(create: (context) => OntapClusterStore()),
      ],
      child: MaterialApp(
        title: 'ONTAP Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: ClusterCredentialPage(),
        home: OntapClusterPage(),
      ),
    );
  }
}
