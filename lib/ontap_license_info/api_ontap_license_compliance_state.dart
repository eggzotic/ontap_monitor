//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapLicenseComplianceState {
  compliant,
  noncompliant,
  unlicensed,
  unknown,
}

extension ApiOntapLicenseComplianceStateMembers
    on ApiOntapLicenseComplianceState {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapLicenseComplianceState fromName(String name) {
    if (name == null) return null;
    return ApiOntapLicenseComplianceState.values
        .firstWhere((v) => v.name == name, orElse: null);
  }
}
