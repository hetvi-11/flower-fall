import 'package:flower_fall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuestionTitle extends StatelessWidget {
  QuestionTitle(
      {required this.question,
        required this.subtitle});
  final question;
  final subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 05.w, horizontal: 03.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  question,
                  maxLines: 1,
                  style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 90.w,
            child: Text(
              subtitle,
              style: TextStyle(
                color: kGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}