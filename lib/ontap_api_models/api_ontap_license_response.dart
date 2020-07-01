import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_package.dart';
import 'package:uuid/uuid.dart';

class ApiOntapLicenseResponse extends DataItem {
  final List<ApiOntapLicensePackage> records;
  //
  static const idPrefix = "api-ontap-license-response_";
  //
  final String id;
  final String name = 'Licenses';
  final DateTime lastConnected;
  //
  Map<String, dynamic> get toMap => {
        'records': records.map((package) => package.toMap).toList(),
        'lastConnected': lastConnected.toString(),
      };
  //
  ApiOntapLicenseResponse._private(
    this.id,
    this.records,
    this.lastConnected,
  );
  //
  factory ApiOntapLicenseResponse({
    @required String id,
    @required List<ApiOntapLicensePackage> records,
    DateTime lastConnected,
  }) {
    return ApiOntapLicenseResponse._private(id, records, lastConnected);
  }
  //
  factory ApiOntapLicenseResponse.fromMap(Map<String, dynamic> json) {
    final String id = json['id'] ?? Uuid().v4();
    final List<ApiOntapLicensePackage> records = List.from(json['records'])
        .map((packageMap) =>
            ApiOntapLicensePackage.fromMap(Map.from(packageMap)))
        .toList();
    final DateTime lastConnected = DateTime.parse(
      json['lastConnected'] ?? DateTime.now().toString(),
    ); //
    return ApiOntapLicenseResponse(
      id: id,
      records: records,
      lastConnected: lastConnected,
    );
  }
  //
  // syntactic sugar for use where this constructor must be provided
  static final constructFromMap =
      (Map<String, dynamic> map) => ApiOntapLicenseResponse.fromMap(map);
}
