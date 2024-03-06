import 'package:flower_fall/components/numberpicker.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/dateSelect_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeriodDuration extends StatefulWidget {
  const PeriodDuration({Key? key}) : super(key: key);

  @override
  _PeriodDurationState createState() => _PeriodDurationState();
}

class _PeriodDurationState extends State<PeriodDuration> {
  int _cycleLength = 25;
  int _periodLength = 7;
  String? cycleLength = '25';
  String? periodLength = '7';

  buttonValidation(){
    if(cycleLength != null) {
      if(periodLength != null){
        final userProvider = Provider.of<UserProvider>(context, listen:  false);
        userProvider.user.periodLength = periodLength;
        userProvider.user.cycleLength = (int.parse(cycleLength!)- int.parse(periodLength!)).toString();
        userProvider.updateUserCycle();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DateSelect()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 70, 30, 0),
                    child: Center(
                      child: Image.asset('images/flowerFallColoured.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Question(
                      text: 'What is your period cycle length?',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: NumberPicker(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.black),
                        //color: Color(0xFF1F2937),
                      ),
                      axis: Axis.horizontal,
                      minValue: 1,
                      maxValue: 100,
                      value: _cycleLength,
                      onChanged: (value) {
                        setState(() {
                          _cycleLength = value;
                          cycleLength = value.toString();
                        });
                        // periodCycleLength = _currentHorizontalIntValue.toString();
                      }),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Question(text: 'What is your period length?'),
                    )),
                Expanded(
                  flex: 2,
                  child: NumberPicker(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.black),
                        //color: Color(0xFF1F2937),
                      ),
                      axis: Axis.horizontal,
                      minValue: 1,
                      maxValue: 12,
                      value: _periodLength,
                      onChanged: (value) {
                        setState(() {
                          _periodLength = value;
                          periodLength = value.toString();
                        });
                        // periodLength = _currentValue.toString();
                      }),
                ),
                Padding(
                  padding:EdgeInsets.only(top: 20.0),
                  child: kCustomButton(
                    text: 'Next',
                    onPressed: () => buttonValidation()
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: kCopyright(),
                ),
              ],
            ),
          )),
    );
  }
}

class Question extends StatelessWidget {
  Question({required this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
