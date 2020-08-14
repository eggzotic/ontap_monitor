//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
// parent-class/interface for things that are stored
import 'package:flutter/foundation.dart';

abstract class StorableItem with ChangeNotifier {
  /// [ownerId] is an optional field that identifies the ID of the owning cluster
  /// in some cases the ownerId may also be useful for generating a unique [id]
  String get ownerId => '';
  String get name;
  String get id;

  /// [toMap] a getter to provide a Map representation suitable for JSON encoding
  Map<String, dynamic> get toMap => {};
  DateTime _lastUpdated;
  DateTime get lastUpdated => _lastUpdated;
  //
  // each subclass constructor should finish with super(lastUpdated: ...)
  StorableItem({DateTime lastUpdated}) {
    _lastUpdated = lastUpdated ?? DateTime.now();
  }
}
