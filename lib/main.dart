import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_page.dart';
import 'package:provider/provider.dart';

// this is required when working with self-signed certs, such as an
//  out-of-the-box ONTAP system will have. Based on the final solution by pepie
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
    return ChangeNotifierProvider(
      create: (_) => SuperStore(),
      builder: (_, __) => MaterialApp(
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
