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
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapNetworkEthernetPortState fromIndex(int index) =>
      ApiOntapNetworkEthernetPortState.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapNetworkEthernetPortState fromName(String name) =>
      ApiOntapNetworkEthernetPortState.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
