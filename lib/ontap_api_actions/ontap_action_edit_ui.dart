import 'package:flutter/material.dart';
import 'package:ontap_monitor/api_parameter_tile.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action_select_method_ui.dart';
import 'package:provider/provider.dart';

class OntapActionEditUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionEditUi build');
    final action = Provider.of<OntapAction>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: action.name,
            readOnly: false,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Action Name'),
            onChanged: (newName) => action.setName(newName),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: action.description,
            readOnly: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (newDescription) =>
                action.setDescription(newDescription),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: action.api,
            readOnly: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'API Name'),
            onChanged: (newApi) => action.setApi(newApi),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: OntapActionSelectMethodUi(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            readOnly: false,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Add Parameter'),
            onChanged: (newParam) => action.addParameterName(newParam),
          ),
        ),
        if (action.parameterNames.length > 0)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Parameters',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.black54),
            ),
          ),
        ...action.parameterNames
            .map((param) => Provider.value(
                value: param, builder: (_, __) => ApiParameterTile()))
            .toList(),
      ],
    );
  }
}
