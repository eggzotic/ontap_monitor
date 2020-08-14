//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/item_store.dart';
import 'package:ontap_monitor/data_storage/super_store.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_card.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_edit_page.dart';
import 'package:provider/provider.dart';

class OntapActionListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemStore<OntapAction> actionStore =
        Provider.of<SuperStore>(context).storeForType(OntapAction);
    final actionIds = actionStore.idsSorted;
    final actionCount = actionStore.itemCount;
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
        final action = actionStore.forId(id);
        final editable = action.isEditable;
        return Dismissible(
          key: ValueKey(id),
          confirmDismiss: (_) {
            // this prevents builtin's being deleted
            return Future.value(editable);
          },
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              editable ? Icons.delete_sweep : Icons.block,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
            color: editable ? Colors.red : Theme.of(context).disabledColor,
          ),
          onDismissed: (direction) => actionStore.deleteForId(id),
          child: ChangeNotifierProvider.value(
            value: action,
            builder: (_, __) => OntapActionCard(),
          ),
        );
      },
    );
  }
}
