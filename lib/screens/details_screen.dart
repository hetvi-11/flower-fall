import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/constants/drawerlist_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/provider/period_provider.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/calendar_screen.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flower_fall/screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Details extends StatefulWidget {
  const Details({required this.chosenDate, Key? key}) : super(key: key);
  final chosenDate;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Type? selectedFlowType;
  Mood? selectedMood;
  List<String> selectedSymptom = [];
  List<String> selectedList = [];
  String? dropText;
  String? calMoodText;
  String? calMoodImage;
  String? calSleepImage;
  String? calWeightImage;
  String? calSymptomImage;
  String? calFlowImage;
  var sleep;
  int selectedFlowIndex = -1;
  var currentWeight;
  List<Map> flowList  =[
    {
      "text": 'No Flow',
      "flowimage": 'NoFlowEmoji',
      "flowType": Type.NoFlow,
    },
    {
      "text": 'Low',
      "flowimage": 'LowDropEmoji',
      "flowType": Type.Low,
    },
    {
      "text": 'Normal',
      "flowimage": 'NormalDropEmoji',
      "flowType": Type.Normal,
    },
    {
      "text": 'Medium',
      "flowimage": 'MediumDropEmoji',
      "flowType": Type.Medium,
    },
    {
      "text": 'Heavy',
      "flowimage": 'HeavyDropEmoji',
      "flowType": Type.Heavy,
    }
  ];

  buttonValidation()async{
    updateImage();
    Provider.of<PeriodProvider>(
        context,
        listen: false)
        .reset();
    final provider =
    Provider.of<PeriodProvider>(
        context,
        listen: false);
    final userProvider =
    Provider.of<UserProvider>(
        context,
        listen: false);
    provider.period.userid =
        userProvider.user.id;

    provider.period.chosenDate = widget.chosenDate;
    provider.period.flow = dropText;
    provider.period.flowImage = calFlowImage;
    provider.period.currentWeight = currentWeight;
    provider.period.weightImage = calWeightImage;
    provider.period.sleep = sleep;
    provider.period.sleepImage = calSleepImage;
    provider.period.mood = calMoodText;
    provider.period.moodImage = calMoodImage;
    provider.period.symptoms = selectedSymptom.join(",");
    provider.period.symptomsImage = calSymptomImage;
    var exists = await provider.existsChosenDetails(userId: userProvider.user.id!, chosen: widget.chosenDate);
    if(exists == true) {
      var test = await provider.readPeriod(userId: userProvider.user.id!, chosenDate: widget.chosenDate);
      await provider.updatePeriodData(
        userId: userProvider.user.id!,
          chosenDate: widget.chosenDate,
          flow: dropText != null ? dropText : test.flow,
          flowImage: calFlowImage != null ? calFlowImage : test.flowImage,
          currentWeight: currentWeight != null ? currentWeight : test.currentWeight,
          weightImage: calWeightImage != null ? calWeightImage : test.weightImage,
          sleep: sleep != null ? sleep : test.sleep,
          sleepImage: calSleepImage != null ? calSleepImage : test.sleepImage,
          mood: calMoodText != null ? calMoodText : test.mood,
          moodImage: calMoodImage != null ? calMoodImage : test.moodImage,
          symptoms: selectedSymptom.isNotEmpty ? selectedSymptom.join(",") : test.symptoms,
          symptomImage: calSymptomImage != null ? calSymptomImage : test.symptomsImage);
    }
    else{
      provider.period.userid = userProvider.user.id;
      provider.period.chosenDate = widget.chosenDate;
      provider.period.flow = dropText;
      provider.period.flowImage = calFlowImage;
      provider.period.currentWeight = currentWeight;
      provider.period.weightImage = calWeightImage;
      provider.period.sleep = sleep;
      provider.period.sleepImage = calSleepImage;
      provider.period.mood = calMoodText;
      provider.period.moodImage = calMoodImage;
      provider.period.symptoms = selectedSymptom.join(",");
      provider.period.symptomsImage = calSymptomImage;
       provider.addPeriod();
    }
    provider.readAll();
    Navigator.pop(context);
  }

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
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
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
          title: Row(
            children: [
              Text(
                DateFormat.MMMMd().format(widget.chosenDate),
                style: TextStyle(
                  color: kDarkBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
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
                Row(
                  children: [
                    QuestionTitle(
                      question: 'Menstrual Flow',
                      subtitle: 'What is the intensity of your period?',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 3.0),
                  child: Container(
                    height: 30.w,
                    width: 100.w-20,
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                        return FlowType(
                          onTap:  () {
                            switch(flowList[index]["flowType"]){
                              case Type.NoFlow:
                                selectedFlowType = Type.NoFlow;
                                selectedFlowIndex = 0;
                                dropText = "No Flow";
                                break;

                              case Type.Low:
                                selectedFlowType = Type.Low;
                                selectedFlowIndex = 1;
                                dropText = "Low";
                                break;

                              case Type.Normal:
                                selectedFlowType = Type.Normal;
                                selectedFlowIndex = 2;
                                dropText = "Normal";
                                break;

                              case Type.Medium:
                                selectedFlowType = Type.Medium;
                                selectedFlowIndex = 3;
                                dropText = "Medium";
                                break;

                              case Type.Heavy:
                                selectedFlowType = Type.Heavy;
                                selectedFlowIndex = 4;
                                dropText = "Heavy";
                                break;

                            }
                            setState(() {
                            });
                          },
                          text: flowList[index]["text"],
                          flowimage: flowList[index]["flowimage"],
                          flowType:flowList[index]["flowType"],
                          selectedFlowType: selectedFlowType,
                          index: index,
                            selectedFlowIndex:selectedFlowIndex,
                        );
    }
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 1.5.w, right: 1.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                QuestionColumn(
                                    question: 'Current Weight',
                                    subtitle: 'Did you loose weight?'),
                              ],
                            ),
                            InputText(
                              labeltext: 'Weight',
                              suffixtext: 'kg\'s',
                              regex: r'^[1-9][0-9]?$|^100$',
                              onChanged: (value) {
                                currentWeight = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                QuestionColumn(
                                    question: 'Sleep',
                                    subtitle: 'How long you sleep?'),
                              ],
                            ),
                            InputText(
                              labeltext: 'Sleep Time',
                              suffixtext: 'Hrs',
                              regex: r'^([1-9]|1[012])$',
                              onChanged: (value) {
                                sleep = value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    QuestionTitle(
                      question: 'Mood',
                      subtitle: 'How are you feeling today?',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedMood = Mood.Calm;
                            //moodSelection = selectedMood;
                            calMoodText = 'Calm';
                          });
                        },
                        child: MoodType(
                          text: 'Calm',
                          image: 'assets/icons/LeafEmoji.svg',
                          moodType: Mood.Calm,
                          selectedMood: selectedMood,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedMood = Mood.Happy;
                            // moodSelection = selectedMood;
                            calMoodText = 'Happy';
                          });
                        },
                        child: MoodType(
                          text: 'Happy',
                          image: 'assets/icons/SmileyEmoji.svg',
                          selectedMood: selectedMood,
                          moodType: Mood.Happy,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedMood = Mood.Sad;
                            // moodSelection = selectedMood;
                            calMoodText = 'Sad';
                          });
                        },
                        child: MoodType(
                          text: 'Sad',
                          image: 'assets/icons/SmileySadEmoji.svg',
                          selectedMood: selectedMood,
                          moodType: Mood.Sad,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedMood = Mood.Energetic;
                            // moodSelection = selectedMood;
                            calMoodText = 'Energetic';
                          });
                        },
                        child: MoodType(
                          text: 'Energetic',
                          image: 'assets/icons/SmileyWinkEmoji.svg',
                          selectedMood: selectedMood,
                          moodType: Mood.Energetic,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedMood = Mood.Irritable;
                            // moodSelection = selectedMood;
                            calMoodText = 'Irritable';
                          });
                        },
                        child: MoodType(
                          text: 'Irritable',
                          image: 'assets/icons/SmileyXEyesEmoji.svg',
                          selectedMood: selectedMood,
                          moodType: Mood.Irritable,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    QuestionTitle(
                        question: 'Symptoms',
                        subtitle: 'How are you feeling today?'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SymptomsList(
                        selectedList: selectedSymptom,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 1.5.w, right: 1.5.w, top: 15.0, bottom: 10.0),
                  child: kCustomButton(
                      onPressed: () => buttonValidation(),
                      text: 'Done'),
                ),

              ],
            ),
          ),
        ));
  }

  updateImage() {
    if (selectedMood == Mood.Calm) {
      calMoodImage = 'assets/icons/LeafEmoji.svg';
    } else if (selectedMood == Mood.Happy) {
      calMoodImage = 'assets/icons/SmileyEmoji.svg';
    } else if (selectedMood == Mood.Sad) {
      calMoodImage = 'assets/icons/SmileySadEmoji.svg';
    } else if (selectedMood == Mood.Energetic) {
      calMoodImage = 'assets/icons/SmileyWinkEmoji.svg';
    } else if (selectedMood == Mood.Irritable) {
      calMoodImage = 'assets/icons/SmileyXEyesEmoji.svg';
    } else {
      print('in else of calMoodImage');
      selectedMood = null;
      calMoodImage = null;
    }

    if (sleep != null) {
      if (int.parse(sleep) >= 6) {
        calSleepImage = 'assets/icons/ThumbsUp.svg';
      } else {
        calSleepImage = 'assets/icons/ThumbsDown.svg';
      }
    } else {
      print("in else of sleep");
      calSleepImage = null;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (currentWeight != null && userProvider.user.weight != null) {
      if (int.parse(currentWeight) < int.parse(userProvider.user.weight!)) {
        calWeightImage = 'assets/icons/TrendDown.svg';
      } else {
        calWeightImage = 'assets/icons/TrendUp.svg';
      }
    } else {
      print("in else of weight");
      calWeightImage = null;
    }

    if (selectedSymptom.contains('I\'m Fine')) {
      calSymptomImage = 'assets/icons/ActivityGreen.svg';
    } else if (selectedSymptom.contains('Cramps') ||
        selectedSymptom.contains('Backpain') ||
        selectedSymptom.contains('Acne') ||
        selectedSymptom.contains('Fever') ||
        selectedSymptom.contains('Headache') ||
        selectedSymptom.contains('Diarrhea')) {
      calSymptomImage = 'assets/icons/Activity.svg';
    } else {
      print("in else of symptoms");
      calSymptomImage = null;
    }

    if (selectedFlowType == Type.Low) {
      calFlowImage = 'assets/icons/LowDropEmoji_dark.svg';
    } else if (selectedFlowType == Type.NoFlow) {
      calFlowImage = 'assets/icons/NoFlowEmoji_dark.svg';
    }else if (selectedFlowType == Type.Normal) {
      calFlowImage = 'assets/icons/NormalDropEmoji_dark.svg';
    } else if (selectedFlowType == Type.Medium) {
      calFlowImage = 'assets/icons/MediumDropEmoji_dark.svg';
    } else if (selectedFlowType == Type.Heavy) {
      calFlowImage = 'assets/icons/HeavyDropEmoji_dark.svg';
    } else {
      print("in else of flow");
      selectedFlowType = null;
      calFlowImage = null;
    }
  }
}

