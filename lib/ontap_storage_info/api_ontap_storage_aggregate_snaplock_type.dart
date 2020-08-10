//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateSnaplockType {
  non_snaplock,
  compliance,
  enterprise,
}

//
extension ApiOntapStorageAggregateSnaplockTypeMembers
    on ApiOntapStorageAggregateSnaplockType {
  String get name => toString()?.split('.')?.last;
  // create from index
  static ApiOntapStorageAggregateSnaplockType fromIndex(int index) =>
      index != null
          ? ApiOntapStorageAggregateSnaplockType.values.firstWhere(
              (v) => v.index == index,
              orElse: () => ApiOntapStorageAggregateSnaplockType.non_snaplock,
            )
          : null;
  // create from name
  static ApiOntapStorageAggregateSnaplockType fromName(String name) =>
      name != null
          ? ApiOntapStorageAggregateSnaplockType.values.firstWhere(
              (v) => v.name == name.toLowerCase(),
              orElse: () => ApiOntapStorageAggregateSnaplockType.non_snaplock,
            )
          : null;
}
