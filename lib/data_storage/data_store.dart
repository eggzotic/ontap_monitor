//
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/persistent_data_store.dart';

class DataStore<T extends DataItem> with ChangeNotifier {
  DataStore({
    @required T Function(Map<String, dynamic>) itemFromMap,
    @required String itemIdPrefix,
    this.isCacheData = false,
  }) {
    _load(itemFromMap: itemFromMap, itemIdPrefix: itemIdPrefix);
    // cached-data is kept in the static list
    if (isCacheData) _cachedDataStores.add(this);
  }
  //
  static List<DataStore> _cachedDataStores = [];
  static Map<Type, int> clearCaches() {
    final Map<Type, int> cacheCount = {};
    _cachedDataStores.forEach((dataStore) {
      cacheCount[dataStore.type] = dataStore.clear();
    });
    return cacheCount;
  }

  //
  final _persistentStorage = PersistentDataStore<T>();
  //
  // the real content
  Map<String, T> _allItems = {};
  // convenience getters
  int get itemCount => _allItems.length;
  List<String> get _ids => _allItems.keys.toList();
  // the item ids sorted in alphabetical name-order
  List<String> get idsSorted {
    final ids = _ids;
    ids.sort(_byName);
    return ids;
  }

  final type = T;

  final bool isCacheData;
  //
  // this is for external use - return the list of ids sorted by their
  //  respective action-names
  List<String> sortedIds(List<String> ids) {
    final itemIds = ids.map((id) => id).toList();
    itemIds.sort(_byName);
    return itemIds;
  }

  // helper for sorting items by name
  int _byName(String aId, String bId) {
    final aName = _allItems[aId].name;
    final bName = _allItems[bId].name;
    return aName.compareTo(bName);
  }

  //
  // fetch the item for a given id
  T forId(String id) => _allItems[id];
  bool existsForId(String id) => _allItems.containsKey(id);

  // add an item
  void add(
    T item, {
    bool storeNow = true,
    bool neverStore = false,
  }) {
    final id = item.id;
    _allItems[id] = item;
    print('After add, $T Store = $asJson');

    // save the item when updates are notified - unless we never want it to be
    //  committed to persistent storage (neverStore == true)
    if (!neverStore)
      item.addListener(() {
        _persistentStorage.store(item);
      });
    // save the item now - unless we're instructed not to (storeNow == false)
    if (storeNow) {
      _persistentStorage.store(item);
      notifyListeners();
    }
  }

  // remove an item
  void deleteForId(String id) {
    final deletedItem = _allItems.remove(id);
    print('After delete, $T store =  $asJson');
    deletedItem.removeListener(() {
      _persistentStorage.store(deletedItem);
    });
    _persistentStorage.delete(deletedItem);
    notifyListeners();
  }

  List<Map<String, dynamic>> get toMap =>
      _allItems.values.map((value) => value.toMap).toList();
  String get asJson => json.encode(toMap);

  // load from persistent storage
  void _load({
    @required T Function(Map<String, dynamic>) itemFromMap,
    @required String itemIdPrefix,
  }) async {
    await _persistentStorage.load(
      addItem: (map) => add(itemFromMap(map), storeNow: false),
      idPrefix: itemIdPrefix,
    );
    notifyListeners();
  }

  //
  // ephemeral state only, below here
  //
  bool _showSelectedOnly = false;
  bool get showSelectedOnly => _showSelectedOnly;
  void toggleSelectedOnly() {
    _showSelectedOnly = !_showSelectedOnly;
    notifyListeners();
  }

  // the current filter text
  String _filterText = '';
  String get filterText => _filterText;
  void setFilterText(String text) {
    _filterText = text.toLowerCase().trim();
    notifyListeners();
  }

  // return the list of item IDs, sorted by name, whose names contain the given
  //  text - useful for filtering searches
  List<String> get filteredActionsIds {
    if (_filterText == null || _filterText.isEmpty) return idsSorted;
    //
    final filteredActions = _allItems.values
        .where((action) => action.name.contains(_filterText))
        .toList();
    final filteredIds = filteredActions.map((action) => action.id).toList();
    filteredIds.sort(_byName);
    return filteredIds;
  }

  //
  // Clear the store (only do this for stores comtaining cached info!)
  int clear() {
    final deletedCount = itemCount;
    _ids.forEach((id) => deleteForId(id));
    return deletedCount;
  }
}
