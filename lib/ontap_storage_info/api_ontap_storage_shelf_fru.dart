//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_fru_state.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_fru_type.dart';

class ApiOntapStorageShelfFru {
  ApiOntapStorageShelfFru._private({
    this.firmwareVersion,
    this.id,
    this.partNumber,
    this.serialNumber,
    this.state,
    this.type,
  });

  final String firmwareVersion;
  final int id;
  final String partNumber;
  final String serialNumber;
  final ApiOntapStorageShelfFruState state;
  final ApiOntapStorageShelfFruType type;

  factory ApiOntapStorageShelfFru.fromMap(Map<String, dynamic> json) =>
      json != null
          ? ApiOntapStorageShelfFru._private(
              firmwareVersion: json["firmware_version"],
              id: json["id"],
              partNumber: json["part_number"],
              serialNumber: json["serial_number"],
              state:
                  ApiOntapStorageShelfFruStateMembers.fromName(json["state"]),
              type: ApiOntapStorageShelfFruTypeMembers.fromName(json["type"]),
            )
          : null;

  Map<String, dynamic> get toMap => {
        "firmware_version": firmwareVersion,
        "id": id,
        "part_number": partNumber,
        "serial_number": serialNumber,
        "state": state?.name,
        "type": type?.name,
      };
}
