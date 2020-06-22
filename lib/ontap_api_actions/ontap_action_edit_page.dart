import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_ui.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:provider/provider.dart';

class OntapActionEditPage extends StatelessWidget {
  final String actionId;
  OntapActionEditPage({
    Key key,
    this.actionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('OntapActionEditPage build');
    final actionStore = Provider.of<OntapActionStore>(context);
    final add = actionId == null;
    final action = add ? Provider.of<OntapAction>(context) : actionStore.forId(actionId);
    return Scaffold(
      appBar: AppBar(
        title: Text(add ? 'Create Action' : 'Edit action'),
        leading: IconButton(
          icon: Icon(Icons.done),
          onPressed: !action.isValid
              ? null
              : () {
                  if (add) actionStore.add(action);
                  Navigator.of(context).pop();
                },
        ),
        actions: [
          if (add)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
        ],
      ),
      body:
          // just in case the credential has been deleted
          actionId != null && !actionStore.existsForId(actionId)
              ? Center(
                  child: Column(
                    children: [
                      Text('Cannot find Credentials'),
                      RaisedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Close'),
                      ),
                    ],
                  ),
                )
              // main case where we're editing an existing, or creating a new, action
              : ChangeNotifierProvider.value(
                  value: action,
                  builder: (_, __) => OntapActionEditUi(),
                ),
    );
  }
}
