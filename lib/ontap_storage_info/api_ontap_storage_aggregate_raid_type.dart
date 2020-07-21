enum ApiOntapStorageAggregateRaidType {
  raid_dp,
  raid_tec,
  raid0,
  raid4,
}

//
extension ApiOntapStorageAggregateRaidTypeMembers
    on ApiOntapStorageAggregateRaidType {
  String get name => toString().split('.').last;
  // create from index
  static ApiOntapStorageAggregateRaidType fromIndex(int index) =>
      ApiOntapStorageAggregateRaidType.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageAggregateRaidType fromName(String name) =>
      ApiOntapStorageAggregateRaidType.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
