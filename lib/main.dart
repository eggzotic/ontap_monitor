import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
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
