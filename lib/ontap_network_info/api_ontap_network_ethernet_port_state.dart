//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapNetworkEthernetPortState {
  up,
  down,
}

//
extension ApioOntapNetworkEthernetPortStateMembers
    on ApiOntapNetworkEthernetPortState {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapNetworkEthernetPortState fromIndex(int index) => index != null
      ? ApiOntapNetworkEthernetPortState.values
          .firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapNetworkEthernetPortState fromName(String name) => name != null
      ? ApiOntapNetworkEthernetPortState.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
