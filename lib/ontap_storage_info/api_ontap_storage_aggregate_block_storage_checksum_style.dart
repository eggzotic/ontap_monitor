//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
enum ApiOntapStorageAggregateBlockStorageChecksumStyle {
  block,
  advanced_zoned,
  mixed,
}

//
extension ApiOntapStorageAggregateBlockStorageChecksumStyleMembers
    on ApiOntapStorageAggregateBlockStorageChecksumStyle {
  String get name => toString()?.split('.')?.last;
  //
  // create from index
  static ApiOntapStorageAggregateBlockStorageChecksumStyle fromIndex(
          int index) =>
      index != null
          ? ApiOntapStorageAggregateBlockStorageChecksumStyle.values
              .firstWhere((v) => v.index == index)
          : null;
  // create from name
  static ApiOntapStorageAggregateBlockStorageChecksumStyle fromName(
          String name) =>
      name != null
          ? ApiOntapStorageAggregateBlockStorageChecksumStyle.values
              .firstWhere((v) => v.name == name.toLowerCase())
          : null;
}
