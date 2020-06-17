# ontap_monitor

Demo use of Netapp ONTAP REST API in Flutter App.

## Getting Started

This project demonstrates the use of the NetApp ONTAP REST API within a Flutter application. That API is available from ONTAP 9.6 and later.

For development purposes you can have your own running ONTAP Simulator - download the OVA from the NetApp support site at https://mysupport.netapp.com/ (NetApp SSO login required).

Configuration storage is currently local-device-only (using SharedPreferences) for simplicity and to keep the repo self-contained and ready-to-run for new users. For a real enterprise app an external DB, with per-user authentication, and stronger encryption for credentials, would be required.

The aim is to demonstrate how custom apps can be built that leverage the API for monitoring, configuration and provisioning. This could, for example, allow a Managed Services partner to create a self-branded application to monitor/manage their customers' NetApp estate.

This app can be run on iOS, Android and web using the appropriate "flutter run -d ..." device spec.

A few resources to get you up and running with Flutter:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Richard Shepherd (eggzotic@gmail.com, richard.shepherd3@netapp.com)

June 2020