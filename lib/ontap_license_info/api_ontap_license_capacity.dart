//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';

class ApiOntapLicenseCapacity {
  //
  static const _gbInBytes = 1024 * 1024 * 1024;
  //
  final int maximumSize; // in bytes
  final int usedSize; // in bytes
  //
  ApiOntapLicenseCapacity._private(
    this.maximumSize,
    this.usedSize,
  );
  //
  factory ApiOntapLicenseCapacity({
    @required int maximumSize,
    @required int usedSize,
  }) {
    return ApiOntapLicenseCapacity._private(maximumSize, usedSize);
  }
  //
  factory ApiOntapLicenseCapacity.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiOntapLicenseCapacity(
      maximumSize: json['maximum_size'],
      usedSize: json['used_size'],
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'maximum_size': maximumSize,
        'used_size': usedSize,
      };
  //
  int get maxSizeInGb => (maximumSize / _gbInBytes).floor();
  int get usedSizeInGb => (usedSize / _gbInBytes).floor();
}
