//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
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
  void clearCaches() {
    _cachedDataStores.forEach((dataStore) => dataStore.clear());
  }

  // report on the count of each type of item in the cached stores
  Map<Type, int> cacheCounts() => Map.fromEntries(
      _cachedDataStores.map((s) => MapEntry(s.itemType, s.itemCount)));
}
