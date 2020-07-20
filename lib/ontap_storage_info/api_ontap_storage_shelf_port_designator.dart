enum ApiOntapStorageShelfPortDesignator {
  circle,
  square,
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
        ApiOntapStorageShelfPortDesignator.p1: '1',
        ApiOntapStorageShelfPortDesignator.p2: '2',
        ApiOntapStorageShelfPortDesignator.p3: '3',
        ApiOntapStorageShelfPortDesignator.p4: '4',
      }[this];
  //
  static ApiOntapStorageShelfPortDesignator fromString(String text) =>
      ApiOntapStorageShelfPortDesignator.values.firstWhere(
        (v) => v.name == text,
        orElse: () => null,
      );
  //
  static ApiOntapStorageShelfPortDesignator fromIndex(int index) =>
      ApiOntapStorageShelfPortDesignator.values.firstWhere(
        (v) => v.index == index,
        orElse: () => null,
      );
}
