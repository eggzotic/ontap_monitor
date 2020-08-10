//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapSvmSubtype {
  svm_default,
  dp_destination,
  sync_source,
  sync_destination,
}

//
extension ApiOntapSvmSubtypeMembers on ApiOntapSvmSubtype {
  String get name {
    if (this == ApiOntapSvmSubtype.svm_default) return 'default';
    return toString()?.split('.')?.last;
  }

  //
  static ApiOntapSvmSubtype fromName(String name) {
    if (name == null) return null;
    return ApiOntapSvmSubtype.values.firstWhere((v) => v.name == name);
  }
}
