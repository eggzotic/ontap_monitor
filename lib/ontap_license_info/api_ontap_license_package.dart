//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
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
  ApiOntapLicensePackage._private({
    this.ownerId,
    this.licenses,
    this.name,
    this.scope,
    this.state,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);
  //
  factory ApiOntapLicensePackage.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    if (json == null) return null;
    assert(ownerId != null || json['ownerId'] != null);
    //
    return ApiOntapLicensePackage._private(
      ownerId: json['ownerId'] ?? ownerId,
      licenses: json['licenses']
          ?.map<ApiOntapLicense>((e) => ApiOntapLicense.fromMap(e))
          ?.toList(),
      name: json['name'],
      scope: ApiOntapLicenseScopeMembers.fromName(json['scope']),
      state: ApiOntapLicenseComplianceStateMembers.fromName(json['state']),
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
    );
  }
  //
  @override
  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        'licenses': licenses?.map((lic) => lic?.toMap)?.toList(),
        'name': name,
        'scope': scope?.name,
        'state': state?.name,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
