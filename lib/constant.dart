

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> pushNewScreen<T>(

    BuildContext context, {

      required Widget screen,

    }) async{
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (c, a1, a2) => screen,
      transitionsBuilder: (c, anim, a2, child) => CupertinoPageTransition( linearTransition: true,
      primaryRouteAnimation: anim,
      secondaryRouteAnimation: a2,
      child: child),
      transitionDuration: Duration(milliseconds: 200),
    ),
  );



}