enum Type {
  NoFlow,
  Low,
  Normal,
  Medium,
  Heavy,
}

class FlowType extends StatefulWidget {
  FlowType(
      {required this.text,
        required this.onTap,
      this.flowimage,
        this.index,
        this.selectedFlowIndex,
      required this.flowType,
      required this.selectedFlowType});
  final flowimage;
  final onTap;
  final text;
  final index;
  final flowType;
  final selectedFlowType;
  final selectedFlowIndex;

  @override
  _FlowTypeState createState() => _FlowTypeState();
}

class _FlowTypeState extends State<FlowType> {
  late Type flowType;
  Color containerColor = Colors.white;
  Color imageColor = kDarkBlue;
  @override
  void initState() {
    super.initState();
    flowType = widget.flowType;
  }

  @override
  Widget build(BuildContext context) {
          return InkWell(
            onTap: widget.onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 18.w,
                  width: 18.w,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.selectedFlowType != widget.flowType
                        ? Colors.white
                        : kDarkBlue,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRect(
                      child: Stack(fit: StackFit.passthrough, children: [

                        Container(
                          child: SvgPicture.asset(
                            'assets/icons/${ widget.index == widget.selectedFlowIndex ? widget.flowimage :widget.flowimage + "_dark" }.svg',
                            height: 18.w,
                            width: 18.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: kDarkBlue,
                  ),
                )
              ],
            ),
          );
  }
}

class InputText extends StatelessWidget {
  InputText(
      {required this.labeltext,
      required this.suffixtext,
        required this.regex,
      required this.onChanged});
  final labeltext;
  final suffixtext;
  final regex;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(regex))],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(15.0),
          ),
          labelText: labeltext,
          suffixText: suffixtext,
          counterText: "",
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class MoodType extends StatefulWidget {
  MoodType(
      {required this.text,
      required this.image,
      required this.moodType,
      required this.selectedMood});
  final text;
  final image;
  final moodType;
  final selectedMood;

  @override
  _MoodTypeState createState() => _MoodTypeState();
}

