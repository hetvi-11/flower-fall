import 'package:flower_fall/constants/colors.dart';
import 'package:flutter/material.dart';

class Para extends StatelessWidget {
  Para({required this.text});
  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // maxLines: 1,
      style: TextStyle(
        color: kGrey,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}