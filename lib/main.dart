//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:ontap_monitor/builtins/store_setup.dart';
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
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        // create the main store-of-stores
        final superStore = SuperStore();
        // populate it with the initial/builtin stores & items
        StoreSetup.shared(superStore: superStore);
        return superStore;
      },
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ONTAP Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: Splash(
            seconds: 3,
            photoSize: 200.0,
            navigateAfterSeconds: OntapClusterPage(),
            image: Image.asset('images/logo-here.jpg'),
            title: Text(
              'ONTAP REST API Demo',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            loadingText: Text('App loading...'),
          ),
        ),
      ),
    );
  }
}
