//
// the store-of-stores - where all app state is stored
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';

class SuperStore with ChangeNotifier {
  final Map<Type, ItemStore> _allItemStores = {};
  //
  int get storeCount => _allItemStores.length;
  ItemStore storeForType(Type t) => _allItemStores[t];
  //

  void add({
    @required Type type,
    @required ItemStore store,
  }) {
    _allItemStores[type] = store;
    store.addListener(() {
      notifyListeners();
    });
    notifyListeners();
  }

  // right now I don't have a use-case for deleting an ItemStore...
  // void remove({Type type}) {
  //   final store = _allItemStores.remove(type);
  //   store.removeListener(() {
  //     notifyListeners();
  //   });
  //   _cachedDataStores.remove(store);
  //   notifyListeners();
  // }

  List<ItemStore> get _cachedDataStores =>
      _allItemStores.values.where((store) => store.isCacheData).toList();
  //
  Map<Type, int> clearCaches() {
    final Map<Type, int> cacheCount = {};
    // empty the cached-data stores
    _cachedDataStores.forEach((dataStore) {
      cacheCount[dataStore.itemType] = dataStore.clear();
    });
    return cacheCount;
  }
}
