import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_card.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_store.dart';
import 'package:provider/provider.dart';

class OntapActionListUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionListUi build');
    final actionStore = Provider.of<OntapActionStore>(context);
    final actionIds = actionStore.idsSorted;
    final actionCount = actionStore.actionCount;
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
