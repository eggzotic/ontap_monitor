enum ApiOntapLicenseScope {
  not_available,
  site,
  cluster,
  node,
}

extension ApiOntapLicenseScopeMembers on ApiOntapLicenseScope {
  String get name => toString().split('.').last;
  //
  static ApiOntapLicenseScope fromString(String text) {
    return ApiOntapLicenseScope.values.firstWhere(
      (value) => value.name == text,
      orElse: () => ApiOntapLicenseScope.not_available,
    );
  }
}
