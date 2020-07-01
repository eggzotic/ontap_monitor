//
// a class to wrap Ontap API's, their response data-models and
// constructor-from-map (i.e. from JSON.decode)

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/data_item.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api/api_parameter.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_response.dart';

class OntapApi<T extends DataItem> extends DataItem {
  static const _ontapApiPath = '/api/';

  /// the ONTAP API method name - must match the actual names in ONTAP 9.6+
  final String name;
  String get id => name + '+' + method.name;
  // placeholder, to satisfy the DataItem interface
  //  since we're not (yet) storing these persistently
  Map<String, dynamic> get toMap => {};

  /// a function to convert a map into an instance of data-model
  final T Function(Map<String, dynamic>) fromMap;

  ///
  Type get responseModel => T;

  /// the HTTP method to use
  final ApiMethod method;

  /// a subset of the valid parameters
  final Set<ApiParameter> parameters;
  //
  OntapApi._private(
    this.name,
    this.method,
    this.fromMap,
    this.parameters,
  );
  factory OntapApi._named({
    @required String name,
    ApiMethod method = ApiMethod.get,
    @required T Function(Map<String, dynamic>) fromMap,
    @required Set<ApiParameter> parameters,
  }) {
    return OntapApi._private(name, method, fromMap, parameters);
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

  //
  static final List<OntapApi> _allApis = [
    OntapApi<ApiOntapCluster>._named(
      name: 'cluster',
      fromMap: (map) => ApiOntapCluster.fromMap(map),
      parameters: Set.from(
        [
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
        ],
      ),
    ),
    OntapApi<ApiOntapLicenseResponse>._named(
      name: 'cluster/licensing/licenses',
      fromMap: (map) => ApiOntapLicenseResponse.fromMap(map),
      parameters: Set.from([
        ApiParameter<String>(name: 'fields', defaultValue: '*'),
        ApiParameter<bool>(name: 'return_records', defaultValue: true),
        ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
      ]),
    ),
  ];
  //
  static bool _builtinsAdded = false;
  static void addBuiltins(DataStore<OntapApi> dataStore) {
    if (_builtinsAdded) return;
    _allApis.forEach(
      (api) {
        print('Begin add API ${api.name}, ${api.id}');
        dataStore.add(
          api,
          storeNow: false,
          neverStore: true,
        );
      },
    );
    _builtinsAdded = true;
  }

  //
  // factory constructor to simply pick the pre-existing API from the above Map
  factory OntapApi.forId(String id) {
    // _allApis.forEach((api) {
    //   print('OntapApi.forId: APIs = ${api.name}, ${api.id}');
    // });
    return _allApis.firstWhere((api) => api.id == id, orElse: () => null);
  }
  // bool existsForName(String name) => _allApis.containsKey(name) != null;
  //
  // bool hasParameterName(String name) => parameters.any((p) => p.name == name);
  // bool hasParameter(ApiParameter parameter) =>
  //     parameters.any((p) => p.name == parameter.name);
  // List<String> get names {
  //   final apiNames = _allApis.keys.toList();
  //   apiNames.sort();
  //   return apiNames;
  // }
}
