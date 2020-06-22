import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_list_ui.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:provider/provider.dart';

class OntapActionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionPage build');
    final actionStore = Provider.of<OntapActionStore>(context);
    final actionCount = actionStore.actionCount;
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions ($actionCount)'),
        actions: [
          // a '+' button to launch the "add action" page
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
