//
// abstract class - parent class for things that are stored
import 'package:flutter/foundation.dart';

abstract class DataItem with ChangeNotifier {
  String get name;
  String get id;
  String get nonPrefixedId => id;
  Map<String, dynamic> get toMap;
}
