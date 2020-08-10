//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapNetworkInterfaceService {
  cluster_core,
  intercluster_core,
  management_core,
  management_autosupport,
  management_bgp,
  management_https,
  management_ssh,
  data_core,
  data_nfs,
  data_cifs,
  data_flexcache,
  data_iscsi,
}

//
extension ApiOntapNetworkInterfaceServiceMembers
    on ApiOntapNetworkInterfaceService {
  String get name => toString()?.split('.')?.last;
  //
  static ApiOntapNetworkInterfaceService fromIndex(int index) => index != null
      ? ApiOntapNetworkInterfaceService.values
          .firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapNetworkInterfaceService fromName(String name) => name != null
      ? ApiOntapNetworkInterfaceService.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
