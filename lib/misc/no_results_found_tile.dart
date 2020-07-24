//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';

class NoResultsFoundTile extends StatelessWidget {
  NoResultsFoundTile({
    Key key,
    this.toReset,
  });

  /// [toReset] is a callback that should reset any previous error condition
  ///  which should trigger the tile to be reset to it's original state, ready
  ///  for a re-run
  final void Function() toReset;
  //
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Oops, no result found!'),
        subtitle: Text(toReset == null ? '' : 'Tap to reset'),
        trailing: Icon(Icons.error_outline),
        onTap: toReset == null
            ? null
            : () {
                toReset();
              },
      ),
    );
  }
}
