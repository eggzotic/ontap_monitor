//
import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_version.dart';

class ApiOntapCluster extends DataItem {
  static const idPrefix = 'api-ontap-cluster_';
  //
  final String name;
  final String uuid;
  final String contact;
  final String location;
  final bool isAsa;
  final ApiOntapVersion version;
  final DateTime lastConnected;

  String get id => idPrefix + uuid;

  // for storing these
  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'uuid': uuid,
        'contact': contact,
        'location': location,
        'san_optimized': isAsa,
        'version': version.toMap,
        'lastConnected': lastConnected.toString(),
      };
  //
  ApiOntapCluster._private(
    this.uuid,
    this.name,
    this.contact,
    this.location,
    this.isAsa,
    this.version,
    this.lastConnected,
  );
  //
  // for re-inflating
  factory ApiOntapCluster({
    @required String uuid,
    String name = '',
    String contact = '',
    String location = '',
    bool isAsa = false,
    ApiOntapVersion version,
    DateTime lastConnected,
  }) {
    return ApiOntapCluster._private(
      uuid,
      name,
      contact,
      location,
      isAsa,
      version,
      lastConnected,
    );
  }

  factory ApiOntapCluster.fromMap(Map<String, dynamic> json) {
    print('ApiOntapCluster.fromMap beginning');
    final String name = json['name'];
    final String uuid = json['uuid'];
    final String contact = json['contact'];
    final String location = json['location'];
    final bool isAsa = json['san_optimized'] ?? false;
    final ApiOntapVersion version = ApiOntapVersion.fromMap(json['version']);
    // covering the case where the input is coming from both persistent storage
    //  and from an API call
    final DateTime lastConnected = DateTime.parse(
      json['lastConnected'] ?? DateTime.now().toString(),
    );
    print('ApiOntapCluster.fromMap ending');
    return ApiOntapCluster(
      uuid: uuid,
      contact: contact,
      location: location,
      name: name,
      isAsa: isAsa,
      version: version,
      lastConnected: lastConnected,
    );
  }
  //
  // syntactic sugar for use where this constructor must be provided
  static final constructFromMap =
      (Map<String, dynamic> map) => ApiOntapCluster.fromMap(map);
}