enum Mood {
  Calm,
  Happy,
  Sad,
  Energetic,
  Irritable,
}

class _MoodTypeState extends State<MoodType> {
  late Mood moodType;
  @override
  void initState() {
    super.initState();
    moodType = widget.moodType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.selectedMood != widget.moodType
                ? Colors.white
                : kDarkBlue,
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(widget.image),
          ),
        ),
        SizedBox(height: 4,),
        Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Color(0xFF1F2937),
          ),
        )
      ],
    );
  }
}

class QuestionColumn extends StatelessWidget {
  QuestionColumn({required this.question, required this.subtitle});
  final question;
  final subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 05.w, horizontal: 04.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  question,
                  style: TextStyle(
                    color: Color(0xFF1F2937),
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
            width: 40.w,
            child: FittedBox(

              child: Text(
                subtitle,
                maxLines: 1,
                style: TextStyle(

                  color: kGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<String> symptoms = [
  'Cramps',
  'I\'m Fine',
  'Backpain',
  'Acne',
  'Fever',
  'Headache',
  'Diarrhea',
];

class SymptomsList extends StatefulWidget {
  final List<String> selectedList;
  SymptomsList({required this.selectedList});

  @override
  _SymptomsListState createState() => _SymptomsListState();
}

class _SymptomsListState extends State<SymptomsList> {
  Color textColor = Color(0xFF1F2937);
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100.w - 20,
      child: ListView.builder(
          itemCount: symptoms.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            textColor = widget.selectedList.contains(symptoms[index])
                ? Colors.white
                : Color(0xFF1F2937);
            bgColor = !widget.selectedList.contains(symptoms[index])
                ? Colors.white
                : Color(0xFF1F2937);
            return InkWell(
              child: Container(
                height: 35,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: bgColor,
                  border: Border.all(
                    color: Color(0xFF1F2937),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      symptoms[index],
                      style: TextStyle(
                        fontSize: 15,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  if (widget.selectedList.contains(symptoms[index])) {
                    widget.selectedList.remove(symptoms[index]);
                  } else {
                    widget.selectedList.add(symptoms[index]);
                  }
                  setState(() {});

                });
              },
            );
          }),
    );
  }
}
