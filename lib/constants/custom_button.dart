import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'colors.dart';

class kCustomButton extends StatelessWidget {

kCustomButton({required this.onPressed, required this.text, this.focusNode});

final onPressed;
final String text;
final focusNode;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),),
      color: kDarkBlue,
      height: 65.0,
      minWidth: 95.w,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: onPressed,
      focusNode: focusNode,
    );
  }
}