//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapNodeState {
  up,
  booting,
  down,
  taken_over,
  waiting_for_giveback,
  degraded,
  unknown,
}

//
extension ApiOntapNodeStateMembers on ApiOntapNodeState {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapNodeState fromIndex(int index) => index != null
      ? ApiOntapNodeState.values.firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapNodeState fromName(String name) => name != null
      ? ApiOntapNodeState.values.firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
