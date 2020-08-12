//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentItemStore<T extends StorableItem> {
  PersistentItemStore({@required this.itemIdPrefix});
  String asJson(T item) => json.encode(item.toMap);
  final String itemIdPrefix;
  //
  Future<void> load({
    /// [addItem] must be a func that takes a JSON-decoded Map and performs
    ///  both the conversion into a StorableItem-subclass instance and adds it
    ///  to the relevant ItemStore
    @required void Function(Map<String, dynamic>) addItem,
  }) async {
    assert(itemIdPrefix != null && itemIdPrefix.isNotEmpty);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load the relevant keys
    final ids = prefs.getKeys();
    final prefLen = itemIdPrefix.length;
    final itemIds = ids.where(
        (id) => id.substring(0, min(id.length, prefLen)) == itemIdPrefix);
    itemIds?.forEach((id) => addItem(json.decode(prefs.getString(id))));
  }

  //
  void store(T item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(itemIdPrefix + item.id, asJson(item));
  }

  //
  void delete(T item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(itemIdPrefix + item.id);
  }
}
