//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapNetworkEthernetPortType {
  vlan,
  physical,
  lag,
}

//
extension ApiOntapNetworkEthernetPortTypeMembers
    on ApiOntapNetworkEthernetPortType {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapNetworkEthernetPortType fromIndex(int index) => index != null
      ? ApiOntapNetworkEthernetPortType.values
          .firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapNetworkEthernetPortType fromName(String name) => name != null
      ? ApiOntapNetworkEthernetPortType.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
