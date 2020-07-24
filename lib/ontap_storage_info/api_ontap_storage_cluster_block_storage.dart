//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_cluster_media.dart';

class ApiOntapStorageClusterBlockStorage {
  ApiOntapStorageClusterBlockStorage({
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
      ApiOntapStorageClusterBlockStorage(
        used: json["used"],
        size: json["size"],
        inactiveData: json["inactive_data"],
        medias: List.from(json["medias"])
            ?.map((x) => ApiOntapStorageClusterMedia.fromMap(x))
            ?.toList(),
      );

  Map<String, dynamic> get toMap => {
        "used": used,
        "size": size,
        "inactive_data": inactiveData,
        "medias": medias?.map((x) => x?.toMap)?.toList(),
      };
}
