# ontap_monitor

Demo use of Netapp ONTAP REST API in a Flutter App.

## Description

This project demonstrates the use of the NetApp ONTAP REST API within a Flutter application. That API is available from NetApp ONTAP 9.6 and later.

For development purposes you can have your own running ONTAP Simulator - download the OVA from the NetApp support site at https://mysupport.netapp.com/ (NetApp SSO login required).

Persistent storage of config (& cached API responses) is currently local-device-only (using SharedPreferences) for simplicity - to keep the repo self-contained and ready-to-run for new users. For an enterprise app some external DB, with per-user authentication, and stronger encryption for credentials, would likely be preferred.

The aim is to demonstrate how custom apps can be built that leverage the REST API e.g. for reporting, monitoring, configuration and provisioning of ONTAP resources. This could, for example, allow a Managed Services partner to create a self-branded, customer-needs-targeted - even self-service - application to monitor/manage their customers NetApp estate.

This app can be run on iOS, Android using the appropriate "flutter run -d ..." device spec. Flutter web will not currently work as the ONTAP REST server (builtin to ONTAP) does not appear to support CORS (Cross Origin Resource Sharing) - which Javascript-in-a-browser requires, sigh...

A few resources to get you up and running with Flutter:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Richard Shepherd (eggzotic@gmail.com, richard.shepherd3@netapp.com)

July 2020