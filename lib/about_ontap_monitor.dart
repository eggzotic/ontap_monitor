import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class AboutOntapMonitor extends StatelessWidget {
  Widget paragraph(String text) => Padding(
        padding: EdgeInsets.all(8.0),
        child: SelectableLinkify(
          text: text,
          onOpen: (link) => print('Clicked ${link.url}'),
        ),
      );
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
      body: ListView(
        children: [
          paragraph(
              'Ontap Monitor is a sample app to demonstrate the use of the NetApp ONTAP REST API from a custom app.'),
          paragraph(
              'Written in Flutter - the UI toolkit from Google for creating apps for iOI, Android and the web from a single code-base - write-once, run multi-platform (almost WORM!). See https://flutter.dev'),
          paragraph('''Richard Shepherd
richard.shepherd3@netapp.com
2020'''),
        ],
      ),
    );
  }
}
