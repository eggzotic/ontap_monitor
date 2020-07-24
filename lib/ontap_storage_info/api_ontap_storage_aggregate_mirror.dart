//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate_mirror_state.dart';

class ApiOntapStorageAggregateMirror {
  ApiOntapStorageAggregateMirror({
    this.enabled,
    this.state,
  });

  final bool enabled;
  final ApiOntapStorageAggregateMirrorState state;

  factory ApiOntapStorageAggregateMirror.fromMap(Map<String, dynamic> json) =>
      ApiOntapStorageAggregateMirror(
        enabled: json["enabled"],
        state: json["state"] == null
            ? null
            : ApiOntapStorageAggregateMirrorStateMembers.fromName(
                json["state"]),
      );

  Map<String, dynamic> get toMap => {
        "enabled": enabled,
        "state": state?.name,
      };
}
