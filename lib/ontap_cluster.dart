import 'dart:convert';

class OntapCluster {
  final String uuid;
  String name;
  String version;

  // Constructor
  OntapCluster._private(this.uuid, this.name, this.version);

  factory OntapCluster.fromMap(Map<String, dynamic> json) {
    final String uuid = json['uuid'];
    if (uuid == null) return null;
    final String name = json['name'] ?? 'Unknown';
    final String version = jsonDecode(json['version'])['full'];
    //
    return OntapCluster._private(uuid, name, version);
  }

  factory OntapCluster.fake() {
    return OntapCluster.fromMap({
      'name': 'unknown-name',
      'uuid': 'unknown-uuid',
      'version': '{ "full" : "Unknown version"}'
    });
  }
}