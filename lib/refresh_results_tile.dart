import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(
        'Refresh now',
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      trailing: Icon(
        Icons.refresh,
        color: Theme.of(context).accentColor,
      ),
      onTap: () => toRefresh(),
    );
  }
}
