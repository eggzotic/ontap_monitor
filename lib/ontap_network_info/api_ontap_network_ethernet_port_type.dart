//
enum ApiOntapNetworkEthernetPortType {
  vlan,
  physical,
  lag,
}

//
extension ApiOntapNetworkEthernetPortTypeMembers
    on ApiOntapNetworkEthernetPortType {
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapNetworkEthernetPortType fromIndex(int index) =>
      ApiOntapNetworkEthernetPortType.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapNetworkEthernetPortType fromName(String name) =>
      ApiOntapNetworkEthernetPortType.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
