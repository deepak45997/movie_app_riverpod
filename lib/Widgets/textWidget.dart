import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_riverpod/AppSize/appSize.dart';

class TextWidget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TextWidget(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.yellow,
        fontSize: AppSize().height(context) * 0.03,
      ),
    );
  }
}
