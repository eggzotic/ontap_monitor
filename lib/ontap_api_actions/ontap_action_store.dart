import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/persistent_storage.dart';

//
class OntapActionStore with ChangeNotifier {
  OntapActionStore() {
    _load();
  }
  final _persistentStorage = PersistentStorage();
  // the real content, i.e. the actions
  Map<String, OntapAction> _allActions = {};
  // convenience getters
  int get actionCount => _allActions.length;
  List<String> get _ids => _allActions.keys.toList();
  // the action ids sorted in alphabetical order of the action-name
  List<String> get idsSorted {
    final ids = _ids;
    ids.sort(_byName);
    return ids;
  }

  // this is for external use - return the list of ids sorted by their respective action-names
  List<String> sortedIds(List<String> ids) {
    final actionIds = ids.map((id) => id).toList();
    actionIds.sort(_byName);
    return actionIds;
  }

  // helper for sorting actions by name
  int _byName(String aId, String bId) {
    final aName = _allActions[aId].name;
    final bName = _allActions[bId].name;
    return aName.compareTo(bName);
  }

  //
  // fetch the action for a given id
  OntapAction forId(String id) => _allActions[id];
  bool existsForId(String id) => _allActions.containsKey(id);
  //
  // add an action
  void add(OntapAction action, {bool store = true}) {
    final id = action.id;
    _allActions[id] = action;
    print('After add, Action Store = $asJson');
    // save the action
    if (store) _persistentStorage.storeOntapAction(action);
    //
    action.addListener(() {
      _persistentStorage.storeOntapAction(action);
    });
    notifyListeners();
  }

  //
  // remove an action
  void deleteForId(String actionId) {
    final deletedAction = _allActions.remove(actionId);
    print('After delete, Action store =  $asJson');
    deletedAction.removeListener(() {
      _persistentStorage.storeOntapAction(deletedAction);
    });
    _persistentStorage.deleteAction(deletedAction);
    notifyListeners();
  }

  //
  List<Map<String, dynamic>> get toMap =>
      _allActions.values.map((value) => value.toMap).toList();
  String get asJson => json.encode(toMap);
  //
  // this is rather naughty!
  // These are not true (nor persistent) app-state, but are for the convenience of the UI!
  // (and, yes, they're here to avoid actually using a Stateful widget, which is probably where they belong)
  bool _showSelectedOnly = false;
  bool get showSelectedOnly => _showSelectedOnly;
  void toggleSelectedOnly() {
    _showSelectedOnly = !_showSelectedOnly;
    notifyListeners();
  }

  //
  // the current filter text
  String _filterText = '';
  String get filterText => _filterText;
  void setFilterText(String text) {
    _filterText = text.toLowerCase().trim();
    notifyListeners();
  }

  //
  // return the list of actions IDs, sorted by action-name, whose names contain the given text - useful for filtering searches
  List<String> get filteredActionsIds {
    if (_filterText == null || _filterText.isEmpty) return idsSorted;
    //
    final filteredActions = _allActions.values
        .where((action) => action.name.contains(_filterText))
        .toList();
    final filteredIds = filteredActions.map((action) => action.id).toList();
    filteredIds.sort(_byName);
    return filteredIds;
  }
  //

  // load from persistent storage
  void _load() async {
    final loadedActions = await _persistentStorage.loadActions();
    loadedActions.forEach((action) => add(action, store: false));
    notifyListeners();
  }
}
