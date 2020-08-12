//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';

class ApiRawResponse extends StorableItem {
  final String rawJson;
  final String actionId;
  @override
  String get name => id;
  @override
  final String ownerId;
  @override
  String get id => ownerId + ' ' + actionId;
  //
  ApiRawResponse._private({
    this.rawJson,
    this.ownerId,
    this.actionId,
  });
  //
  // used when loading a stored/cached entry
  factory ApiRawResponse.fromMap(Map<String, dynamic> json) {
    if (json == null) return null;
    return ApiRawResponse._private(
      rawJson: json['rawJson'],
      actionId: json['actionId'],
      ownerId: json['ownerId'],
    );
  }
  //
  // used when creating an instnace from an API response
  factory ApiRawResponse.fromJson(
    String rawJson, {
    String actionId,
    String ownerId,
  }) {
    if (rawJson == null) return null;
    return ApiRawResponse._private(
      rawJson: rawJson,
      actionId: actionId,
      ownerId: ownerId,
    );
  }
  //
  @override
  Map<String, dynamic> get toMap => {
        'actionId': actionId,
        'ownerId': ownerId,
        'rawJson': rawJson,
      };
  //
  // for use when calculating the expected ID of an instance from a given cluster & action
  // it must match the instance getter above, in order to maintain integrity!
  static String idForClusterAction({
    @required OntapCluster cluster,
    @required OntapAction action,
  }) =>
      cluster.id + ' ' + action.id;
}
