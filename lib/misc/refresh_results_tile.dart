//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
// a simple tile to be placed at the bottom of each result-set to allow
//  conveniently triggering the fetch of a fresh set of results
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefreshResultsTile extends StatelessWidget {
  RefreshResultsTile({
    Key key,
    @required this.toRefresh,
  });

  /// [toRefresh] is a callback that should refresh the data being displayed
  final void Function() toRefresh;
  //
  @override
  Widget build(BuildContext context) {
    final refreshing = Provider.of<bool>(context);
    return ListTile(
      title: Text(
        'Refresh now',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      trailing: refreshing
          ? SizedBox(
              height: 20,
              width: 20,
              child: Center(child: CircularProgressIndicator()),
            )
          : Icon(
              Icons.refresh,
              color: Theme.of(context).accentColor,
            ),
      onTap: refreshing ? null : () => toRefresh(),
    );
  }
}
