//
// a class to represent an ONTAP API, the specific method and any parameters
//  the associated data-model for the exxpected response is also provided via a generic

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_api/api_parameter.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';

class OntapApi<T extends StorableItem> extends StorableItem {
  static const _ontapApiPath = '/api/';

  /// the ONTAP API method name - must match the actual names in ONTAP 9.6+
  final String name;
  String get id => method.name + ' ' + name;

  //
  Map<String, dynamic> get toMap => {
        'name': name,
        'method': method.name,
        'parameters': parameterMap,
      };

  /// the type of data this API will return in a successful response
  Type get responseModel => T;

  /// the HTTP method to use
  final ApiMethod method;

  /// a subset of the valid parameters
  final Set<ApiParameter> parameters;

  OntapApi._private(
    this.name,
    this.method,
    this.parameters,
  );
  factory OntapApi({
    @required String name,
    ApiMethod method = ApiMethod.get,
    Set<ApiParameter> parameters,
  }) {
    return OntapApi._private(
      name,
      method,
      parameters ??
          // the default parameters - good for most GET's
          {
            ApiParameter<bool>(name: 'return_records', defaultValue: true),
            ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
            ApiParameter<String>(name: 'fields', defaultValue: '*'),
          },
    );
  }
  //
  // convenience getter for building the URL
  String get path => _ontapApiPath + name;
  //
  Map<String, dynamic> get parameterMap {
    final Map<String, dynamic> pMap = {};
    parameters.forEach((p) => pMap[p.name] = p.value.toString());
    return pMap;
  }
}
