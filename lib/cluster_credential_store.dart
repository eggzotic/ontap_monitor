//
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/cluster_credentials.dart';
import 'package:ontap_monitor/persistent_storage.dart';

class ClusterCredentialStore with ChangeNotifier {
  ClusterCredentialStore() {
    _load();
  }
  final _persistentStorage = PersistentStorage();
  // the real content, i.e. the credentials
  Map<String, ClusterCredentials> _allCredentials = {};
  // convenience getters
  int get credentialCount => _allCredentials.length;
  List<String> get _ids => _allCredentials.keys.toList();
  // the credential ids sorted inalphabetical order of the credential-name
  List<String> get idsSorted {
    final ids = _ids;
    ids.sort(_byName);
    return ids;
  }

  // helper for sorting credentials by name
  int _byName(String aId, String bId) {
    final aName = _allCredentials[aId].name;
    final bName = _allCredentials[bId].name;
    return aName.compareTo(bName);
  }

  //
  // fetch the credential for a given id
  ClusterCredentials forId(String id) => _allCredentials[id];
  bool existsForId(String id) => _allCredentials.containsKey(id);
  //
  // add a credential
  void add(ClusterCredentials credential, {bool store = true}) {
    final id = credential.id;
    _allCredentials[id] = credential;
    print('After add, Store = $asJson');
    // save the cred
    if (store) _persistentStorage.storeCredential(credential);
    // we add this listener here to trigger saving the cred
    //  this ensures only creds managed by this ClusterCredentialStore are stored
    credential.addListener(() {
      _persistentStorage.storeCredential(credential);
    });
    notifyListeners();
  }

  // remove a credential
  void deleteForId(String credentialId) {
    final deletedCred = _allCredentials.remove(credentialId);
    print('After delete, store = $asJson');
    deletedCred.removeListener(() {
      _persistentStorage.storeCredential(deletedCred);
    });
    _persistentStorage.deleteCredential(deletedCred);
    notifyListeners();
  }

  //
  List<Map<String, String>> get toMap => _allCredentials.values.map((value) => value.toMap).toList();
  String get asJson => json.encode(toMap);
  //
  // persistent storage
  void _load() async {
    final loadedCreds = await _persistentStorage.loadCredentials();
    loadedCreds.forEach((cred) => add(cred, store: false));
    notifyListeners();
  }
  //
}
