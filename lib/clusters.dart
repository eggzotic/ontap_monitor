import 'package:flutter/cupertino.dart';
import 'package:ontap_monitor/ontap_cluster.dart';

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