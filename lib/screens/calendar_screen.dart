import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/drawerlist_widget.dart';
import 'package:flower_fall/provider/date_provider.dart';
import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/details_screen.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flower_fall/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_calendar_carousel/classes/marked_date.dart';
import 'package:flutter_calendar_carousel/classes/multiple_marked_dates.dart';
import 'package:collection/collection.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../main.dart';

class Calendar extends StatefulWidget {

  static final String routeName =
      "/CalendarScreen";
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var selectedDate;
  var cycleLength;
  var periodLength;
  bool checker = false;
  bool tap = false;
  String? dropText;
  String? calMoodText;
  String? calMoodImage;
  String? calSleepImage;
  String? calWeightImage;
  String? calSymptomImage;
  String? calFlowImage;
  String? symptoms;
  var sleep;
  var currentWeight;
  bool isLoading = false;

  DateTime? dateSelected;
  List<DateTime> selectDate = [];
  List<DateTime> blackDate = [];
  List<DateTime> noFlowDetails = [];

  EventList<Event>? _markedDateMap ;
  static Widget _eventIcon = new Container(
    height: 5,
      width: 5,
    decoration: new BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,)
  );

  Future getData(context) async {
    setState(() {
      isLoading = true;
    });
    selectDate = [
      ...Provider.of<DateProvider>(context, listen: false).setSelectedDateList()
    ];
    final provider = Provider.of<PeriodProvider>(context, listen: false);
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    provider.period.userid = userprovider.user.id;
    List<DateTime> detailsDate = await provider.getAllPeriodByNoFlow(
        flow: "No Flow", userId: provider.period.userid!);
    List<DateTime> data = await provider.getAllPeriodByFlow(
        flow: "No Flow", userId: provider.period.userid!);
    data.forEach((e) {
      if (!selectDate.contains(e)) {
        selectDate.add(e);
        print(e);
      }
    });
    detailsDate.forEach((element) {
      noFlowDetails.add(element);
      print("------in add no flow list");
      if (selectDate.contains(element)) {
        selectDate.remove(element);
        // noFlowDetails.add(element);
      }
    });

    _markedDateMap = EventList<Event>(
        events: {}
    );

    noFlowDetails.forEach((date) {
      setState(() {
        _markedDateMap!.add(date, new Event(date: date,
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 15.0,
            width: 15.0,
          ),));
      });
    });

    selectDate.sort((a, b) => a.compareTo(b));
    DateTime now = selectDate.first;

    //=== Average
    List<int> length = [];
    List<DateTime> dateList = [];
    List<int> cycleList = [];
    DateTime startDate = DateTime.now();
    int total = 1;


    for(int i = 0 ; i<6 ; i++){
      selectDate.forEach((date){
        if(date.month == startDate.month && date.year == startDate.year){
          dateList.add(date);
        }
        else{
          if(date.isAfter(DateTime.now()) && date.isBefore(DateTime.now().add(Duration(days: 12)))  )
            if(date.difference(dateList.last).inDays<=1){
              if(!dateList.contains(date))
              dateList.add(date);
            }
        }

      });
       startDate = DateTime(startDate.year,(startDate.month-1)%12, startDate.day );
    }
    dateList.sort((a,b)=> a.compareTo(b));
    int counter = 1;
    for(int i = 0;i<dateList.length; i++ ){

      if(i== (dateList.length-1)){
        length.add(counter);
        counter = 1;
      }else{
        print(dateList[i+1].difference(dateList[i]).inDays);
        if(dateList[i+1].difference(dateList[i]).inDays> 10){
          cycleList.add(dateList[i+1].difference(dateList[i]).inDays-1);
        }
        if(dateList[i+1].difference(dateList[i]).inDays<=1){
          counter++;
          total++;
        }else{
          length.add(counter);
          counter = 1;
          total++;
        }}
    }

    final userProvider =  Provider.of<UserProvider>(context, listen: false);

    if(length.length > 5) {
      double periodAvg = total / length.length;
        userProvider.updateCycle(cycleLength: userProvider.user.cycleLength!,
            periodLength: periodAvg.round().toString());
      print("Average : ${total / length.length}");
    }

    if(cycleList.length > 5) {
      double cycleAvg = cycleList.sum / cycleList.length;
      print("cycleAverage : $cycleAvg");
        userProvider.updateCycle(cycleLength: cycleAvg.round().toString(),
            periodLength: userProvider.user.periodLength);
    }

    for (int i = 0; i < 365; i++) {
      blackDate.add(now);
      now = now.add(Duration(days: 1));
    }
    print(selectDate.length.toString() + " Select");

    List temp = [...blackDate];
    print(selectDate);

    temp.forEach((element) {
      if (selectDate.contains(element)) blackDate.remove(element);
    });

    cycleList.clear();
    dateList.clear();
    setState(() {
      isLoading = false;
    });
  }

  DateTime? _currentDate;
  DateTime? _dateSelected;
  String _currentMonth = DateFormat.yMMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  List<MarkedDate> markedDate = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await getData(context);

      _currentDate = selectDate.first;
      selectDate.forEach((date) {
        setState(() {
          markedDate.add(MarkedDate(
            color: Color(0xBBFF9AA2),
            date: date,
            textStyle: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w400),
          ));
        });
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Color(0x99C0E4F1),
      onDayPressed: (date, events) async {
        this.setState(() => _dateSelected = date);
        tap = true;
        dateSelected = date;
        final periodProvider =
            Provider.of<PeriodProvider>(context, listen: false);
        periodProvider.readAll();
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        var exists = await periodProvider.existsChosenDetails(
            userId: userProvider.user.id!, chosen: date);
        if (exists == true) {
          await periodProvider.readPeriod(
              userId: userProvider.user.id!, chosenDate: date);
          checker = true;
          dropText = periodProvider.period.flow;
          calFlowImage = periodProvider.period.flowImage;
          currentWeight = periodProvider.period.currentWeight;
          calWeightImage = periodProvider.period.weightImage;
          sleep = periodProvider.period.sleep;
          calSleepImage = periodProvider.period.sleepImage;
          calMoodText = periodProvider.period.mood;
          calMoodImage = periodProvider.period.moodImage;
          symptoms = periodProvider.period.symptoms;
          calSymptomImage = periodProvider.period.symptomsImage;
        } else {
          checker = false;
        }
        setState(() {});
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: true,
      daysTextStyle: TextStyle(
          fontSize: 18, color: Color(0xFF666666), fontWeight: FontWeight.w400),
      multipleMarkedDates: MultipleMarkedDates(markedDates: markedDate),
      markedDatesMap: _markedDateMap,
      childAspectRatio: 1.3,
      weekendTextStyle: TextStyle(
          fontSize: 18, color: Color(0xFF666666), fontWeight: FontWeight.w400),
      weekDayFormat: WeekdayFormat.standaloneNarrow,
      selectedDayButtonColor: Color(0x99666666),
      weekdayTextStyle: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      thisMonthDayBorderColor: Colors.transparent,
      height: 37.h,
      selectedDateTime: _dateSelected,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.black)),
      markedDateCustomTextStyle: TextStyle(
          fontSize: 18, color: Color(0xFF666666), fontWeight: FontWeight.w400),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Color(0xFF666666),
      ),
      markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      markedDateIconBuilder: (event) {
        return event.icon ?? Icon(Icons.radio_button_off_outlined);
      },
      markedDateMoreShowTotal: true,
      todayButtonColor: Color(0x99C0E4F1),
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),

      minSelectedDate: _currentDate,
      maxSelectedDate: DateTime(2023,12,12),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.blue,
      ),
      inactiveDaysTextStyle: TextStyle(color: Color(0xFF666666), fontSize: 18),
      inactiveWeekendTextStyle:
          TextStyle(color: Color(0xFF666666), fontSize: 18),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMMM().format(_targetDateTime);
        });
      },
    );

    return Scaffold(
      endDrawer: Drawer(
        elevation: 16.0,
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                title:
                    Consumer<UserProvider>(builder: (context, provider, child) {
                  return Text(
                    '${provider.user.name}',
                    style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }),
                subtitle:
                    Consumer<UserProvider>(builder: (context, provider, child) {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Calendar()));
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
              DrawerList(
                text: 'Sign Out',
                icon: 'assets/icons/log out.svg',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert"),
                          content: Text('Are you sure you want to Sign Out?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text("Confirm"),
                              onPressed:  () async {
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
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation : 0.0,
        backwardsCompatibility: false,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.segment_rounded),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        titleSpacing: 0,
        leading:  IconButton(
            onPressed: () {
              // chosen = null;
             Get.back();
            },
            icon: Icon(Icons.keyboard_arrow_left)),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text('Calendar',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: Colors.black
        ),),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : blackDate.isEmpty
              ? Center(
                  child: Text("Something went wrong!!"),
                )
              : selectDate.isEmpty
                  ? Center(
                      child: Text("SelectDate Is Empty"),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width,
                            minHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 3.h,
                                  bottom: 16.0,
                                  left: 5.w,
                                  right: 5.w,
                                ),
                                child: new Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      _currentMonth,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0,
                                      ),
                                    )),
                                    IconButton(
                                      icon: Icon(Icons.arrow_back_ios_rounded),
                                      iconSize: 18,
                                      onPressed: () {
                                        setState(() {
                                          _targetDateTime = DateTime(
                                              _targetDateTime.year,
                                              _targetDateTime.month - 1);
                                          _currentMonth = DateFormat.yMMM()
                                              .format(_targetDateTime);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.arrow_forward_ios_rounded),
                                      iconSize: 18,
                                      onPressed: () {
                                        setState(() {
                                          _targetDateTime = DateTime(
                                              _targetDateTime.year,
                                              _targetDateTime.month + 1);
                                          _currentMonth = DateFormat.yMMM()
                                              .format(_targetDateTime);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 16.0),
                                child: _calendarCarouselNoHeader,
                              ),

                              Divider(
                                height: 5,
                                color: Color(0xFFEAEAEA),
                                indent: 10,
                                endIndent: 10,
                                thickness: 2,
                              ),
                              if (checker == true && tap == true)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (dropText != null &&
                                                    calFlowImage != null)
                                                  Heading(
                                                      text: 'Menstrual Flow'),
                                                SizedBox(height: 8.0),
                                                if (dropText != null &&
                                                    calFlowImage != null)
                                                  HistoryRow(
                                                    image: calFlowImage!,
                                                    text: dropText!,
                                                  )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (currentWeight != null &&
                                                    calWeightImage != null)
                                                  Heading(
                                                      text: 'Current Weight'),
                                                SizedBox(height: 8),
                                                if (currentWeight != null &&
                                                    calWeightImage != null)
                                                  HistoryRow(
                                                      image: calWeightImage!,
                                                      text:
                                                          '$currentWeight Kg\'s')
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (calSleepImage != null &&
                                                  sleep != null)
                                                Heading(text: 'Sleep'),
                                              SizedBox(height: 5),
                                              if (calSleepImage != null &&
                                                  sleep != null)
                                                HistoryRow(
                                                    image: calSleepImage!,
                                                    text: '$sleep Hr\'s')
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (calMoodImage != null &&
                                                    calMoodText != null)
                                                  Heading(text: 'Mood'),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                if (calMoodImage != null &&
                                                    calMoodText != null)
                                                  HistoryRow(
                                                      image: calMoodImage!,
                                                      text: calMoodText!)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                if (calSymptomImage != null &&
                                                    symptoms != null)
                                                  Heading(text: 'Symptoms'),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                if (calSymptomImage != null &&
                                                    symptoms != null)
                                                  HistoryRow(
                                                      image: calSymptomImage!,
                                                      text: symptoms!)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       vertical: 10.0),
                                    //   child: Row(
                                    //     children: [
                                    //       Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 30.0),
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //           children: [
                                    //             Heading(text: 'Notes'),
                                    //           ],
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                              //   child: TextFormField(
                              //     keyboardType: TextInputType.text,
                              //     decoration: InputDecoration(
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(5),
                              //       ),
                              //       labelText: 'Write Something',
                              //     ),
                              //   ),
                              // ),
                              if (checker == false &&
                                  tap == true &&
                                  dateSelected!.isBefore(DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day + 1)))
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Color(0x99C0E4F1),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Details(
                                                            chosenDate: DateTime(
                                                                dateSelected!
                                                                    .year,
                                                                dateSelected!
                                                                    .month,
                                                                dateSelected!
                                                                    .day),
                                                          ))).then((value) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MyRoute(
                                                        builder: (context) =>
                                                            Calendar()));
                                              });
                                            },
                                            icon: Icon(Icons.add, size: 35),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Log your symptoms!",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'Want to ADD?',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              if (tap == false)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 50, horizontal: 20.0),
                                        child: Text(
                                          'Please select your period date to see the details!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }
}

class HistoryRow extends StatelessWidget {
  HistoryRow({required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: SvgPicture.asset(image),
          height: 35,
          width: 35,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Color(0xFF333333),
          ),
        )
      ],
    );
  }
}

class Heading extends StatelessWidget {
  Heading({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: kDarkGrey,
      ),
    );
  }
}
