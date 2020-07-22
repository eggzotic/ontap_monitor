import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_bay_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_bay_type.dart';

class ApiOntapStorageShelfBay {
  ApiOntapStorageShelfBay({
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
      ApiOntapStorageShelfBay(
        hasDisk: json["has_disk"] ?? false,
        id: json["id"],
        state: json["state"] == null
            ? null
            : ApiOntapStorageShelfBayStateMembers.fromName(json["state"]),
        type: json["type"] == null
            ? null
            : ApiOntapStorageShelfBayTypeMembers.fromName(json["type"]),
      );

  Map<String, dynamic> get toMap => {
        "has_disk": hasDisk ?? false,
        "id": id,
        "state": state?.name,
        "type": type?.name,
      };
}
