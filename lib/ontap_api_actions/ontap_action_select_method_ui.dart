import 'package:flutter/material.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_models/api_method.dart';
import 'package:provider/provider.dart';

// present a drop-down menu to select a method from
class OntapActionSelectMethodUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final action = Provider.of<OntapAction>(context);
    return DropdownButton<ApiMethod>(
      value: action.method,
      onChanged: (method) => action.setMethod(method),
      items: ApiMethod.values.map(
        (method) => DropdownMenuItem(
          key: ValueKey(method.index),
          value: method,
          child: Text(method.name),
        ),
      ).toList(),
    );
  }
}
