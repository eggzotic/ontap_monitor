//
// Richard Shepherd, 2020
//  eggzotic@gmail.com, richard.shepherd3@netapp.com
//
import 'package:flutter/material.dart';

class BrandedWidget extends StatelessWidget {
  final Widget child;
  //
  BrandedWidget({Key key, this.child}) : super(key: key);
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      //
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/logo-here.jpg'),
          fit: BoxFit.contain,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.05), BlendMode.dstIn),
        ),
      ),
    );
  }
}
