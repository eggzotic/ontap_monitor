//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';

//
// A simple wrapper Widget to dismiss the keyboard when tapping outside of any
//  regular inner-widget
class DismissKeyboardOnTap extends StatelessWidget {
  final Widget child;
  const DismissKeyboardOnTap({
    Key key,
    this.child,
  }) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        // this is the magic that hides the keyboard
        FocusScope.of(context).unfocus();
      },
    );
  }
}
