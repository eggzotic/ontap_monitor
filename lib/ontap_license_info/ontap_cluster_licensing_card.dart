import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/refresh_results_tile.dart';
import 'package:provider/provider.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_scope.dart';

class OntapClusterLicensingCard extends StatelessWidget {
  OntapClusterLicensingCard({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  @override
  Widget build(BuildContext context) {
    final licenses = Provider.of<List<ApiOntapLicensePackage>>(context);

    if (licenses == null || licenses.isEmpty)
      return Card(
        child: ListTile(
          title: Text('Oops, no result found!'),
          trailing: Icon(Icons.error_outline),
        ),
      );

    final lastUpdated = licenses.first.lastUpdated;

    return Card(
      child: ExpansionTile(
        onExpansionChanged: (open) => print(open ? "opening" : "closing"),
        key: PageStorageKey('Cluster Licenses'),
        title: Text('Cluster Licenses (${licenses.length})'),
        subtitle: Text(
          'Last updated: ' + lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ...licenses.map(
            (package) => ExpansionTile(
              key: PageStorageKey(package.name),
              title: Text(package.name),
              leading: package.state == ApiOntapLicenseComplianceState.compliant
                  ? Icon(Icons.check, color: Colors.green)
                  : Icon(Icons.warning, color: Colors.red),
              subtitle: Text(package.scope.name),
              children: package.licenses
                  .map(
                    (lic) => ListTile(
                      isThreeLine: true,
                      leading: lic.complianceState ==
                              ApiOntapLicenseComplianceState.compliant
                          ? Icon(Icons.check, color: Colors.green)
                          : Icon(Icons.warning, color: Colors.red),
                      title: Text(lic.owner),
                      trailing: Text(lic.active ? 'Active' : 'Inactive'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(lic.serialNumber),
                          if (lic.evaluation)
                            Text(lic.expiryTime
                                .toIso8601String()
                                .substring(0, 10))
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
