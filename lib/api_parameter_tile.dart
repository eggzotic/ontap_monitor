// import 'package:flutter/material.dart';
// import 'package:ontap_monitor/ontap_api_actions/ontap_action.dart';
// import 'package:provider/provider.dart';

// class ApiParameterTile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final action = Provider.of<OntapAction>(context);
//     final parameterName = Provider.of<String>(context);
//     return Dismissible(
//       key: ValueKey(parameterName),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.0),
//         child: Icon(Icons.delete_sweep, color: Colors.white),
//         alignment: Alignment.centerRight,
//         color: Colors.red,
//       ),
//           onDismissed: (direction) => action.deleteParameterName(parameterName),
//       child: ListTile(
//         title: Text(parameterName),
//         trailing: Icon(Icons.chevron_left),
//       ),
//     );
//   }
// }
