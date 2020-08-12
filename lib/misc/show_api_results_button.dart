//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/api_raw_response.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_cluster/ontap_cluster.dart';
import 'package:provider/provider.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';

class ShowApiResultsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //
    return IconButton(
      icon: Icon(
        Icons.visibility,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (c) {
            final action = Provider.of<OntapAction>(context);
            final cluster = Provider.of<OntapCluster>(context);
            final jsonStore =
                Provider.of<SuperStore>(context).storeForType(ApiRawResponse);
            final responseId = ApiRawResponse.idForClusterAction(
                cluster: cluster, action: action);
            final responseExists = jsonStore.existsForId(responseId);
            //
            return AlertDialog(
              title: Text('Action API'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(c);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Theme.of(c).accentColor),
                  ),
                ),
              ],
              content: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: responseExists
                    ? MediaQuery.of(context).size.height * 0.6
                    : 200.0,
                child: ListView(
                  children: [
                    ListTile(
                      title: Text(
                        action.api.method.name +
                            ' ' +
                            action
                                .urlForHost(cluster.adminLifAddress)
                                .toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      subtitle: Text('Full API URL'),
                    ),
                    // if there's a response then display that also
                    if (responseExists) ...[
                      Divider(),
                      ListTile(
                        title: Text(
                          jsonStore.forId(responseId).rawJson,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text('Raw JSON Response'),
                      ),
                    ]
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
