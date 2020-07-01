import 'package:flutter/material.dart';
import 'package:ontap_monitor/data_storage/data_store.dart';
// import 'package:ontap_monitor/api_parameter_tile.dart';
import 'package:ontap_monitor/ontap_api/ontap_api.dart';
import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
// import 'package:ontap_monitor/ontap_api_actions/ontap_action_select_method_ui.dart';
import 'package:provider/provider.dart';

class OntapActionEditUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('OntapActionEditUi build');
    final apiStore = Provider.of<DataStore<OntapApi>>(context);
    final action = Provider.of<OntapAction>(context);
    // final newParamController = Provider.of<TextEditingController>(context);
    final editable = action.isEditable;
    //
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            enabled: editable,
            initialValue: action.name,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Action Name'),
            onChanged: (newName) => action.setName(newName),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            enabled: editable,
            initialValue: action.description,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Description'),
            onChanged: (newDescription) =>
                action.setDescription(newDescription),
          ),
        ),
        //
        DropdownButton<OntapApi>(
            items: apiStore.idsSorted.map(
              (apiId) {
                final api = apiStore.forId(apiId);
                DropdownMenuItem<OntapApi>(
                  child: Text(api.method.name + ' ' + api.name),
                  value: api,
                  onTap: () => action.setApi(api),
                );
              },
            ).toList(),
            value: action.api,
            onChanged: null),
        //
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: TextFormField(
        //     enabled: editable,
        //     initialValue: action.api,
        //     textCapitalization: TextCapitalization.none,
        //     keyboardType: TextInputType.text,
        //     decoration: InputDecoration(labelText: 'API Name'),
        //     onChanged: (newApi) => action.setApi(newApi),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: OntapActionSelectMethodUi(),
        // ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: TextFormField(
        //           enabled: editable,
        //           controller: newParamController,
        //           textCapitalization: TextCapitalization.none,
        //           keyboardType: TextInputType.text,
        //           decoration: InputDecoration(labelText: 'Add Parameter'),
        //           onChanged: (newParam) => action.setNewParameter(newParam),
        //         ),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.add_circle_outline),
        //         color: Colors.blue,
        //         onPressed: action.newApiParamValid
        //             ? () {
        //                 action.addParameterName();
        //                 newParamController.clear();
        //               }
        //             : null,
        //       ),
        //     ],
        //   ),
        // ),
        // if (action.parameterNames.length > 0)
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       'Parameters',
        //       style: Theme.of(context)
        //           .textTheme
        //           .subtitle2
        //           .copyWith(color: Colors.black54),
        //     ),
        //   ),
        // ...action.parameterNames
        //     .map(
        //       (param) => Provider.value(
        //         value: param,
        //         builder: (_, __) => ApiParameterTile(),
        //       ),
        //     )
        //     .toList(),
      ],
    );
  }
}
