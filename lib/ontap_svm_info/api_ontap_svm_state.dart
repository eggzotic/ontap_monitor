//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapSvmState {
  starting,
  running,
  stopping,
  stopped,
  deleting,
}

//
extension ApiOntapSvmStateMembers on ApiOntapSvmState {
  String get name => toString().split('.').last;
  //
  static ApiOntapSvmState fromName(String name) =>
      ApiOntapSvmState.values.firstWhere(
        (v) => v.name == name,
      );
}
