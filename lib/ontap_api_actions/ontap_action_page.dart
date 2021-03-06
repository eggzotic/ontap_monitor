//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_list_ui.dart';
import 'package:provider/provider.dart';

class OntapActionPage extends StatelessWidget {
  final bool readOnly;
  //
  OntapActionPage({
    Key key,
    this.readOnly = true,
  }) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);
    final actionCount = actionStore.itemCount;
    //
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions ($actionCount)'),
        actions: [
          // a '+' button to launch the "add action" page
          if (actionCount > 0 && !readOnly)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  final newAction = OntapAction();
                  return ChangeNotifierProvider.value(
                    value: newAction,
                    builder: (_, __) => OntapActionEditPage(),
                  );
                }),
              ),
            ),
        ],
      ),
      body: OntapActionListUi(),
    );
  }
}
