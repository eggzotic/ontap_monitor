//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/persistent_item_store.dart';
import 'package:pretty_json/pretty_json.dart';

/// [T] represents the item-type that this stores
class ItemStore<T extends StorableItem> with ChangeNotifier {
  ItemStore({
    this.isCacheData = false,
    @required String itemIdPrefix,
    @required this.itemFromMap,
  }) {
    _persistentStorage = PersistentItemStore<T>(itemIdPrefix: itemIdPrefix);
    _load();
  }

  final T Function(Map<String, dynamic> map, {String ownerId}) itemFromMap;

  //
  PersistentItemStore<T> _persistentStorage;
  //
  // the real content
  Map<String, T> _allItems = {};
  // convenience getters
  int get itemCount => _allItems.length;
  // the item ids sorted in alphabetical name-order
  List<String> get idsSorted {
    final ids = _allItems.keys.toList();
    ids.sort(_byName);
    return ids;
  }

  final itemType = T;

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

  List<T> forIds(List<String> ids) => ids.map((id) => _allItems[id]).toList();

  // add an item
  void add(
    T item, {
    bool storeNow = true,
    bool neverStore = false,
  }) {
    assert(item != null);
    _allItems[item.id] = item;
    notifyListeners();
    print('After add, $T Store = $asJson');

    // save the item when updates are notified - unless we never want it to be
    //  committed to persistent storage (neverStore == true)
    if (neverStore) return;
    item.addListener(() {
      _persistentStorage.store(item);
    });
    // save the item now - unless we're instructed not to (storeNow == false)
    if (storeNow) _persistentStorage.store(item);
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

  List<String> idsForOwnerId(String ownerId) =>
      idsSorted.where((id) => _allItems[id].ownerId == ownerId).toList();

  // ***RLS* only used for debug
  List<Map<String, dynamic>> get toMapList =>
      _allItems.values.map((value) => value.toMap).toList();
  String get asJson => toMapList.map((m) => prettyJson(m)).toString();
  // ***RLS* only used for debug

  // load from persistent storage
  void _load() async {
    await _persistentStorage.load(
      addItem: (map) => add(
        itemFromMap(map),
        storeNow: false,
      ),
    );
    notifyListeners();
  }

  //
  // Clear the store (only deletes for stores marked as cached-data)
  int clear() {
    if (!isCacheData) return 0;
    final deletedCount = itemCount;
    _allItems.keys.toList().forEach((id) => deleteForId(id));
    return deletedCount;
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
        .where((action) => action.name.toLowerCase().contains(_filterText))
        .toList();
    final filteredIds = filteredActions.map((action) => action.id).toList();
    filteredIds.sort(_byName);
    return filteredIds;
  }
}
