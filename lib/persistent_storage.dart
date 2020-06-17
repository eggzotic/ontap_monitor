//
import 'package:ontap_monitor/cluster_credentials.dart';
import 'package:ontap_monitor/ontap_cluster.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentStorage {
  // for identifying serialized instances on persistent-storage
  static const _clusterCredentialIdPrefix = 'cluster-credential_';
  static const _ontapClusterIdPrefix = 'ontap-cluster_';

  //
  Future<List<ClusterCredentials>> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load the relevant keys
    final ids = prefs.getKeys();
    print('loadCredentials: Found ${ids.length} keys');
    final prefLen = _clusterCredentialIdPrefix.length;
    final credentialIds = ids.where((element) => element.substring(0, prefLen) == _clusterCredentialIdPrefix);

    return credentialIds.map((key) {
      final cred = ClusterCredentials.fromJson(prefs.getString(key));
      print('Loaded credential: $cred');
      return cred;
    }).toList();
  }

  //
  void storeCredential(ClusterCredentials credential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Storing credential ${credential.asJson}');
    prefs.setString(_clusterCredentialIdPrefix + credential.id, credential.asJson);
  }

  //
  void deleteCredential(ClusterCredentials credential) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Removing credential ${credential.asJson}');
    prefs.remove(_clusterCredentialIdPrefix + credential.id);
  }

  //
  Future<List<OntapCluster>> loadClusters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ids = prefs.getKeys();
    print('loadClusters: Found ${ids.length} keys');
    final prefLen = _ontapClusterIdPrefix.length;
    final clusterIds = ids.where((id) => id.substring(0, prefLen) == _ontapClusterIdPrefix);
    return clusterIds.map((key) {
      final clus = OntapCluster.fromJson(prefs.getString(key));
      print('Loaded cluster: $clus');
      return clus;
    }).toList();
  }

  //
  void storeCluster(OntapCluster cluster) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Storing cluster ${cluster.asJson}');
    prefs.setString(_ontapClusterIdPrefix + cluster.id, cluster.asJson);
  }

  //
  void deleteCluster(OntapCluster cluster) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Removing cluster ${cluster.asJson}');
    prefs.remove(_ontapClusterIdPrefix + cluster.id);
  }
}
