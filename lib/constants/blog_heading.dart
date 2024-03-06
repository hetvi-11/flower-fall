import 'package:flower_fall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BlogHeading extends StatelessWidget {
  BlogHeading({required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
      child: Row(
        children: [
          Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: kDarkBlue,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}