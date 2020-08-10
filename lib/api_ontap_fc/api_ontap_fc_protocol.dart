//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapFcProtocol {
  fcp,
  fc_nvme,
}

//
extension ApiOntapFcProtocolMembers on ApiOntapFcProtocol {
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapFcProtocol fromIndex(int index) => 
      ApiOntapFcProtocol.values.firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapFcProtocol fromName(String name) => name != null
      ? ApiOntapFcProtocol.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
