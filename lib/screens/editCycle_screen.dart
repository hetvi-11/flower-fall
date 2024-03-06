import 'package:flower_fall/components/numberpicker.dart';
import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/analysis_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditCycle extends StatefulWidget {
  const EditCycle({Key? key}) : super(key: key);

  @override
  _EditCycleState createState() => _EditCycleState();
}

class _EditCycleState extends State<EditCycle> {
  int _currentHorizontalIntValue = 25;
  int _currentValue = 7;
  String? cycleLength;
  String? periodLength;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                  ),
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 100,
                  value: _currentHorizontalIntValue,
                  onChanged: (value) {
                    setState(() {
                      _currentHorizontalIntValue = value;
                      cycleLength = value.toString();
                      print('cycle length after update $cycleLength');
                    });
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
                  ),
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 12,
                  value: _currentValue,
                  onChanged: (value) {
                    setState(() {
                      _currentValue = value;
                      periodLength = value.toString();
                      print('period length after update $periodLength');
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: kCustomButton(
                text: 'Done',
                onPressed: () async {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  var dbPeriodRead = await userProvider.readPeriodLength();
                  var dbCycleRead = await userProvider.readCycleLength();
                  if (periodLength == null && cycleLength == null) {
                    userProvider.user.cycleLength = dbCycleRead;
                    userProvider.user.periodLength = dbPeriodRead;
                  }
                  if (periodLength != null && cycleLength == null) {
                    print("........$dbCycleRead");
                    userProvider.user.periodLength = periodLength!;
                    if (int.parse(periodLength!) > int.parse(dbPeriodRead))
                      userProvider.user.cycleLength =
                          (int.parse(dbCycleRead) - 1).toString();
                    if (int.parse(periodLength!) < int.parse(dbPeriodRead))
                      userProvider.user.cycleLength =
                          (int.parse(dbCycleRead) + 1).toString();
                  }
                  if (periodLength == null && cycleLength != null) {
                    userProvider.user.cycleLength =
                        (int.parse(cycleLength ?? "0") -
                                int.parse(dbPeriodRead))
                            .toString();
                    userProvider.user.periodLength = dbPeriodRead;
                  }
                  if (periodLength != null && cycleLength != null) {
                    userProvider.user.periodLength = periodLength!;
                    userProvider.user.cycleLength =
                        (int.parse(cycleLength ?? "0") -
                                int.parse(periodLength ?? "0"))
                            .toString();
                  }

                  userProvider.updateCycle(
                      cycleLength: userProvider.user.cycleLength,
                      periodLength: userProvider.user.periodLength);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Analysis()));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            kCopyright(),
            SizedBox(
              height: 10.0,
            )
          ],
        ));
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
              color: kDarkBlue,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
