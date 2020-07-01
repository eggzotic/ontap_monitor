//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_capacity.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_compliance_state.dart';

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
    @required DateTime expiryTime,
    @required DateTime startTime,
    @required ApiOntapLicenseCapacity capacity,
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
    final String serialNumber = json['serial_number'];
    final bool active = json['active'];
    final bool evaluation = json['evaluation'];
    final ApiOntapLicenseComplianceState complianceState =
        ApiOntapLicenseComplianceState.fromString(Map.from(json['compliance'])['state']);
    final DateTime expiryTime = DateTime.parse(json['expiry_time']);
    final DateTime startTime = DateTime.parse(json['start_time']);
    final ApiOntapLicenseCapacity capacity =
        ApiOntapLicenseCapacity.fromMap(json['capacity']);
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
    'compliance': { 'state': complianceState.toString()},
    'expiry_time': expiryTime.toString(),
    'start_time': startTime.toString(),
    'capacity': capacity.toMap,
  };
}
