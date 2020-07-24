//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_shelf_drawer_state.dart';

class ApiOntapStorageShelfDrawer {
  ApiOntapStorageShelfDrawer({
    this.closed,
    this.diskCount,
    this.error,
    this.id,
    this.partNumber,
    this.serialNumber,
    this.state,
  });

  final bool closed;
  final int diskCount;
  final String error;
  final int id;
  final String partNumber;
  final String serialNumber;
  final ApiOntapStorageShelfDrawerState state;

  factory ApiOntapStorageShelfDrawer.fromMap(Map<String, dynamic> json) =>
      ApiOntapStorageShelfDrawer(
        closed: json["closed"] ?? false,
        diskCount: json["disk_count"],
        error: json["error"],
        id: json["id"],
        partNumber: json["part_number"],
        serialNumber: json["serial_number"],
        state: json["state"] == null
            ? null
            : ApiOntapStorageShelfDrawerStateMembers.fromName(json["state"]),
      );

  Map<String, dynamic> get toMap => {
        "closed": closed ?? false,
        "disk_count": diskCount,
        "error": error,
        "id": id,
        "part_number": partNumber,
        "serial_number": serialNumber,
        "state": state?.name,
      };
}
