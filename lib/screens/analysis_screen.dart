import 'package:flame_audio/flame_audio.dart';
import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/drawerlist_widget.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/provider/date_provider.dart';
import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/selectedDate_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/blog_screens.dart/five.dart';
import 'package:flower_fall/screens/blog_screens.dart/four.dart';
import 'package:flower_fall/screens/blog_screens.dart/three.dart';
import 'package:flower_fall/screens/blog_screens.dart/two.dart';
import 'package:flower_fall/screens/calendar_screen.dart';
import 'package:flower_fall/screens/details_screen.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flower_fall/screens/blog_screens.dart/one.dart';
import 'package:flower_fall/screens/settings_screen.dart';
import 'package:flower_fall/screens/warning_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flower_fall/constants/question_title.dart';

import '../constant.dart';
import '../main.dart';

class Analysis extends StatefulWidget {
  const Analysis({Key? key}) : super(key: key);

  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  DateTime? backbuttonpressedTime;
  bool _showbottomsheet = false;
  List<DateTime> list = [];
  List<DateTime> selectedlist = [];
  int d = 0;
  var leftdays = 0;
  List<DateTime> blackOutDates = [];
  List<DateTime> temp = [];
  String? dropImage;
  ScrollController controller = ScrollController();

  List<String> audioImageList = [
    "images/audio1.png",
    "images/audio2.png",
    "images/audio3.png",
    "images/audio4.png",
    "images/audio1.png",
  ];

  List<String> audioList = [
    "audio1_compressed.mp3",
    "audio2_compressed.mp3",
    "audio3_compressed.mp3",
    "audio4_compressed.mp3",
    "audio5_compressed.mp3",
  ];

