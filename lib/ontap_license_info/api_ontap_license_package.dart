//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_scope.dart';

class ApiOntapLicensePackage extends StorableItem {
  @override
  final String ownerId;
  final List<ApiOntapLicense> licenses;
  @override
  final String name;
  final ApiOntapLicenseScope scope;
  final ApiOntapLicenseComplianceState state;
  @override
  String get id => ownerId + '_' + name;
  //
  ApiOntapLicensePackage._private(
    this.ownerId,
    this.licenses,
    this.name,
    this.scope,
    this.state,
    DateTime lastUpdated,
  ) : super(lastUpdated: lastUpdated);
  //
  factory ApiOntapLicensePackage({
    @required String ownerId,
    @required List<ApiOntapLicense> licenses,
    @required String name,
    @required ApiOntapLicenseScope scope,
    @required ApiOntapLicenseComplianceState state,
    DateTime lastUpdated,
  }) {
    return ApiOntapLicensePackage._private(
      ownerId,
      licenses,
      name,
      scope,
      state,
      lastUpdated,
    );
  }
  //
  factory ApiOntapLicensePackage.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    assert(ownerId != null || json['ownerId'] != null);
    final List<ApiOntapLicense> licenses = List.from(json['licenses'])
        .map((e) => ApiOntapLicense.fromMap(e))
        .toList();
    final String name = json['name'];
    final ApiOntapLicenseScope scope =
        ApiOntapLicenseScopeMembers.fromString(json['scope']);
    final ApiOntapLicenseComplianceState state =
        ApiOntapLicenseComplianceStateMembers.fromString(json['state']);
    //
    return ApiOntapLicensePackage(
      ownerId: json['ownerId'] ?? ownerId,
      licenses: licenses,
      name: name,
      scope: scope,
      state: state,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }
  //
  @override
  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        'licenses': licenses.map((lic) => lic.toMap).toList(),
        'name': name,
        'scope': scope.name,
        'state': state.name,
        'lastUpdated': lastUpdated.toIso8601String(),
      };
}
