//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapLicenseScope {
  not_available,
  site,
  cluster,
  node,
}

extension ApiOntapLicenseScopeMembers on ApiOntapLicenseScope {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapLicenseScope fromName(String name) {
    if (name == null) return null;
    return ApiOntapLicenseScope.values.firstWhere(
      (value) => value.name == name,
      orElse: () => ApiOntapLicenseScope.not_available,
    );
  }
}
