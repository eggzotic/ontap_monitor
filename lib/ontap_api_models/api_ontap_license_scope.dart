enum _ApiOntapLicenseScope {
  not_available,
  site,
  cluster,
  node,
}

class ApiOntapLicenseScope {
  final _ApiOntapLicenseScope _value;
  const ApiOntapLicenseScope._private(this._value);
  int get index => _value.index;
  //
  // Some Singletons to represent the total set of values
  static const notAvailable =
      ApiOntapLicenseScope._private(_ApiOntapLicenseScope.not_available);
  static const site = ApiOntapLicenseScope._private(_ApiOntapLicenseScope.site);
  static const cluster =
      ApiOntapLicenseScope._private(_ApiOntapLicenseScope.cluster);
  static const node = ApiOntapLicenseScope._private(_ApiOntapLicenseScope.node);
  //
  static final values = [
    notAvailable,
    site,
    cluster,
    node,
  ];
  //
  String toString() => _value.toString();
  factory ApiOntapLicenseScope.fromString(String text) {
    return values.firstWhere(
      (value) => value.toString() == text,
      orElse: () => notAvailable,
    );
  }
}
