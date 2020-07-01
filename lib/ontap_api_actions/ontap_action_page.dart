import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_list_ui.dart';
import 'package:provider/provider.dart';

class OntapActionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionPage build');
    final actionStore = Provider.of<DataStore<OntapAction>>(context);
    final actionCount = actionStore.itemCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions ($actionCount)'),
        actions: [
          // a '+' button to launch the "add action" page
          if (actionCount > 0)
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
