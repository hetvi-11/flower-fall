import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/analysis_screen.dart';
import 'package:flower_fall/screens/basicDetails_screen.dart';
import 'package:flower_fall/screens/dateSelect_screen.dart';
import 'package:flower_fall/screens/home_screen.dart';
import 'package:flower_fall/screens/periodDuration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String routeName = "/SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  var sf;
  var psf;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("firebase initialization completed");
      setState(() {});
    });

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    // Animation<double> animation =
    // CurvedAnimation(parent: controller, curve: Curves.easeInCubic);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Future.delayed(Duration(seconds: 2), () {
        initVariable(context);
      });
    });
  }

  initVariable(context) async {
    sf = await getIntValuesSF();
    psf = await getPeriodIntValuesSF();
    setState(() {});
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final periodProvider = Provider.of<PeriodProvider>(context, listen: false);
    if (sf != null) {
      var exists = await userProvider.readUserById(userid: sf);
      if (psf != null) {
        var pexists = await periodProvider.readPeriodById(id: psf);
        print(pexists.toJson());
      }
      if (userProvider.user.dob == null ||
          userProvider.user.name == null ||
          userProvider.user.weight == null) {
        Get.offAll(() => BasicDetailsPage());
        return;

      }
      if (userProvider.user.cycleLength == null ||
          userProvider.user.periodLength == null) {
        Get.offAll(() => PeriodDuration());
        return;

      }
      if (userProvider.user.selectedDate == null) {
        Get.offAll(() => DateSelect());
        return;
      }
      print(userProvider.user.toJson());
      Navigator.push(context, MaterialPageRoute(builder: (_) => Analysis()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt('intValue');
    print(intValue);
    return intValue;
  }

  getPeriodIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? intValue = prefs.getInt('intPeriodValue');
    print(intValue);
    return intValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: 'flower',
                    child: AnimatedBuilder(
                      animation: controller,
                      child: Image.asset('images/Flower.png'),
                      builder: (BuildContext context, Widget? child) {
                        return Transform.rotate(
                          angle: controller.value * 1.0,
                          child: child,
                        );
                      },
                    ),
                    transitionOnUserGestures: true,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        fit: StackFit.passthrough,
                        //overflow: Overflow.visible,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('images/water.png'),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 100.0),
                              child: Image.asset('images/waveline.png'),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  10.0, 80.0, 50.0, 20.0),
                              child: Image.asset(
                                'images/whiteFlowerText.png',
                                color: Colors.white,
                                alignment: Alignment.bottomLeft,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ]),
        ),
      ),
    );
  }
}
