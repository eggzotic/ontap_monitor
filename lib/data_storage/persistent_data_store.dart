//
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistentDataStore<T extends DataItem> {
  String asJson(T item) => json.encode(item.toMap);
  //
  Future<void> load({
    /// this func must take a JSON-decoded Map and perform both the conversion
    ///  into a DataItem instance and add it to the upstream DataStore
    @required void Function(Map<String, dynamic>) addItem,
    /// each DataItem will provide this prefix to enable identification of the
    ///  specific subclass represented in the raw-string-data
    @required String idPrefix,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // load the relevant keys
    final ids = prefs.getKeys();
    print('load: Found total of ${ids.length} keys');
    final prefLen = idPrefix.length;
    final itemIds = ids.where((id) => id.substring(0, prefLen) == idPrefix);
    print('load $T: Found ${itemIds.length} keys');
    itemIds.forEach((key) => addItem(json.decode(prefs.getString(key))));
  }

  //
  void store(T item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Storing $T ${asJson(item)}');
    prefs.setString(item.id, asJson(item));
  }

  //
  void delete(T item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Removing $T ${asJson(item)}');
    prefs.remove(item.id);
  }
}
