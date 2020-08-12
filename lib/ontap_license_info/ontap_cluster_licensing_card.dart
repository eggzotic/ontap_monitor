//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/show_api_results_button.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_package.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:provider/provider.dart';
import 'package:ontap_monitor/ontap_license_info/api_ontap_license_scope.dart';

class OntapClusterLicensingCard extends StatelessWidget {
  OntapClusterLicensingCard({
    Key key,
    @required this.toRefresh,
    @required this.toReset,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;

  /// [toReset] is a callback that should reset any previous error condition
  ///  which should trigger the tile to be reset to it's original state, ready
  ///  for a re-run
  final void Function() toReset;
  //
  @override
  Widget build(BuildContext context) {
    final licenses = Provider.of<List<ApiOntapLicensePackage>>(context);
    if (licenses.isEmpty) return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = licenses.first.lastUpdated;

    return Card(
      child: ExpansionTile(
        key: PageStorageKey('Cluster Licenses'),
        leading: ShowApiResultsButton(),
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
                  ? FaIcon(FontAwesomeIcons.certificate, color: Colors.green)
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
