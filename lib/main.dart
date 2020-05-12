import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OntapCluster.fake(),
      builder: (context, _) => MaterialApp(
        title: 'ONTAP Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ClusterInfo(title: 'ONTAP REST Demo'),
      ),
    );
  }
}

class ClusterInfo extends StatelessWidget {
  ClusterInfo({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              cluster.name,
            ),
            Text(
              cluster.uuid,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class Clusters with ChangeNotifier {
  List<OntapCluster> _all;
  void addCluster(OntapCluster cluster) {
    if (clusterExists(cluster)) return;
    _all.add(cluster);
  }
  //
  bool clusterExists(OntapCluster cluster) {
    return _all.map((e) => e.uuid).toList().contains(cluster.uuid);
  }
}

class OntapCluster {
  final String uuid;
  String name;
  String version;

  // Constructor
  OntapCluster._private(this.uuid, this.name, this.version);

  factory OntapCluster.fromMap(Map<String, dynamic> json) {
    final String uuid = json['uuid'];
    if (uuid == null) return null;
    final String name = json['name'] ?? 'Unknown';
    final String version = jsonDecode(json['version'])['full'];
    //
    return OntapCluster._private(uuid, name, version);
  }

  factory OntapCluster.fake() {
    return OntapCluster.fromMap({
      'name': 'unknown-name',
      'uuid': 'unknown-uuid',
      'version': '{ "full" : "Unknown version"}'
    });
  }
}
