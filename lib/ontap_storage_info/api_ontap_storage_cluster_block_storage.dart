//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_media.dart';

class ApiOntapStorageClusterBlockStorage {
  ApiOntapStorageClusterBlockStorage._private({
    this.used,
    this.size,
    this.inactiveData,
    this.medias,
  });

  final int used;
  final int size;
  final int inactiveData;
  final List<ApiOntapStorageClusterMedia> medias;

  factory ApiOntapStorageClusterBlockStorage.fromMap(
          Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageClusterBlockStorage._private(
              used: json["used"],
              size: json["size"],
              inactiveData: json["inactive_data"],
              medias: json["medias"]
                  ?.map((x) => ApiOntapStorageClusterMedia.fromMap(x))
                  ?.toList(),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "used": used,
        "size": size,
        "inactive_data": inactiveData,
        "medias": medias?.map((x) => x?.toMap)?.toList(),
      };
}
