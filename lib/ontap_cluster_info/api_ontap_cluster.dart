//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
//
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_version.dart';

class ApiOntapCluster extends StorableItem {
  //
  @override
  String ownerId;
  @override
  final String name;
  final String uuid;
  final String contact;
  final String location;
  final bool isAsa;
  final ApiOntapVersion version;
  @override
  String get id => ownerId + '_' + uuid;
  @override
  final String rawJson;

  // for storing these
  @override
  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        'name': name,
        'uuid': uuid,
        'contact': contact,
        'location': location,
        'san_optimized': isAsa,
        'version': version?.toMap,
        'lastUpdated': lastUpdated?.toIso8601String(),
        'rawJson': rawJson,
      };
  //
  ApiOntapCluster._private({
    this.ownerId,
    this.uuid,
    this.name,
    this.contact,
    this.location,
    this.isAsa,
    this.version,
    this.rawJson,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);
  //
  factory ApiOntapCluster.fromMap(
    Map<String, dynamic> json, {
    String ownerId,
  }) {
    if (json == null) return null;
    assert(ownerId != null || json['ownerId'] != null);
    // covering the case where the input is coming from both persistent storage
    //  and from an API call
    DateTime lastUpdated;
    if (json['lastUpdated'] != null)
      lastUpdated = DateTime.parse(json['lastUpdated']);
    return ApiOntapCluster._private(
      uuid: json['uuid'],
      contact: json['contact'],
      location: json['location'],
      name: json['name'],
      isAsa: json['san_optimized'] ?? false,
      version: ApiOntapVersion.fromMap(json['version']),
      lastUpdated: lastUpdated,
      ownerId: json['ownerId'] ?? ownerId,
    );
  }
}
