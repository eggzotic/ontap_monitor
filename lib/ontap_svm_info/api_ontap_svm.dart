//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

import 'package:ontap_monitor/data_storage/storable_item.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ip.dart';
import 'package:ontap_monitor/ontap_network_info/api_ontap_network_ipspace.dart';
import 'package:ontap_monitor/ontap_storage_info/api_ontap_storage_aggregate.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_certificate.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_cifs.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_dns.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_fcp.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_language.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_snapmirror.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_state.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_subtype.dart';

class ApiOntapSvm extends StorableItem {
  ApiOntapSvm({
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
  final List<ApiOntapSvmFcInterfaces> fcInterfaces;
  final ApiOntapSvmFcp fcp;
  final List<IpInterface> ipInterfaces;
  final ApiOntapNetworkIpspace ipspace;
  final ApiOntapSvmIscsi iscsi;
  final ApiOntapSvmLanguage language;
  final Ldap ldap;
  final String name;
  final ApiOntapSvmNfs nfs;
  final Nis nis;
  final Nsswitch nsswitch;
  final ApiOntapSvmNvme nvme;
  final ApiOntapSvmCifs s3;
  final ApiOntapSvmSnapmirror snapmirror;
  final ApiOntapSnapshotPolicy snapshotPolicy;
  final ApiOntapSvmState state;
  final ApiOntapSvmSubtype subtype;
  final String uuid;

  factory ApiOntapSvm.fromMap(Map<String, dynamic> json) => ApiOntapSvm(
        aggregates: json["aggregates"]
            ?.map((x) => ApiOntapStorageAggregate.fromMap(x))
            ?.toList(),
        aggregatesDelegated: json["aggregates_delegated"],
        certificate: json["certificate"] == null
            ? null
            : ApiOntapCertificate.fromMap(json["certificate"]),
        cifs:
            json["cifs"] == null ? null : ApiOntapSvmCifs.fromMap(json["cifs"]),
        comment: json["comment"],
        dns: json["dns"] == null ? null : ApiOntapSvmDns.fromMap(json["dns"]),
        fcInterfaces: json["fc_interfaces"] == null
            ? null
            : List<ApiOntapNetworkIpspace>.from(json["fc_interfaces"]
                .map((x) => ApiOntapNetworkIpspace.fromMap(x))),
        fcp: json["fcp"] == null ? null : ApiOntapSvmFcp.fromMap(json["fcp"]),
        ipInterfaces: json["ip_interfaces"] == null
            ? null
            : List<IpInterface>.from(
                json["ip_interfaces"].map((x) => IpInterface.fromMap(x))),
        ipspace: json["ipspace"] == null
            ? null
            : ApiOntapNetworkIpspace.fromMap(json["ipspace"]),
        iscsi: json["iscsi"] == null
            ? null
            : ApiOntapSvmFcp.fromMap(json["iscsi"]),
        language: json["language"] == null
            ? null
            : ApiOntapSvmLanguageMembers.fromName(json["language"]),
        ldap: json["ldap"] == null ? null : Ldap.fromMap(json["ldap"]),
        name: json["name"],
        nfs: json["nfs"] == null ? null : ApiOntapSvmFcp.fromMap(json["nfs"]),
        nis: json["nis"] == null ? null : Nis.fromMap(json["nis"]),
        nsswitch: json["nsswitch"] == null
            ? null
            : Nsswitch.fromMap(json["nsswitch"]),
        nvme:
            json["nvme"] == null ? null : ApiOntapSvmFcp.fromMap(json["nvme"]),
        s3: json["s3"] == null ? null : ApiOntapSvmCifs.fromMap(json["s3"]),
        snapmirror: json["snapmirror"] == null
            ? null
            : Snapmirror.fromMap(json["snapmirror"]),
        snapshotPolicy: json["snapshot_policy"] == null
            ? null
            : ApiOntapNetworkIpspace.fromMap(json["snapshot_policy"]),
        state: json["state"] == null
            ? null
            : ApiOntapSvmStateMembers.fromName(json["state"]),
        subtype: json["subtype"] == null
            ? null
            : ApiOntapSvmSubtypeMembers.fromName(json["subtype"]),
        uuid: json["uuid"] == null ? null : json["uuid"],
      );

  Map<String, dynamic> get toMap => {
        'ownerId': ownerId,
        "aggregates": aggregates?.map((x) => x?.toMap)?.toList(),
        "aggregates_delegated": aggregatesDelegated,
        "certificate": certificate?.toMap,
        "cifs": cifs?.toMap,
        "comment": comment == null ? null : comment,
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
        'lastUpdated': lastUpdated.toIso8601String(),
      };
}


class IpInterface {
  IpInterface({
    this.ip,
    this.name,
    this.services,
    this.uuid,
  });

  final ApiOntapNetworkIp ip;
  final String name;
  final List<String> services;
  final String uuid;

  factory IpInterface.fromMap(Map<String, dynamic> json) => IpInterface(
        ip: json["ip"] == null ? null : ApiOntapNetworkIp.fromMap(json["ip"]),
        name: json["name"],
        services: json["services"] == null
            ? null
            : List<String>.from(json["services"].map((x) => x)),
        uuid: json["uuid"],
      );

  Map<String, dynamic> get toMap => {
        "ip": ip?.toMap,
        "name": name == null ? null : name,
        "services": services == null
            ? null
            : List<dynamic>.from(services.map((x) => x)),
        "uuid": uuid == null ? null : uuid,
      };
}

class Ldap {
  Ldap({
    this.adDomain,
    this.baseDn,
    this.bindDn,
    this.enabled,
    this.servers,
  });

  final String adDomain;
  final String baseDn;
  final String bindDn;
  final bool enabled;
  final List<String> servers;

  factory Ldap.fromMap(Map<String, dynamic> json) => Ldap(
        adDomain: json["ad_domain"] == null ? null : json["ad_domain"],
        baseDn: json["base_dn"] == null ? null : json["base_dn"],
        bindDn: json["bind_dn"] == null ? null : json["bind_dn"],
        enabled: json["enabled"] == null ? null : json["enabled"],
        servers: json["servers"] == null
            ? null
            : List<String>.from(json["servers"].map((x) => x)),
      );

  Map<String, dynamic> get toMap => {
        "ad_domain": adDomain == null ? null : adDomain,
        "base_dn": baseDn == null ? null : baseDn,
        "bind_dn": bindDn == null ? null : bindDn,
        "enabled": enabled == null ? null : enabled,
        "servers":
            servers == null ? null : List<dynamic>.from(servers.map((x) => x)),
      };
}

class Nis {
  Nis({
    this.domain,
    this.enabled,
    this.servers,
  });

  final String domain;
  final bool enabled;
  final List<String> servers;

  factory Nis.fromMap(Map<String, dynamic> json) => Nis(
        domain: json["domain"],
        enabled: json["enabled"],
        servers: json["servers"]?.map((x) => x)?.toList(),
      );

  Map<String, dynamic> get toMap => {
        "domain": domain,
        "enabled": enabled,
        "servers": servers?.map((x) => x)?.toList(),
      };
}

class Nsswitch {
  Nsswitch({
    this.group,
    this.hosts,
    this.namemap,
    this.netgroup,
    this.passwd,
  });

  final List<String> group;
  final List<String> hosts;
  final List<String> namemap;
  final List<String> netgroup;
  final List<String> passwd;

  factory Nsswitch.fromMap(Map<String, dynamic> json) => Nsswitch(
        group: json["group"]?.map((x) => x)?.toList(),
        hosts: json["hosts"]?.map((x) => x)?.toList(),
        namemap: json["namemap"]?.map((x) => x)?.toList(),
        netgroup: json["netgroup"]?.map((x) => x)?.toList(),
        passwd: json["passwd"]?.map((x) => x)?.toList(),
      );

  Map<String, dynamic> get toMap => {
        "group": group?.map((x) => x)?.toList(),
        "hosts": hosts?.map((x) => x)?.toList(),
        "namemap": namemap == namemap?.map((x) => x)?.toList(),
        "netgroup": netgroup?.map((x) => x)?.toList(),
        "passwd": passwd?.map((x) => x)?.toList(),
      };
}



class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
