class ApiOntapSvmLdap {
  ApiOntapSvmLdap._private({
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

  factory ApiOntapSvmLdap.fromMap(Map<String, dynamic> json) => json != null
      ? ApiOntapSvmLdap._private(
          adDomain: json["ad_domain"],
          baseDn: json["base_dn"],
          bindDn: json["bind_dn"],
          enabled: json["enabled"],
          servers: json["servers"]?.map<String>((x) => x.toString())?.toList(),
        )
      : null;

  Map<String, dynamic> get toMap => {
        "ad_domain": adDomain,
        "base_dn": baseDn,
        "bind_dn": bindDn,
        "enabled": enabled,
        "servers": servers?.map<String>((x) => x)?.toList(),
      };
}
