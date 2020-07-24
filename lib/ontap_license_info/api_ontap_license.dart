//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_capacity.dart';

class ApiOntapLicense {
  final String owner;
  final String serialNumber;
  final bool active;
  final bool evaluation;
  final ApiOntapLicenseComplianceState complianceState;
  final DateTime expiryTime;
  final DateTime startTime;
  final ApiOntapLicenseCapacity capacity;
  //
  ApiOntapLicense._private(
    this.owner,
    this.serialNumber,
    this.active,
    this.evaluation,
    this.complianceState,
    this.expiryTime,
    this.startTime,
    this.capacity,
  );
  //
  factory ApiOntapLicense({
    @required String owner,
    @required String serialNumber,
    @required bool active,
    @required bool evaluation,
    @required ApiOntapLicenseComplianceState complianceState,
    DateTime expiryTime,
    DateTime startTime,
    ApiOntapLicenseCapacity capacity,
  }) {
    return ApiOntapLicense._private(
      owner,
      serialNumber,
      active,
      evaluation,
      complianceState,
      expiryTime,
      startTime,
      capacity,
    );
  }
  //
  factory ApiOntapLicense.fromMap(Map<String, dynamic> json) {
    final String owner = json['owner'];
    final String serialNumber = json['serial_number'] ?? 'none';
    final bool active = json['active'];
    final bool evaluation = json['evaluation'];
    final ApiOntapLicenseComplianceState complianceState =
        ApiOntapLicenseComplianceStateMembers.fromName(
            Map.from(json['compliance'])['state']);
    // optionally-present properties
    DateTime expiryTime;
    DateTime startTime;
    ApiOntapLicenseCapacity capacity;
    if (json['expiry_time'] != null)
      expiryTime = DateTime.parse(json['expiry_time']);
    if (json['start_time'] != null)
      startTime = DateTime.parse(json['start_time']);
    if (json['capacity'] != null)
      capacity = ApiOntapLicenseCapacity.fromMap(json['capacity']);
    return ApiOntapLicense(
      owner: owner,
      serialNumber: serialNumber,
      active: active,
      evaluation: evaluation,
      complianceState: complianceState,
      expiryTime: expiryTime,
      startTime: startTime,
      capacity: capacity,
    );
  }
  //
  Map<String, dynamic> get toMap => {
        'owner': owner,
        'serial_number': serialNumber,
        'active': active,
        'evaluation': evaluation,
        'compliance': {'state': complianceState.name},
        'expiry_time': expiryTime?.toIso8601String(),
        'start_time': startTime?.toIso8601String(),
        'capacity': capacity?.toMap,
      };
}
