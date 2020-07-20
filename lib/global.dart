// //
// // This class is to overcome shortcomings in the Dart coverage of
// //  generics, where statics and Constructors cannot be mentioned
// //
// import 'package:ontap_monitor/cluster_credentials/cluster_credentials.dart';
// import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_aggregate.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_cluster.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_network_ethernet_port.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_license_package.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_multi_record_response.dart';
// import 'package:ontap_monitor/ontap_api_models/api_ontap_node.dart';
// import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';

// class Global {
//   static Global _global;
//   // This Singleton is used by many of the data-model classes, where Providers
//   //  cannot be used due to lack of build-context
//   static Global shared() {
//     _global ??= Global();
//     return _global;
//   }

//   final Map<Type, Function(Map<String, dynamic>)> _multiRecordConstructor = {
//     ApiOntapLicensePackage: (map) =>
//         ApiOntapMultiRecordResponse<ApiOntapLicensePackage>.fromMap(map),
//     ApiOntapNode: (map) =>
//         ApiOntapMultiRecordResponse<ApiOntapNode>.fromMap(map),
//     ApiOntapNetworkEthernetPort: (map) =>
//         ApiOntapMultiRecordResponse<ApiOntapNetworkEthernetPort>.fromMap(map),
//   };

//   Function(Map<String, dynamic>) multiRecordConstructor({Type recordType}) {
//     return _multiRecordConstructor[recordType];
//   }

//   final Map<Type, Function(Map<String, dynamic>)> _mapConstructor = {
//     ApiOntapCluster: (map) => ApiOntapCluster.fromMap(map),
//     ApiOntapAggregate: (map) => ApiOntapAggregate.fromMap(map),
//     ClusterCredentials: (map) => ClusterCredentials.fromMap(map),
//     OntapAction: (map) => OntapAction.fromMap(map),
//     OntapCluster: (map) => OntapCluster.fromMap(map),
//     ApiOntapLicensePackage: (map) => ApiOntapLicensePackage.fromMap(map),
//     ApiOntapNode: (map) => ApiOntapNode.fromMap(map),
//     ApiOntapNetworkEthernetPort: (map) =>
//         ApiOntapNetworkEthernetPort.fromMap(map),
//   };
//   //
//   Function(Map<String, dynamic>) mapConstructor({
//     Type itemType,
//     Type recordType,
//   }) {
//     // since we cannot use a type literal such as ApiOntapMultiRecordResponse<ApiOntapLicensePackage>
//     // as a Map key, or even as a switch case, we need to do something like this, sigh...
//     switch (recordType) {
//       case ApiOntapLicensePackage:
//       case ApiOntapNode:
//       case ApiOntapNetworkEthernetPort:
//         return _mapConstructor[recordType];
//     }
//     return _mapConstructor[itemType];
//   }

//   final Map<Type, String> _idPrefix = {
//     ApiOntapCluster: 'api-ontap-cluster_',
//     OntapAction: 'ontap-action_',
//     OntapCluster: 'ontap-cluster_',
//     ClusterCredentials: 'cluster-credential_',
//     ApiOntapAggregate: 'api-ontap-aggregate_';
//     // below here these will be used with multi-record responses
//     ApiOntapLicensePackage: 'api-ontap-license-response_',
//     ApiOntapNode: 'api-ontap-node-response_',
//     ApiOntapNetworkEthernetPort: 'api-ontap-network-ethernet-port-response_',
//   };
//   String idPrefix({Type itemType, Type recordType}) {
//     assert(itemType != null || recordType != null);
//     print('idPrefix itemType = $itemType');
//     print('idPrefix recordType = $recordType');
//     return _idPrefix[recordType ?? itemType];
//   }
// }
