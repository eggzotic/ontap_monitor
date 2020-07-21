enum ApiOntapStorageAggregateBlockStorageChecksumStyle {
  block,
  advanced_zoned,
  mixed,
}

//
extension ApiOntapStorageAggregateBlockStorageChecksumStyleMembers
    on ApiOntapStorageAggregateBlockStorageChecksumStyle {
  String get name => toString().split('.').last;
  //
  // create from index
  static ApiOntapStorageAggregateBlockStorageChecksumStyle fromIndex(
          int index) =>
      ApiOntapStorageAggregateBlockStorageChecksumStyle.values
          .firstWhere((v) => v.index == index);
  // create from name
  static ApiOntapStorageAggregateBlockStorageChecksumStyle fromName(
          String name) =>
      ApiOntapStorageAggregateBlockStorageChecksumStyle.values
          .firstWhere((v) => v.name == name.toLowerCase());
}
