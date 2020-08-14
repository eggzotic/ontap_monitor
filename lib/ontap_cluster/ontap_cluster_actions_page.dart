//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_actions_ui.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster_edit_page.dart';
import 'package:provider/provider.dart';

class OntapClusterActionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cluster = Provider.of<OntapCluster>(context);
    final scr = ScrollController();
    // final expCtrl = ExpandedTileController();
    //
    return Scaffold(
      appBar: AppBar(
        title: Text('Cluster - ${cluster.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OntapClusterEditPage(clusterId: cluster.id),
              ),
            ),
          ),
        ],
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: scr),
          // ChangeNotifierProvider.value(value: expCtrl),
        ],
        child: OntapClusterActionsUi(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // IconButton(
            //   icon: Icon(
            //     FontAwesomeIcons.minusSquare,
            //     color: Theme.of(context).accentColor,
            //   ),
            //   onPressed: () => expCtrl.collapse(),
            // ),
            IconButton(
              icon: Icon(
                Icons.arrow_upward,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () async {
                await scr.animateTo(
                  scr.position.minScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_downward,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () async {
                // print('Before scoll down');
                // print('minExtent: ${scr.position.minScrollExtent}');
                // print('offset   : ${scr.offset}');
                // print('maxExtent: ${scr.position.maxScrollExtent}');

                // this is a bit hacky but seems to force scroll to the bottom!
                //  despite all the fluctuation of maxScrollExtent
                do {
                  await scr.animateTo(
                    scr.position.maxScrollExtent,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                } while (scr.offset < 0.9 * scr.position.maxScrollExtent);
                // then, just in case we have overshot:
                scr.jumpTo(scr.position.maxScrollExtent);
              },
            ),
          ],
        ),
      ),
    );
  }
}
