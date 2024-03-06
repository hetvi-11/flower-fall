import 'package:flower_fall/components/date_picker_widget.dart';
import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/provider/selectedDate_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/analysis_screen.dart';
import 'package:flower_fall/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DateSelect extends StatefulWidget {
  const DateSelect({Key? key}) : super(key: key);

  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  int m = DateTime.now().month;
  DateTime? selectedDate;
  buttonValidation() async {
    if (selectedDate != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.user.selectedDate = selectedDate;
      final selectedDateProvider =
          Provider.of<SelectedDateProvider>(context, listen: false);
      selectedDateProvider.date.userid = userProvider.user.id!;
      selectedDateProvider.date.date = selectedDate;
      selectedDateProvider.addSelectedDate();
      selectedDateProvider.readAllDateById(userId: userProvider.user.id!);
      userProvider.updateUserSelectedDate();
      getNotificationList({required String duration, required String length}) {
        int d = 0;
        List<DateTime> list = [];
        DateTime now = DateTime(
            userProvider.user.selectedDate!.year,
            userProvider.user.selectedDate!.month,
            userProvider.user.selectedDate!.day);
        List<CNotification> notificationList = [];

        _addToNotificationList(DateTime date) {
          CNotification ovulationDay = CNotification(
              date: date.subtract(Duration(days: 14)),
              message: "Today may be your ovulation day!",
              title: "Flower Fall");
          CNotification weekBefore = CNotification(
              date: date.subtract(Duration(days: 7)),
              message: "One week left for your periods!",
              title: "Flower Fall");
          CNotification dayBefore = CNotification(
              date: date.subtract(Duration(days: 1)),
              message: "Your periods may start tomorrow!",
              title: "Flower Fall");
          CNotification onDay = CNotification(
              date: date,
              message: "Your periods may arrive today!",
              title: "Flower Fall");
          notificationList.add(ovulationDay);
          notificationList.add(weekBefore);
          notificationList.add(dayBefore);
          notificationList.add(onDay);
        }

        for (int i = 0; i < 365; i++) {
          list.add(now);
          if (d < int.parse(length)) {
            if (d == 1) {
              _addToNotificationList(now);
            }
          }
          if (d == int.parse(duration) + int.parse(length) - 1) {
            d = -1;
          }
          d++;
          now = now.add(Duration(days: 1));
        }
        return notificationList;
      }

      List<CNotification> notificationDateList = getNotificationList(
          duration: userProvider.user.cycleLength!,
          length: userProvider.user.periodLength!);
      NotificationService notificationService = NotificationService();

      notificationService.setNotification(list: notificationDateList);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("isNotificationEnabled", true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Analysis()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(60.0, 40.0, 60.0, 0.0),
                child: Image.asset('images/flowerFallColoured.png'),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: CupertinoPicker(
                      itemExtent: 40,
                      selectionOverlay: Container(
                        child: Image.asset('images/blueBack.png'),
                      ),
                      diameterRatio: 1.0,
                      scrollController: FixedExtentScrollController(
                          initialItem: DateTime.now().month),
                      magnification: 1.3,
                      children: [
                        Month(
                          month: 'January',
                          season: 'Winter',
                        ),
                        Month(
                          month: 'February',
                          season: 'Winter',
                        ),
                        Month(
                          month: 'March',
                          season: 'Spring',
                        ),
                        Month(
                          month: 'April',
                          season: 'Spring',
                        ),
                        Month(
                          month: 'May',
                          season: 'Spring',
                        ),
                        Month(
                          month: 'June',
                          season: 'Summer',
                        ),
                        Month(
                          month: 'July',
                          season: 'Summer',
                        ),
                        Month(
                          month: 'August',
                          season: 'Summer',
                        ),
                        Month(
                          month: 'September',
                          season: 'Autumn',
                        ),
                        Month(
                          month: 'October',
                          season: 'Autumn',
                        ),
                        Month(
                          month: 'November',
                          season: 'Autumn',
                        ),
                        Month(
                          month: 'December',
                          season: 'Winter',
                        ),
                      ],
                      onSelectedItemChanged: (value) {
                        setState(() {
                          m = value + 1;
                        });
                      }),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 05.w, horizontal: 03.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Your nearby period date?',
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
                      'Use the calendar below to make sure we have exact date.',
                      style: TextStyle(
                        color: kGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
              child: DatePicker(
                DateTime.utc(2021, m),
                onDateChange: (date) {
                  selectedDate = date;
                },
              ),
            ),
            kCustomButton(text: 'Next', onPressed: () => buttonValidation()),
          // SizedBox(height: 25,),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: kCopyright(),
            ),
          ],
        ),
      ),
    );
  }
}

class Month extends StatefulWidget {
  Month({required this.month, this.season});
  final month;
  final season;

  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.month,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w500,
            color: Colors.lightBlueAccent,
          ),
        ),
        SizedBox(width: 20.0),
        Text(
          widget.season,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
