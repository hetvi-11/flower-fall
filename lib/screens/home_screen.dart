import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: Stack(
            fit: StackFit.passthrough,
            //overflow: Overflow.visible,
            children: [
              Positioned(
                left: 10.w,
                right: 10.w,
                top: 30.h,
                child: Container(
                  //alignment: Alignment.topLeft,
                  child: Image.asset('images/flowerFallColoured.png',
                  height: 25.h,),
                ),
              ),
              Center(
                // top: 25.h,
                // left: 20.w,
                // right: 20.w,
                child: Container(
                  //alignment: Alignment.bottomCenter,
                  child:
                  Hero(tag: 'flower', child: Image.asset('images/Flower.png',
                  width: 60.w,
                  fit: BoxFit.fitWidth,)),
                ),
              ),
              Positioned(
                top: 40.h,
                 bottom: 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Container(
                    width: 100.w,
                    height: 60.h,
                    alignment: Alignment.bottomCenter,
                    child: Image.asset('images/water.png',
                        width: 100.w,
                        height:50.h,fit: BoxFit.cover),
                  ),
                ),
              ),
              // Positioned(
              //   top: 415.0,
              //   child: Container(
              //     alignment: Alignment.bottomCenter,
              //     child: Image.asset('images/waveline.png'),
              //   ),
              // ),
              Positioned(
                top: 70.h,
                left: 10.w,
                right: 10.w,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Take Control Of Your Cycle',
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),

                    TyperAnimatedText(
                      'Track your period data and get best advise',
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    TyperAnimatedText(
                      'Manage your irregular period and learn to improve your period',
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 2000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                  isRepeatingAnimation: true,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Image.asset('images/button.png', height: 80, width: 100, fit:BoxFit.cover),
              ),
              Positioned(
                  bottom: 15.0,
                  right: 0.0,

                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Colors.blueGrey[900],
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()),
                        );
                      });
                    },
                  )),
              Positioned(
                  bottom: 15.0,
                  right: 100.w,
                  left: 0.0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.blueGrey[900],
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
