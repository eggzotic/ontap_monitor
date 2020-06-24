import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_card.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:provider/provider.dart';

class OntapActionListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionListUi build');
    final actionStore = Provider.of<OntapActionStore>(context);
    final actionIds = actionStore.idsSorted;
    final actionCount = actionStore.actionCount;
    //
    if (actionCount == 0)
      return Card(
        child: ListTile(
          title: Text('Create an action'),
          trailing: Icon(Icons.add),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                final newAction = OntapAction();
                return ChangeNotifierProvider.value(
                  value: newAction,
                  builder: (_, __) => OntapActionEditPage(),
                );
              },
            ),
          ),
        ),
      );
    //
    return ListView.builder(
      itemCount: actionCount,
      itemBuilder: (context, index) {
        final id = actionIds[index];
        return Dismissible(
          key: ValueKey(id),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.delete_sweep, color: Colors.white),
            alignment: Alignment.centerRight,
            color: Colors.red,
          ),
          onDismissed: (direction) => actionStore.deleteForId(id),
          child: ChangeNotifierProvider.value(
            value: actionStore.forId(id),
            builder: (_, __) => OntapActionCard(),
          ),
        );
      },
    );
  }
}
