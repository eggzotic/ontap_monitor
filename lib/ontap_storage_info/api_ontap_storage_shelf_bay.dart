//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_bay_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_bay_type.dart';

class ApiOntapStorageShelfBay {
  ApiOntapStorageShelfBay._private({
    this.hasDisk,
    this.id,
    this.state,
    this.type,
  });

  final bool hasDisk;
  final int id;
  final ApiOntapStorageShelfBayState state;
  final ApiOntapStorageShelfBayType type;

  factory ApiOntapStorageShelfBay.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelfBay._private(
              hasDisk: json["has_disk"] ?? false,
              id: json["id"],
              state:
                  ApiOntapStorageShelfBayStateMembers.fromName(json["state"]),
              type: ApiOntapStorageShelfBayTypeMembers.fromName(json["type"]),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "has_disk": hasDisk ?? false,
        "id": id,
        "state": state?.name,
        "type": type?.name,
      };
}
