import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/drawerlist_widget.dart';
import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/calendar_screen.dart';
import 'package:flower_fall/screens/editCycle_screen.dart';
import 'package:flower_fall/screens/editProfile_screen.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flower_fall/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:sizer/sizer.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Calendar()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Settings()));
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
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
      backgroundColor: Colors.white,
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
              Navigator.pop(context);
            },
            icon: Icon(Icons.keyboard_arrow_left)),
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,

      ),
      body: Column(
        children: [
          Column(
            children: [
              SettingList(
                text: 'Edit Profile',
                icon:'assets/icons/user.svg',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfile()));
                },
              ),
              SettingList(
                text: 'Edit Cycle',
                icon: 'assets/icons/clock.svg',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCycle()));
                },
              ),
              SettingList(text: 'Push Notifications'),
              SettingList(
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
         Spacer(),
          Padding(
            padding:EdgeInsets.only(left: 20.w, right: 20.w),
            child: Image.asset('images/flowerFallColoured.png'),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 0),
            child: Text(
              '© 2020-2021 FLOWERS FALL. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF9E9E9E),
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}

class SettingList extends StatefulWidget {
  SettingList({required this.text, this.icon, this.onTap});
  final text;
  final icon;
  final onTap;

  @override
  _SettingListState createState() => _SettingListState();
}

class _SettingListState extends State<SettingList> {
  bool? isEnabled;
  @override
  void initState() {
    super.initState();
    getBool();
  }

  getBool()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     isEnabled = prefs.getBool("isNotificationEnabled")?? false;
   });
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        child: widget.icon == null
            ?  isEnabled == null ? SizedBox():
        Switch(value: isEnabled ?? false,
          activeColor: kDarkBlue ,
          onChanged:  (value) async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            print('Is Enabled to: $value');

            if(value){
              final userProvider = Provider.of<UserProvider>(context, listen: false);
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
              setState((){
                isEnabled = value;
              });
              try{
                prefs.setBool("isNotificationEnabled", true);
              }catch(e){print("Notification service failed;");}

            }else{
            try{
              NotificationService notificationService = NotificationService();
              var flutterLocalNotificationsPlugin = notificationService.flutterLocalNotificationsPlugin;
              await flutterLocalNotificationsPlugin.cancelAll();
              prefs.setBool("isNotificationEnabled", false);
              setState((){
                isEnabled = value;
              });
            }catch(e){
              print("Notification Cancel Error $e");
            }
            }
            },
        )
            : SvgPicture.asset(widget.icon),
      ),
      onTap: widget.onTap,
    );
  }
}
