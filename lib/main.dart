// @dart=2.9

import 'package:flower_fall/model/period_model.dart';
import 'package:flower_fall/provider/date_provider.dart';
import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/selectedDate_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/calendar_screen.dart';
import 'package:flower_fall/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flower_fall/screens/splash_screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    PeriodUser user = PeriodUser();
    Period period = Period();
    Dates date = Dates();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(user: user)),
        ChangeNotifierProvider<PeriodProvider>(
            create: (context) => PeriodProvider(period: period)),
        ChangeNotifierProvider<DateProvider>(
            create: (context) => DateProvider()),
        ChangeNotifierProvider<SelectedDateProvider>(
            create: (context) => SelectedDateProvider(date: date))
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            defaultTransition: Transition.cupertino,
            transitionDuration: Duration(milliseconds: 100),

            theme: ThemeData(
              brightness: Brightness.light,
            ),

            initialRoute: SplashScreen.routeName,
            // home: SplashScreen(),
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              Calendar.routeName: (context) => Calendar(),
            },
          );
        },
      ),
    );
  }
}

class MyRoute extends MaterialPageRoute {
  MyRoute({WidgetBuilder builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => Duration(seconds: 0);
}
