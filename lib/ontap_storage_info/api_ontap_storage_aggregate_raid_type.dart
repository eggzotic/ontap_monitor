//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateRaidType {
  raid_dp,
  raid_tec,
  raid0,
  raid4,
}

//
extension ApiOntapStorageAggregateRaidTypeMembers
    on ApiOntapStorageAggregateRaidType {
  String get name => toString()?.split('.')?.last;
  // create from index
  static ApiOntapStorageAggregateRaidType fromIndex(int index) => index != null
      ? ApiOntapStorageAggregateRaidType.values
          .firstWhere((v) => v.index == index)
      : null;
  // create from name
  static ApiOntapStorageAggregateRaidType fromName(String name) => name != null
      ? ApiOntapStorageAggregateRaidType.values
          .firstWhere((v) => v.name == name.toLowerCase())
      : null;
}
