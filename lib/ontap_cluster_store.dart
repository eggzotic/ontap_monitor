import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
import 'package:ontap_monitor/persistent_storage.dart';

class OntapClusterStore with ChangeNotifier {
  OntapClusterStore() {
    _load();
  }
  final _persistentStorage = PersistentStorage();
  // the main content, i.e. the cluster definitions
  Map<String, OntapCluster> _allClusters = {};
  // convenience getters
  int get clusterCount => _allClusters.length;
  List<String> get _ids => _allClusters.keys.toList();
  List<String> get idsSorted {
    final ids = _ids;
    ids.sort(_byName);
    return ids;
  }

  // helper for sorting credentials by name
  int _byName(String aId, String bId) {
    final aName = _allClusters[aId].name;
    final bName = _allClusters[bId].name;
    return aName.compareTo(bName);
  }

  //
  // fetch the cluster for a given ID
  OntapCluster forId(String id) => _allClusters[id];
  bool existsForId(String id) => _allClusters.containsKey(id);
  //
  // add a cluster
  void add(OntapCluster cluster, {bool store = true}) {
    final id = cluster.id;
    _allClusters[id] = cluster;
    print('After add, Store = $asJson');
    if (store) _persistentStorage.storeCluster(cluster);
    cluster.addListener(() {
      _persistentStorage.storeCluster(cluster);
    });
    notifyListeners();
  }

  //
  // remove a cluster
  void deleteForId(String id) {
    final deletedClus = _allClusters.remove(id);
    print('After delete, store = $asJson');
    deletedClus.removeListener(() {
      _persistentStorage.storeCluster(deletedClus);
    });
    _persistentStorage.deleteCluster(deletedClus);
    notifyListeners();
  }

  //
  List<Map<String, String>> get toMap => _allClusters.values.map((e) => e.toMap).toList();
  String get asJson => json.encode(toMap);
  //
  void _load() async {
    final loadedClusters = await _persistentStorage.loadClusters();
    loadedClusters.forEach((clus) => add(clus, store: false));
    notifyListeners();
  }
}
