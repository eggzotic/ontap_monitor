//
// class to represent API parameters
import 'package:flutter/foundation.dart';

class ApiParameter<T> {
  final String name;
  final T defaultValue;
  T _value;
  //
  ApiParameter._private(
    this.name,
    this.defaultValue,
    this._value,
  );
  //
  factory ApiParameter({
    @required String name,
    T defaultValue,
    T value,
  }) {
    assert(value != null || defaultValue != null);
    value ??= defaultValue;
    return ApiParameter._private(name, defaultValue, value);
  }
  //
  Type get type => T;
  T get value => _value ?? defaultValue;
  void setValue(T newValue) => _value = newValue;
}
