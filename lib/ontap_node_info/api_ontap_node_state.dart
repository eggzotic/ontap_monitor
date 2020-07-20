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
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapNodeState fromIndex(int index) =>
      ApiOntapNodeState.values.firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapNodeState fromName(String name) =>
      ApiOntapNodeState.values.firstWhere((v) => v.name == name.toLowerCase());
}
