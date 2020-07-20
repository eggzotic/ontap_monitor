//
// a class to wrap Ontap API's, their response data-models and
// constructor-from-map (i.e. from JSON.decode)

import 'package:flutter/foundation.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/ontap_api/api_parameter.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';
import 'package:ontap_monitor/ontap_cluster_info/api_ontap_cluster.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ethernet_port.dart';
import 'package:ontap_monitor/ontap_node_info/api_ontap_node.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_disk.dart';

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
  // final Type responseRecordType;

  /// the HTTP method to use
  final ApiMethod method;

  /// a subset of the valid parameters
  final Set<ApiParameter> parameters;

  /// indicates whether this API typically returns multiple records
  // final bool isMulti;
  //
  OntapApi._private(
    this.name,
    this.method,
    this.parameters,
  );
  factory OntapApi._named({
    @required String name,
    ApiMethod method = ApiMethod.get,
    @required Set<ApiParameter> parameters,
    Type responseRecordType,
  }) {
    return OntapApi._private(
      name,
      method,
      parameters,
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

  //
  // never delete/insert - append-only here - so that the builtin IDs
  //  will remain consistent across invocations
  static final List<OntapApi> _allApis = [
    OntapApi<ApiOntapCluster>._named(
      name: 'cluster',
      method: ApiMethod.get,
      parameters: Set.from(
        [
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
        ],
      ),
    ),
    OntapApi<ApiOntapLicensePackage>._named(
      responseRecordType: ApiOntapLicensePackage,
      name: 'cluster/licensing/licenses',
      method: ApiMethod.get,
      parameters: Set.from(
        [
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
        ],
      ),
    ),
    OntapApi<ApiOntapNode>._named(
      responseRecordType: ApiOntapNode,
      name: 'cluster/nodes',
      method: ApiMethod.get,
      parameters: Set.from(
        [
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
        ],
      ),
    ),
    OntapApi<ApiOntapNetworkEthernetPort>._named(
      responseRecordType: ApiOntapNetworkEthernetPort,
      name: 'network/ethernet/ports',
      method: ApiMethod.get,
      parameters: Set.from(
        [
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
        ],
      ),
    ),
    OntapApi<ApiOntapStorageDisk>._named(
      name: 'storage/disks',
      parameters: Set.from(
        [
          ApiParameter<String>(name: 'fields', defaultValue: '*'),
          ApiParameter<bool>(name: 'return_records', defaultValue: true),
          ApiParameter<int>(name: 'return_timeout', defaultValue: 15),
        ],
      ),
    ),
  ];
  //
  static bool _builtinsAdded = false;
  static void addBuiltins(ItemStore<OntapApi> dataStore) {
    if (_builtinsAdded) return;
    _allApis.forEach(
      (api) {
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
  // factory constructor to simply pick the pre-existing API from the above
  factory OntapApi.forId(String id) =>
      _allApis.firstWhere((api) => api.id == id, orElse: () => null);
}
