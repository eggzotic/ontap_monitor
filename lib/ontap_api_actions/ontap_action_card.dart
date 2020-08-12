//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:provider/provider.dart';

class OntapActionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final action = Provider.of<OntapAction>(context);
    return Card(
      child: ListTile(
        title: Text(action.name),
        subtitle: Text(action.api.name),
        trailing: action.isBuiltin
            ? Icon(Icons.block)
            : Icon(
                Icons.edit,
                color: Theme.of(context).accentColor,
              ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OntapActionEditPage(actionId: action.id),
            ),
          );
        },
      ),
    );
  }
}