  int selectedIndex = -1;

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime!) > Duration(seconds: 1);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(""),
              content: Text("Do you want to exit the app?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                )
              ],
            );
          });
      return false;
    }
    return true;
  }

  periodDates(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    DateTime now = DateTime(
        userProvider.user.selectedDate!.year,
        userProvider.user.selectedDate!.month,
        userProvider.user.selectedDate!.day);

    for (int i = 0; i < 365; i++) {
      list.add(now);

      if (d < int.parse(userProvider.user.periodLength!)) {
        if (!selectedlist.contains(now)) selectedlist.add(now);
      }
      if (d ==
          int.parse(userProvider.user.cycleLength!) +
              int.parse(userProvider.user.periodLength!) -
              1) {
        d = -1;
      }
      d++;
      now = now.add(Duration(days: 1));
    }
    final selectedDateProvider =
        Provider.of<SelectedDateProvider>(context, listen: false);
    List<DateTime> history = await selectedDateProvider.readAllDateById(
        userId: userProvider.user.id!);
    List<DateTime> previousDates = [];

    history.forEach((date) {
      DateTime now = date;
      int d = 0;
      for (int i = 0; i < 365; i++) {
        if (d < int.parse(userProvider.user.periodLength!)) {
          if (now.compareTo(selectedlist.first) < 0) if (!previousDates
              .contains(now)) {
            previousDates.add(now);
          }
        }
        if (d ==
            int.parse(userProvider.user.cycleLength!) +
                int.parse(userProvider.user.periodLength!) -
                1) {
          d = -1;
        }
        d++;
        now = now.add(Duration(days: 1));
      }
      previousDates.forEach((e) {
        if (!selectedlist.contains(e)) selectedlist.add(e);
      });

      previousDates.clear();
    });

    if (selectedlist.first.isAfter(DateTime.now())) {
      leftdays = DateTime.now().difference(selectedlist.first).inDays.abs() + 1;
      List<DateTime> newList = [...list];
      list.forEach((element) {
        if (selectedlist.contains(element)) {
          newList.remove(element);
        }
      });
      temp = [...selectedlist];
      Provider.of<DateProvider>(context, listen: false)
          .getSelectedDateList(temp);
      blackOutDates.clear();
      blackOutDates.addAll(newList);
      Provider.of<DateProvider>(context, listen: false)
          .getBlackDateList(blackOutDates);
    } else {
      DateTime tempDate = DateTime.now();
      int counter = 1;
      while (true) {
        tempDate = selectedlist.first.add(Duration(
            days: counter *
                (int.parse(userProvider.user.periodLength!) +
                    int.parse(userProvider.user.cycleLength!))));
        if (DateTime.now().isBefore(tempDate.subtract(
            Duration(days: int.parse(userProvider.user.cycleLength!))))) {
          leftdays = 0;
          break;
        }
        if (tempDate.isAfter(DateTime.now())) {
          leftdays = DateTime.now().difference(tempDate).inDays.abs() + 1;
          break;
        }
        counter++;
      }

      List<DateTime> newList = [...list];
      list.forEach((element) {
        if (selectedlist.contains(element)) {
          newList.remove(element);
        }
      });
      temp = [...selectedlist];
      Provider.of<DateProvider>(context, listen: false)
          .getSelectedDateList(temp);
      blackOutDates.clear();
      blackOutDates.addAll(newList);
      Provider.of<DateProvider>(context, listen: false)
          .getBlackDateList(blackOutDates);
    }
    if (selectedlist.contains(DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
      _showbottomsheet = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      periodDates(context);
      DateTime firstDate = list.first;
      double difference =
          DateTime.now().difference(firstDate).inDays.toDouble();
      // controller.jumpTo(difference);
      controller.animateTo(difference * 73,
          duration: (Duration(milliseconds: 1500)), curve: Curves.easeIn);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        endDrawer: Drawer(
          elevation: 16.0,
          child: SafeArea(
            // top:false,
            child: Column(
              children: [
                ListTile(
                  title: Consumer<UserProvider>(
                      builder: (context, provider, child) {
                    return Text(
                      '${provider.user.name}',
                      style: TextStyle(
                        color: kDarkBlue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                  subtitle: Consumer<UserProvider>(
                      builder: (context, provider, child) {
                    return Text(
                      '${provider.user.email}',
                      style: TextStyle(
                        color: kDarkBlue,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    );
                  }),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: kDarkBlue,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DrawerList(
                  text: 'Calendar Data History',
                  icon: 'assets/icons/calendar.svg',
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => Calendar()));
                    Get.toNamed(Calendar.routeName);
                  },
                ),
                DrawerList(
                  text: 'Sound Library',
                  icon: 'assets/icons/headphone.svg',
                  onTap: () {},
                ),
                DrawerList(
                  text: 'Version',
                  icon: 'assets/icons/version.svg',
                  onTap: () {},
                ),
                DrawerList(
                  text: 'About Us',
                  icon: 'assets/icons/AboutUs.svg',
                  onTap: () {},
                ),
                DrawerList(
                  text: 'Terms of Service',
                  icon: 'assets/icons/terms.svg',
                  onTap: () {},
                ),
                DrawerList(
                  text: 'Privacy Policy',
                  icon: 'assets/icons/privacy.svg',
                  onTap: () {},
                ),
                DrawerList(
                  text: 'Settings',
                  icon: 'assets/icons/settings.svg',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 0, top: 0),
                  child: DrawerList(
                    text: 'Sign Out',
                    icon: 'assets/icons/log out.svg',
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content:
                                  Text('Are you sure you want to Sign Out?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text("Confirm"),
                                  onPressed: () async {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .reset();
                                    Provider.of<PeriodProvider>(context,
                                            listen: false)
                                        .reset();
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.clear();

                                    Get.offAll(() => LoginPage())!
                                        .then((value) async {
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .reset();
                                      Provider.of<PeriodProvider>(context,
                                              listen: false)
                                          .reset();
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.clear();
                                    });
                                  },
                                )
                              ],
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        bottomSheet: _showbottomsheet
            ? BottomSheet(
                onClosing: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                            chosenDate: DateTime(DateTime.now().year,
                                DateTime.now().month, DateTime.now().day))),
                  );
                },
                builder: (BuildContext context) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                  chosenDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day))),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: kDarkBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      chosenDate: DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day))),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              'Hey, How are you feeling today?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
            : null,
        appBar: AppBar(
         elevation: 0.0,
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.segment_rounded),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
          ],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text('Hello',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.blue,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Consumer<UserProvider>(
                          builder: (context, userProvider, child) {
                        return Text(
                          '${userProvider.user.name}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Calendar()));
                    },
                    child: Text(
                      DateFormat.MMM().format(DateTime.now()),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        pushNewScreen(context, screen: Calendar());
                        // Get.toNamed(Calendar.routeName);
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/Calendar1.svg',
                        height: 22,
                        width: 22,
                      )),
                ],
              ),
            ],
          ),
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 100,
                              width: 500,
                              child: ListView.builder(
                                controller: controller,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  Color backgroundColor = Colors.transparent;
                                  Color lineColor = Colors.transparent;
                                  Color daytextColor = Colors.black;
                                  Color datetextColor = kGrey;
                                  try {
                                    if (selectedlist.contains(list[index])) {
                                      backgroundColor = kLightBlue;
                                      daytextColor = Colors.black;
                                      datetextColor = Colors.black;
                                      if (list[index]
                                              .compareTo(DateTime.now()) <
                                          0) {
                                        backgroundColor = Colors.transparent;
                                        lineColor = Colors.red;
                                        daytextColor = Colors.black;
                                        datetextColor = kGrey;
                                      }
                                    }
                                  } catch (e) {
                                    print('data not found');
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Calendar()));
                                    },
                                    child: Container(
                                      height: 105,
                                      width: 53,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: backgroundColor,
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${DateFormat("E").format(list[index])}",
                                                  style: TextStyle(
                                                    color: daytextColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  "${DateFormat("dd").format(list[index])}",
                                                  style: TextStyle(
                                                    color: datetextColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                )
                                              ]),
                                          Container(
                                            height: 100,
                                            width: 50,
                                            alignment: Alignment.center,
                                            child: Image.asset(
                                              'images/redLine.png',
                                              color: lineColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      QuestionTitle(
                          question: 'Period Data',
                          subtitle: 'Track all your latest data down below.'),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(1.5.w, 0.0, 1.5.w, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (leftdays > 0)
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 230.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kDarkBlue,
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('Period ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 20,
                                                  )),
                                              Text('in',
                                                  style: TextStyle(
                                                    color: kLightBlue,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 18,
                                                  ))
                                            ],
                                          ),
                                          if (leftdays.toString().length > 1)
                                            Text(leftdays.toString(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 70,
                                                )),
                                          if (leftdays.toString().length < 2)
                                            Text('0${leftdays.toString()}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 70,
                                                )),
                                          Text('DAYS',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 15,
                                                letterSpacing: 12,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Consumer<UserProvider>(builder:
                                          (context, userProvider, child) {
                                        if ((int.parse(userProvider
                                                        .user.cycleLength ??
                                                    "0") -
                                                leftdays) >
                                            6)
                                          return Container(
                                            height: 45,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text("Alert"),
                                                        content: Text(
                                                            'Are you sure you want to Log your periods?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text("No")),
                                                          TextButton(
                                                            child: Text("Yes"),
                                                            onPressed:
                                                                () async {
                                                              final userProvider =
                                                                  Provider.of<
                                                                          UserProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              final selectedDateProvider =
                                                                  Provider.of<
                                                                          SelectedDateProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              selectedDateProvider
                                                                      .date
                                                                      .userid =
                                                                  userProvider
                                                                      .user.id;
                                                              selectedDateProvider
                                                                      .date
                                                                      .date =
                                                                  DateTime(
                                                                      DateTime.now()
                                                                          .year,
                                                                      DateTime.now()
                                                                          .month,
                                                                      DateTime.now()
                                                                          .day);
                                                              selectedDateProvider
                                                                  .addSelectedDate();
                                                              selectedDateProvider
                                                                  .readAllDateById(
                                                                      userId: userProvider
                                                                          .user
                                                                          .id!);

                                                              userProvider.user
                                                                      .selectedDate =
                                                                  DateTime(
                                                                      DateTime.now()
                                                                          .year,
                                                                      DateTime.now()
                                                                          .month,
                                                                      DateTime.now()
                                                                          .day);
                                                              userProvider
                                                                  .updateUserSelectedDate();

                                                              //provider.addPeriod();
                                                              setState(() {});
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => Details(
                                                                          chosenDate: DateTime(
                                                                              DateTime.now()
                                                                                  .year,
                                                                              DateTime.now()
                                                                                  .month,
                                                                              DateTime.now().day)))).then(
                                                                  (value) {
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MyRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Analysis()));
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Text(
                                                'LOG PERIOD',
                                                style: TextStyle(
                                                  color: kDarkBlue,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          );
                                        return Container();
                                      })
                                    ],
                                  )),
                            ),
                          ),
                        if (leftdays <= 0)
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(5),
                              height: 230.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: kDarkBlue,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, bottom: 20.0, left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Consumer<PeriodProvider>(builder:
                                            (context, provider, child) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (provider.period.chosenDate !=
                                                  null)
                                                Text(
                                                  DateFormat.y().format(provider
                                                      .period.chosenDate!),
                                                  style: TextStyle(
                                                    color: Color(0xFF8B8B8B),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              if (provider.period.chosenDate !=
                                                  null)
                                                Text(
                                                  DateFormat.MMMMd().format(
                                                      provider
                                                          .period.chosenDate!),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              if (provider.period.chosenDate ==
                                                  null)
                                                Text(
                                                  DateFormat.y()
                                                      .format(DateTime.now()),
                                                  style: TextStyle(
                                                    color: Color(0xFF8B8B8B),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              if (provider.period.chosenDate ==
                                                  null)
                                                Text(
                                                  DateFormat.MMMMd()
                                                      .format(DateTime.now()),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                            ],
                                          );
                                        }),
                                        if (Provider.of<PeriodProvider>(context, listen: false)
                                                    .period
                                                    .flow !=
                                                null &&
                                            Provider.of<PeriodProvider>(context,
                                                        listen: false)
                                                    .period
                                                    .sleep !=
                                                null &&
                                            Provider.of<PeriodProvider>(context,
                                                        listen: false)
                                                    .period
                                                    .currentWeight !=
                                                null)
                                          if (Provider.of<PeriodProvider>(context,
                                                          listen: false)
                                                      .period
                                                      .flow ==
                                                  'Heavy' ||
                                              int.parse(Provider.of<PeriodProvider>(context, listen: false).period.sleep!) <
                                                  6 ||
                                              int.parse(Provider.of<PeriodProvider>(context, listen: false).period.currentWeight!) <
                                                  int.parse(Provider.of<UserProvider>(context, listen: false).user.weight!))
                                            GestureDetector(
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: kDarkBlue,
                                                      width: 3),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SvgPicture.asset(
                                                      'assets/icons/Notification.svg'),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Warning()));
                                              },
                                            ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Your Action',
                                          style: TextStyle(
                                            color: kGrey,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<PeriodProvider>(
                                        builder: (context, provider, child) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              if (provider.period.flow !=
                                                      null &&
                                                  provider.period.flowImage !=
                                                      null)
                                                Builder(builder: (context) {
                                                  if (provider
                                                          .period.flowImage ==
                                                      'assets/icons/NoFLowEmoji_dark.svg') {
                                                    dropImage =
                                                        'assets/icons/NoFlowEmoji.svg';
                                                  } else if (provider
                                                          .period.flowImage ==
                                                      'assets/icons/LowDropEmoji_dark.svg') {
                                                    dropImage =
                                                        'assets/icons/LowDropEmoji.svg';
                                                  } else if (provider
                                                          .period.flowImage ==
                                                      'assets/icons/NormalDropEmoji_dark.svg') {
                                                    dropImage =
                                                        'assets/icons/NormalDropEmoji.svg';
                                                  } else if (provider
                                                          .period.flowImage ==
                                                      'assets/icons/MediumDropEmoji_dark.svg') {
                                                    dropImage =
                                                        'assets/icons/MediumDropEmoji.svg';
                                                  } else if (provider
                                                          .period.flowImage ==
                                                      'assets/icons/HeavyDropEmoji_dark.svg') {
                                                    dropImage =
                                                        'assets/icons/HeavyDropEmoji.svg';
                                                  } else {
                                                    dropImage =
                                                        'assets/icons/NoFlowEmoji.svg';
                                                  }
                                                  return Action(
                                                      image: dropImage!,
                                                      text:
                                                          provider.period.flow);
                                                }),
                                              if (provider.period
                                                          .currentWeight !=
                                                      null &&
                                                  provider.period.weightImage !=
                                                      null)
                                                Action(
                                                    image: provider
                                                        .period.weightImage!,
                                                    text:
                                                        '${provider.period.currentWeight} kg\'s'),
                                              if (provider.period.sleep !=
                                                      null &&
                                                  provider.period.sleepImage !=
                                                      null)
                                                Action(
                                                    image: provider
                                                        .period.sleepImage!,
                                                    text:
                                                        '${provider.period.sleep} Hrs'),
                                              if (provider.period.mood !=
                                                      null &&
                                                  provider.period.moodImage !=
                                                      null)
                                                Action(
                                                  image: provider
                                                      .period.moodImage!,
                                                  text: provider.period.mood,
                                                ),
                                              if (provider.period.symptoms !=
                                                      null &&
                                                  provider.period
                                                          .symptomsImage !=
                                                      null)
                                                Action(
                                                  image: provider
                                                      .period.symptomsImage!,
                                                  text:
                                                      provider.period.symptoms,
                                                )
                                            ]),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                'Cycle',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.0,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              Text(
                                'Length',
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 22.0,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                return Text(
                                  '${int.parse(userProvider.user.cycleLength ?? "0") + int.parse(userProvider.user.periodLength ?? "0")}',
                                  style: TextStyle(
                                      color: kDarkBlue,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700),
                                );
                              }),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 2,
                                width: 90,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Period',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.0,
                                  color: kDarkBlue,
                                ),
                              ),
                              Text(
                                'Length',
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 22.0,
                                  color: kDarkBlue,
                                ),
                              ),
                              Consumer<UserProvider>(
                                  builder: (context, userProvider, child) {
                                if (int.parse(
                                        userProvider.user.periodLength ?? "0") >
                                    9) {
                                  return Text(
                                    '${userProvider.user.periodLength}',
                                    style: TextStyle(
                                        color: kDarkBlue,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  );
                                } else {
                                  return Text(
                                    '0${userProvider.user.periodLength}',
                                    style: TextStyle(
                                        color: kDarkBlue,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w700),
                                  );
                                }
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      QuestionTitle(
                          question: 'Sleep Sound',
                          subtitle:
                              'Take at least 8 hours of sleep with peace.'),
                    ],
                  ),
                  Container(
                    height: 20.w,
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: audioImageList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return SleepAudio(
                                    image: audioImageList[index],
                                    selected:
                                        selectedIndex == index ? true : false,
                                    onPressed: () {
                                      if (index == selectedIndex) {
                                        setState(() {
                                          selectedIndex = -1;
                                          if (FlameAudio.bgm.isPlaying) {
                                            FlameAudio.bgm.stop();
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          selectedIndex = index;
                                          FlameAudio.bgm.play(audioList[index]);
                                        });
                                      }
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        QuestionTitle(
                            question: 'Health Tips',
                            subtitle:
                                'A variety of health topics, medical views and news.'),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      HealthTip(
                        leading: 'images/lead5.png',
                        title: 'How you like to relax.',
                        subtitle: 'Published Aug 19, 2021',
                        image: 'images/list5.png',
                        path: One(image: 'images/one.png',),
                      ),
                      HealthTip(
                        leading: 'images/lead1.png',
                        title: 'Avoid Caffine',
                        subtitle: 'Published Aug 23, 2021',
                        image: 'images/list1.png',
                        path: Two(image: 'images/two.png',),
                      ),
                      HealthTip(
                        leading: 'images/lead2.png',
                        title: 'Favorite home remedies.',
                        subtitle: 'Published Aug 21, 2021',
                        image: 'images/list2.png',
                        path: Three(image: 'images/three.png',),
                      ),
                      HealthTip(
                        leading: 'images/lead3.png',
                        title: 'Avoid Pills',
                        subtitle: 'Published Aug 19, 2021',
                        image: 'images/list3.png',
                        path: Four(image: 'images/four.png',),
                      ),
                      HealthTip(
                        leading: 'images/lead4.png',
                        title: 'Healthline Nutrition',
                        subtitle: 'Published Aug 19, 2021',
                        image: 'images/list4.png',
                        path: Five(image: 'images/five.png',),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                ],
              )),
        ),
      ),
    );
  }
}

class SleepAudio extends StatefulWidget {
  SleepAudio(
      {required this.image, this.selected = false, required this.onPressed});
  final image;
  bool selected;
  void Function()? onPressed;

  @override
  _SleepAudioState createState() => _SleepAudioState();
}

class _SleepAudioState extends State<SleepAudio> {
  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 20.w,
        width: 20.w,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // border: Border.all(color: kDarkBlue),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.cover,
            ),
            SvgPicture.asset(
              widget.selected
                  ? "assets/icons/pause.svg"
                  : "assets/icons/play.svg",
              semanticsLabel: "play",
            )
          ],
        ),
      ),
    );
  }
}

class Action extends StatelessWidget {
  Action({this.text, required this.image});
  final text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(image),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            (() {
              if (text != null) {
                return text;
              }
              return '--';
            }()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
