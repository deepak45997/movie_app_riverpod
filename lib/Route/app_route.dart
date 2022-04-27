import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static void navigateTo(BuildContext context, Widget page) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) => page));
  }
}
