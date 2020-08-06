//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//

import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_ad_domain.dart';

class ApiOntapSvmCifs {
  ApiOntapSvmCifs({
    this.adDomain,
    this.enabled,
    this.name,
  });

  final ApiOntapSvmAdDomain adDomain;
  final bool enabled;
  final String name;

  factory ApiOntapSvmCifs.fromMap(Map<String, dynamic> json) => ApiOntapSvmCifs(
        adDomain: json["ad_domain"] == null
            ? null
            : ApiOntapSvmAdDomain.fromMap(json["ad_domain"]),
        enabled: json["enabled"],
        name: json["name"],
      );

  Map<String, dynamic> get toMap => {
        "ad_domain": adDomain?.toMap,
        "enabled": enabled,
        "name": name,
      };
}
