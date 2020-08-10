//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapNetworkInterfaceServicePolicy {
  // the actual values have hyphens, rather than underscores, separating the words
  // this is reflected in the 'name' getter below
  default_management,
  default_data_files,
  default_data_blocks,
}

//
extension ApiOntapNetworkInterfaceServicePolicyMembers
    on ApiOntapNetworkInterfaceServicePolicy {
  String get name => toString()?.split('.')?.last?.replaceAll('_', '-');
  //
  static ApiOntapNetworkInterfaceServicePolicy fromIndex(
          int index) =>
      index != null
          ? ApiOntapNetworkInterfaceServicePolicy.values
              .firstWhere((v) => v.index == index)
          : null;
  // create from name
  static ApiOntapNetworkInterfaceServicePolicy fromName(
          String name) =>
      name != null
          ? ApiOntapNetworkInterfaceServicePolicy.values
              .firstWhere((v) => v.name == name.toLowerCase())
          : null;
}
