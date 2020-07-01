//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_scope.dart';

class ApiOntapLicensePackage {
  final List<ApiOntapLicense> licenses;
  final String name;
  final ApiOntapLicenseScope scope;
  final ApiOntapLicenseComplianceState state;
  //
  ApiOntapLicensePackage._private(
    this.licenses,
    this.name,
    this.scope,
    this.state,
  );
  //
  factory ApiOntapLicensePackage({
    @required List<ApiOntapLicense> licenses,
    @required String name,
    @required ApiOntapLicenseScope scope,
    @required ApiOntapLicenseComplianceState state,
  }) {
    return ApiOntapLicensePackage._private(
      licenses,
      name,
      scope,
      state,
    );
  }
  //
  factory ApiOntapLicensePackage.fromMap(Map<String, dynamic> json) {
    final List<ApiOntapLicense> licenses = List.from(json['licenses'])
        .map((e) => ApiOntapLicense.fromMap(e))
        .toList();
    final String name = json['name'];
    final ApiOntapLicenseScope scope =
        ApiOntapLicenseScope.fromString(json['scope']);
    final ApiOntapLicenseComplianceState state =
        ApiOntapLicenseComplianceState.fromString(json['state']);
    //
    return ApiOntapLicensePackage(
      licenses: licenses,
      name: name,
      scope: scope,
      state: state,
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'licenses': licenses.map((lic) => lic.toMap).toList(),
        'name': name,
        'scope': scope.toString(),
        'state': state.toString(),
      };
}
