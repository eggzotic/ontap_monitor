//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
class ApiOntapSnapshotPolicy {
  ApiOntapSnapshotPolicy._private({
    this.name,
    this.uuid,
  });
  //
  final String name;
  final String uuid;
  //
  factory ApiOntapSnapshotPolicy.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapSnapshotPolicy._private(
              name: json['name'],
              uuid: json['uuid'],
            )
          : null;
  Map<String, dynamic> get toMap => {
        'name': name,
        'uuid': uuid,
      };
}
