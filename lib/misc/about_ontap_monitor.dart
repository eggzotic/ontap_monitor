//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:ontap_monitor/misc/branded_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutOntapMonitor extends StatelessWidget {
  Widget paragraph(String text) => Padding(
        padding: EdgeInsets.all(8.0),
        child: SelectableLinkify(
          text: text,
          onOpen: (link) {
            _launchURL(link.url);
          },
        ),
      );
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Ontap Monitor'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BrandedWidget(
              child: ListView(
          children: [
            paragraph(
                'Ontap Monitor is a sample app to demonstrate the use of the NetApp ONTAP REST API from a custom app. That API is available from NetApp ONTAP 9.6 and later.'),
            paragraph(
                'For development purposes you can have your own running ONTAP Simulator - download the OVA from the NetApp support site at https://mysupport.netapp.com (NetApp SSO login required).'),
            paragraph(
                'Configuration storage is currently local-device-only (using SharedPreferences) for simplicity - to keep the repo self-contained and ready-to-run for new users. For an enterprise app some external DB, with per-user authentication, and stronger encryption for credentials, would likely be preferred.'),
            paragraph(
                'The aim is to demonstrate how custom apps can be built that leverage the REST API for monitoring, configuration and provisioning of ONTAP resources. This could, for example, allow a Managed Services partner to create a self-branded, customer-needs-targeted - even self-service - application to monitor/manage their customers NetApp estate.'),
            paragraph(
                'This app can be run on iOS and Android using the appropriate "flutter run -d ..." device spec. Flutter web will not currently work as the ONTAP REST server (builtin to ONTAP) does not appear to support CORS (Cross Origin Resource Sharing) - which Javascript-in-a-browser requires, sigh...'),
            paragraph(
                'Written in Flutter - the UI toolkit from Google for creating apps for iOS, Android and the web - all from a single code-base - write-once, run multi-platform (almost WORM!). See https://flutter.dev'),
            paragraph('''Richard Shepherd
richard.shepherd3@netapp.com
August 2020'''),
          ],
        ),
      ),
    );
  }
}
