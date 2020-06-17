//
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/cluster_credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClusterCredentialStore with ChangeNotifier {
  ClusterCredentialStore() {
    load();
  }
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
  void add(ClusterCredentials credential) {
    final id = credential.id;
    _allCredentials[id] = credential;
    print('After add, Store = $asJson');
    // save the cred
    credential.store();
    // we add this listener here to trigger saving the cred
    //  this ensures only creds managed by this ClusterCredentialStore are stored
    credential.addListener(() {
      credential.store();
    });
    notifyListeners();
  }

  // remove a credential
  void deleteForId(String credentialId) {
    final deletedCred = _allCredentials.remove(credentialId);
    print('After delete, store = $asJson');
    deletedCred.removeListener(() {
      deletedCred.store();
    });
    deletedCred.delete();
    notifyListeners();
  }

  //
  List<Map<String, String>> get toMap =>
      _allCredentials.values.map((value) => value.toMap).toList();
  String get asJson => json.encode(toMap);
  //
  // persistent storage
  // via SharedPreferences:
  void load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load the relevant keys
    final ids = prefs.getKeys();
    final prefLen = ClusterCredentials.idPrefix.length;
    final credentialIds = ids.where((element) =>
        element.substring(0, prefLen) == ClusterCredentials.idPrefix);
    credentialIds.forEach((key) {
      final cred = ClusterCredentials.fromJson(prefs.getString(key));
      print('Loaded credential: $cred');
      add(cred);
    });
    notifyListeners();
  }
  //
}
