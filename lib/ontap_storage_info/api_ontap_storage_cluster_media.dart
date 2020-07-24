//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_efficiency.dart';

class ApiOntapStorageClusterMedia {
  ApiOntapStorageClusterMedia({
    this.type,
    this.size,
    this.available,
    this.used,
    this.efficiency,
  });

  final String type;
  final int size;
  final int available;
  final int used;
  final ApiOntapStorageClusterEfficiency efficiency;

  factory ApiOntapStorageClusterMedia.fromMap(Map<String, dynamic> json) =>
      ApiOntapStorageClusterMedia(
        type: json["type"],
        size: json["size"],
        available: json["available"],
        used: json["used"],
        efficiency: json["efficiency"] == null
            ? null
            : ApiOntapStorageClusterEfficiency.fromMap(json["efficiency"]),
      );

  Map<String, dynamic> get toMap => {
        "type": type,
        "size": size,
        "available": available,
        "used": used,
        "efficiency": efficiency?.toMap,
      };
}
