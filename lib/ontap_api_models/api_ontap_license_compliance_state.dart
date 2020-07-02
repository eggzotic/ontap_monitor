enum _ApiOntapLicenseComplianceState {
  compliant,
  noncompliant,
  unlicensed,
  unknown,
}

class ApiOntapLicenseComplianceState {
  final _ApiOntapLicenseComplianceState _value;
  //
  const ApiOntapLicenseComplianceState._private(this._value);
  int get index => _value.index;
  //
  // Some Singletons to represent the total set of values
  static const compliant = ApiOntapLicenseComplianceState._private(
      _ApiOntapLicenseComplianceState.compliant);
  static const noncompliant = ApiOntapLicenseComplianceState._private(
      _ApiOntapLicenseComplianceState.noncompliant);
  static const unlicensed = ApiOntapLicenseComplianceState._private(
      _ApiOntapLicenseComplianceState.unlicensed);
  static const unknown = ApiOntapLicenseComplianceState._private(
      _ApiOntapLicenseComplianceState.unknown);
  //
  static final values = [
    compliant,
    noncompliant,
    unlicensed,
    unknown,
  ];
  //
  String toString() => _value.toString().split('.').last;
  //
  factory ApiOntapLicenseComplianceState.fromString(String text) {
    print('Begin ApiOntapLicenseComplianceState.fromString');
    return values.firstWhere(
      (value) => value.toString() == text,
      orElse: () => unknown,
    );
  }
}
