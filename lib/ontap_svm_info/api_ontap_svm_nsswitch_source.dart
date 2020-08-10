//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapSvmNsswitchSource {
  files,
  dns,
  ldap,
  nis,
}

//
extension ApiOntapSvmNsswitchSourceMembers on ApiOntapSvmNsswitchSource {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapSvmNsswitchSource fromName(String name) => name != null
      ? ApiOntapSvmNsswitchSource.values.firstWhere((v) => v.name == name)
      : null;
}
