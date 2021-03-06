//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

enum ApiOntapStorageShelfPortDesignator {
  circle,
  square,
  // we cannot use int's directly as identifiers, so I've pre-pended with 'p'
  p1,
  p2,
  p3,
  p4,
}

//
extension ApiOntapStorageShelfPortDesignatorMembers
    on ApiOntapStorageShelfPortDesignator {
  String get name => const {
        ApiOntapStorageShelfPortDesignator.circle: 'circle',
        ApiOntapStorageShelfPortDesignator.square: 'square',
        // and so we have to convert back to the original JSON format of int's only
        ApiOntapStorageShelfPortDesignator.p1: '1',
        ApiOntapStorageShelfPortDesignator.p2: '2',
        ApiOntapStorageShelfPortDesignator.p3: '3',
        ApiOntapStorageShelfPortDesignator.p4: '4',
      }[this];
  //
  static ApiOntapStorageShelfPortDesignator fromName(String name) =>
      name != null
          ? ApiOntapStorageShelfPortDesignator.values.firstWhere(
              (v) => v.name == name,
              orElse: () => null,
            )
          : null;
  //
  static ApiOntapStorageShelfPortDesignator fromIndex(int index) =>
      index != null
          ? ApiOntapStorageShelfPortDesignator.values.firstWhere(
              (v) => v.index == index,
              orElse: () => null,
            )
          : null;
}
