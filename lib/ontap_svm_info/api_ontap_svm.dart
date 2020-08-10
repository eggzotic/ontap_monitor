//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

import 'package:ontap_monitor/api_ontap_fc/api_ontap_fc_interface.dart';
import 'package:ontap_monitor/api_ontap_snapshot/api_ontap_snapshot_policy.dart';
import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_interface.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ipspace.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_certificate.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_nfs.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_cifs.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_dns.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_fcp.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_iscsi.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_language.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_ldap.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_nis.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_nsswitch.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_nvme.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_s3.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_snapmirror.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_state.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_subtype.dart';

class ApiOntapSvm extends StorableItem {
  ApiOntapSvm._private({
    this.aggregates,
    this.aggregatesDelegated,
    this.certificate,
    this.cifs,
    this.comment,
    this.dns,
    this.fcInterfaces,
    this.fcp,
    this.ipInterfaces,
    this.ipspace,
    this.iscsi,
    this.language,
    this.ldap,
    this.name,
    this.nfs,
    this.nis,
    this.nsswitch,
    this.nvme,
    this.s3,
    this.snapmirror,
    this.snapshotPolicy,
    this.state,
    this.subtype,
    this.uuid,
    DateTime lastUpdated,
  }) : super(lastUpdated: lastUpdated);

  @override
  String ownerId;
  @override
  String get id => ownerId + '_' + uuid;
  final List<ApiOntapStorageAggregate> aggregates;
  final bool aggregatesDelegated;
  final ApiOntapCertificate certificate;
  final ApiOntapSvmCifs cifs;
  final String comment;
  final ApiOntapSvmDns dns;
  final List<ApiOntapFcInterface> fcInterfaces;
  final ApiOntapSvmFcp fcp;
  final List<ApiOntapNetworkInterface> ipInterfaces;
  final ApiOntapNetworkIpspace ipspace;
  final ApiOntapSvmIscsi iscsi;
  final ApiOntapSvmLanguage language;
  final ApiOntapSvmLdap ldap;
  final String name;
  final ApiOntapSvmNfs nfs;
  final ApiOntapSvmNis nis;
  final ApiOntapSvmNsswitch nsswitch;
  final ApiOntapSvmNvme nvme;
  final ApiOntapSvmS3 s3;
  final ApiOntapSvmSnapmirror snapmirror;
  final ApiOntapSnapshotPolicy snapshotPolicy;
  final ApiOntapSvmState state;
  final ApiOntapSvmSubtype subtype;
  final String uuid;

  factory ApiOntapSvm.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapSvm._private(
          aggregates: json["aggregates"]
              ?.map((x) => ApiOntapStorageAggregate.fromMap(x))
              ?.toList(),
          aggregatesDelegated: json["aggregates_delegated"],
          certificate: ApiOntapCertificate.fromMap(json["certificate"]),
          cifs: ApiOntapSvmCifs.fromMap(json["cifs"]),
          comment: json["comment"],
          dns: ApiOntapSvmDns.fromMap(json["dns"]),
          fcInterfaces: json["fc_interfaces"]
              ?.map((x) => ApiOntapFcInterface.fromMap(x))
              ?.toList(),
          fcp: ApiOntapSvmFcp.fromMap(json["fcp"]),
          ipInterfaces: json["ip_interfaces"]
              ?.map((x) => ApiOntapNetworkInterface.fromMap(x))
              ?.toList(),
          ipspace: ApiOntapNetworkIpspace.fromMap(json["ipspace"]),
          iscsi: ApiOntapSvmIscsi.fromMap(json["iscsi"]),
          language: ApiOntapSvmLanguageMembers.fromName(json["language"]),
          ldap: ApiOntapSvmLdap.fromMap(json["ldap"]),
          name: json["name"],
          nfs: ApiOntapSvmNfs.fromMap(json["nfs"]),
          nis: ApiOntapSvmNis.fromMap(json["nis"]),
          nsswitch: ApiOntapSvmNsswitch.fromMap(json["nsswitch"]),
          nvme: ApiOntapSvmNvme.fromMap(json["nvme"]),
          s3: ApiOntapSvmS3.fromMap(json["s3"]),
          snapmirror: ApiOntapSvmSnapmirror.fromMap(json["snapmirror"]),
          snapshotPolicy:
              ApiOntapSnapshotPolicy.fromMap(json["snapshot_policy"]),
          state: ApiOntapSvmStateMembers.fromName(json["state"]),
          subtype: ApiOntapSvmSubtypeMembers.fromName(json["subtype"]),
          uuid: json["uuid"],
        )
      : null;

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "aggregates": aggregates?.map((x) => x?.toMap)?.toList(),
        "aggregates_delegated": aggregatesDelegated,
        "certificate": certificate?.toMap,
        "cifs": cifs?.toMap,
        "comment":  comment,
        "dns": dns?.toMap,
        "fc_interfaces": fcInterfaces?.map((x) => x?.toMap)?.toList(),
        "fcp": fcp?.toMap,
        "ip_interfaces": ipInterfaces.map((x) => x?.toMap).toList(),
        "ipspace": ipspace?.toMap,
        "iscsi": iscsi?.toMap,
        "language": language?.name,
        "ldap": ldap?.toMap,
        "name": name,
        "nfs": nfs?.toMap,
        "nis": nis?.toMap,
        "nsswitch": nsswitch?.toMap,
        "nvme": nvme?.toMap,
        "s3": s3?.toMap,
        "snapmirror": snapmirror?.toMap,
        "snapshot_policy": snapshotPolicy?.toMap,
        "state": state?.name,
        "subtype": subtype?.name,
        "uuid": uuid,
        'lastUpdated': lastUpdated?.toIso8601String(),
      };
}
