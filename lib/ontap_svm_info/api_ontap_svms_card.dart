//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ontap_monitor/misc/no_results_found_tile.dart';
import 'package:ontap_monitor/misc/refresh_results_tile.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm.dart';
import 'package:ontap_monitor/ontap_svm_info/api_ontap_svm_state.dart';
import 'package:provider/provider.dart';

class ApiOntapSvmsCard extends StatelessWidget {
  ApiOntapSvmsCard({
    Key key,
    @required this.toRefresh,
    @required this.toReset,
  }) : super(key: key);

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;

  /// [toReset] is a callback that should reset any previous error condition
  ///  which should trigger the tile to be reset to it's original state, ready
  ///  for a re-run
  final void Function() toReset;
  //
  // Select the SVM-state icon & color
  final List<IconData> _svmStateIconList = [Icons.ac_unit];
  IconData get _svmStateIcon => _svmStateIconList.first;
  set _svmStateIcon(IconData icon) => _svmStateIconList[0] = icon;
  //
  final List<Color> _svmStateColorList = [Colors.green];
  Color get _svmStateColor => _svmStateColorList.first;
  set _svmStateColor(Color color) => _svmStateColorList[0] = color;
  //
  void _svmState(BuildContext context, ApiOntapSvm svm) {
    if (svm.state == null) {
      _svmStateIcon = Icons.help;
      _svmStateColor = Theme.of(context).buttonColor;
      return;
    }
    // non-null cases
    switch (svm.state) {
      case ApiOntapSvmState.running:
        _svmStateIcon = Icons.check;
        _svmStateColor = Colors.green;
        return;
      case ApiOntapSvmState.stopped:
      case ApiOntapSvmState.stopping:
        _svmStateIcon = FontAwesomeIcons.handPaper;
        _svmStateColor = Colors.red;
        return;
      case ApiOntapSvmState.starting:
        _svmStateIcon = FontAwesomeIcons.hourglassStart;
        _svmStateColor = Colors.blue;
        return;
      case ApiOntapSvmState.deleting:
        _svmStateIcon = FontAwesomeIcons.trashAlt;
        _svmStateColor = Colors.grey;
        return;
      default:
        _svmStateIcon = Icons.warning;
        _svmStateColor = Theme.of(context).iconTheme.color;
        return;
    }
  }

  //
  @override
  Widget build(BuildContext context) {
    final svms = Provider.of<List<ApiOntapSvm>>(context);
    if (svms == null || svms.isEmpty)
      return NoResultsFoundTile(toReset: toReset);
    final lastUpdated = svms.first.lastUpdated;
    return Card(
      child: ExpansionTile(
        key: PageStorageKey('SVMs'),
        title: Text('SVMs (${svms.length})'),
        subtitle: Text(
          'Last updated: ' + lastUpdated.toString().substring(0, 19),
        ),
        children: [
          ...svms.map((svm) {
            _svmState(context, svm);
            return ExpansionTile(
              key: PageStorageKey(svm.name),
              leading: FaIcon(_svmStateIcon, color: _svmStateColor),
              title: Text(svm.name),
              subtitle: Text(svm.state.name),
            );
          }),
          RefreshResultsTile(toRefresh: toRefresh),
        ],
      ),
    );
  }
}
