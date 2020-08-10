//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_nsswitch_source.dart';

class ApiOntapSvmNsswitch {
  ApiOntapSvmNsswitch._private({
    this.group,
    this.hosts,
    this.namemap,
    this.netgroup,
    this.passwd,
  });

  final List<ApiOntapSvmNsswitchSource> group;
  final List<ApiOntapSvmNsswitchSource> hosts;
  final List<ApiOntapSvmNsswitchSource> namemap;
  final List<ApiOntapSvmNsswitchSource> netgroup;
  final List<ApiOntapSvmNsswitchSource> passwd;

  factory ApiOntapSvmNsswitch.fromMap(Map<String, dynamic> json) =>
      ApiOntapSvmNsswitch._private(
        group: json["group"]
            ?.map((x) => ApiOntapSvmNsswitchSourceMembers.fromName(x))
            ?.toList(),
        hosts: json["hosts"]
            ?.map((x) => ApiOntapSvmNsswitchSourceMembers.fromName(x))
            ?.toList(),
        namemap: json["namemap"]
            ?.map((x) => ApiOntapSvmNsswitchSourceMembers.fromName(x))
            ?.toList(),
        netgroup: json["netgroup"]
            ?.map((x) => ApiOntapSvmNsswitchSourceMembers.fromName(x))
            ?.toList(),
        passwd: json["passwd"]
            ?.map((x) => ApiOntapSvmNsswitchSourceMembers.fromName(x))
            ?.toList(),
      );

  Map<String, dynamic> get toMap => {
        "group": group?.map((x) => x?.name)?.toList(),
        "hosts": hosts?.map((x) => x?.name)?.toList(),
        "namemap": namemap?.map((x) => x?.name)?.toList(),
        "netgroup": netgroup?.map((x) => x?.name)?.toList(),
        "passwd": passwd?.map((x) => x?.name)?.toList(),
      };
}
