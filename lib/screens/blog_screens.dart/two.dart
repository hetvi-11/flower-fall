import 'package:flower_fall/constants/blog_heading.dart';
import 'package:flower_fall/constants/bullet_points.dart';
import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/screens/blog_screens.dart/five.dart';
import 'package:flower_fall/screens/blog_screens.dart/four.dart';
import 'package:flower_fall/screens/blog_screens.dart/one.dart';
import 'package:flower_fall/screens/blog_screens.dart/three.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Two extends StatefulWidget {
  const Two({Key? key, required this.image}) : super(key: key);
  final image;
  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                QuestionTitle(
                    question: 'Avoid Caffine.',
                    subtitle: 'Published August 19,2021'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(widget.image),
                  fit: BoxFit.fill,
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                QuestionTitle(question: 'Introduction', subtitle: ''),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                  child: Para(
                      text:
                          'Caffeine is a psychoactive ingredient that is naturally added to coffee. Apart from coffee, it is also counted in numerous sodas and other drinks. However, with coffee being used in numerous concentrated drinks, analysis is still on its long-term consequence on health.'),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Para(
                      text:
                          'The moderate caffeine intake is considered pretty normal, but the excess intake leads to several adverse effects on the human body.'),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Para(
                      text:
                          'However, caffeine affects people differently, depending on their gender, age group, and sensitivity. People sensitive to caffeine may experience insomnia, restlessness, and anxiety sometimes. As per the experts, exceeding 4+ cups of coffee per day is considered too much.'),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                  child: Text(
                    'What Are The Symptoms Of Having Too Much Coffee?',
                    style: TextStyle(
                      color: kDarkBlue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      UnorderedList([
                        "Dehydration",
                        "Insomnia",
                        "Anxiety Issues",
                        "Abnormal Blood Pressure",
                        "Increased Heart Rate"
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
               BlogHeading(text: 'Who should avoid Coffee?'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Para(
                      text:
                          'Coffee does not suit everyone, and it is not made for everyone. Everybody is unique, and you may want to avoid coffee if you are facing any of the issues as follows:'),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Column(
                    children: [
                      UnorderedList([
                        "Have migraines or chronic headaches.",
                        "Have high blood pressure.",
                        "Have any sleep disorder, like insomnia.",
                        "Have ulcers",
                        "Have anxiety",
                        "Have fast or irregular heartbeat"
                      ])
                    ],
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                 BlogHeading(text: 'Tips on avoiding/quitting Coffee?'),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Para(
                    text:
                        'Coffee is something that cannot be quit directly. However, you can reduce it gradually each day. Additionally, you can look for alternatives and substitutes to ensure that you are making a healthy choice. For instance, you can keep on sipping water - it is not only a healthy choice but also assists you to flush out toxins. Replace fruit juices with caffeinated drinks or opt for smoothies.',
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Para(
                      text:
                          'Your lifestyle is your choice. You can also connect with your dietician to create a custom plan.'),
                )
              ]),
            ),
            SizedBox(height: 3.w,),
            Column(
              children: [
                HealthTip(
                  leading: 'images/lead5.png',
                  title: 'How you like to relax.',
                  subtitle: 'Published Aug 19, 2021',
                  image: 'images/list5.png',
                  path: One(
                    image: 'images/one.png',
                  ),
                ),
                HealthTip(
                  leading: 'images/lead2.png',
                  title: 'Favorite home remedies.',
                  subtitle: 'Published Aug 21, 2021',
                  image: 'images/list2.png',
                  path: Three(
                    image: 'images/three.png',
                  ),
                ),
                HealthTip(
                  leading: 'images/lead3.png',
                  title: 'Avoid Pills',
                  subtitle: 'Published Aug 19, 2021',
                  image: 'images/list3.png',
                  path: Four(
                    image: 'images/four.png',
                  ),
                ),
                HealthTip(
                  leading: 'images/lead4.png',
                  title: 'Healthline Nutrition',
                  subtitle: 'Published Aug 19, 2021',
                  image: 'images/list4.png',
                  path: Five(
                    image: 'images/five.png',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
