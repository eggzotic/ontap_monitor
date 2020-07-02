import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_compliance_state.dart';
import 'package:ontap_monitor/ontap_api_models/api_ontap_license_response.dart';
import 'package:provider/provider.dart';

class OntapClusterLicensingUi extends StatelessWidget {
  OntapClusterLicensingUi({
    Key key,
    @required this.toRefresh,
  }) : super(key: key);
  final void Function() toRefresh;
  //
  @override
  Widget build(BuildContext context) {
    final apiOntapLicenseResponse =
        Provider.of<ApiOntapLicenseResponse>(context);

    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(apiOntapLicenseResponse.name),
        children: [
          ...apiOntapLicenseResponse.records.map(
            (package) => ExpansionTile(
              title: Text(package.name),
              children: package.licenses
                  .map(
                    (lic) => ListTile(
                      leading: Icon(
                        lic.complianceState ==
                                ApiOntapLicenseComplianceState.compliant
                            ? Icons.check
                            : Icons.thumb_down,
                      ),
                      title: Text(lic.owner),
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
          ListTile(
            title: Text(apiOntapLicenseResponse.lastConnected
                .toIso8601String()
                .substring(0, 19)),
            subtitle: Text('Last updated'),
            trailing: Icon(
              Icons.refresh,
              color: Theme.of(context).accentColor,
            ),
            onTap: () => toRefresh(),
          ),
        ],
      ),
    );
  }
}
