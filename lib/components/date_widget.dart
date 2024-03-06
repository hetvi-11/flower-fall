import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DateSelectionCallback = void Function(DateTime selectedDate);
typedef DateChangeListener = void Function(DateTime selectedDate);

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date_chosen;
  final TextStyle? monthTextStyle, dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final String selectionImage;
  final DateSelectionCallback? onDateSelected;
  final String? locale;
  final Decoration decoration;

  DateWidget({
    required this.date_chosen,
    required this.monthTextStyle,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionImage,
    required this.selectionColor,
    required this.decoration,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width,
          margin: EdgeInsets.all(3.0),
          decoration:decoration,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    new DateFormat("E", locale)
                        .format(date_chosen)
                        .toUpperCase(), // WeekDay
                    style: dayTextStyle),
                Text(date_chosen.day.toString(), // Date
                    style: dateTextStyle),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // Check if onDateSelected is not null
        if (onDateSelected != null) {

          // Call the onDateSelected Function
          Image.asset('images/SpringCompressed.jpg',
            fit: BoxFit.fitHeight,);
          onDateSelected!(this.date_chosen);
          print(date_chosen);
        }
      },
    );
  }
}
