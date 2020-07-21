//
enum ApiOntapLicenseComplianceState {
  compliant,
  noncompliant,
  unlicensed,
  unknown,
}

extension ApiOntapLicenseComplianceStateMembers on ApiOntapLicenseComplianceState {
  String get name => toString().split('.').last;
  //
  static ApiOntapLicenseComplianceState fromString(String text) {
    return ApiOntapLicenseComplianceState.values
        .firstWhere((v) => v.name == text, orElse: null);
  }
}