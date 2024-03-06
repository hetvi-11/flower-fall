import 'package:flower_fall/constants/bullet_points.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/screens/blog_screens.dart/five.dart';
import 'package:flower_fall/screens/blog_screens.dart/one.dart';
import 'package:flower_fall/screens/blog_screens.dart/three.dart';
import 'package:flower_fall/screens/blog_screens.dart/two.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Four extends StatefulWidget {
  const Four({Key? key, required this.image}) : super(key: key);
  final image;
  @override
  _FourState createState() => _FourState();
}

class _FourState extends State<Four> {
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
                    question: 'Avoid Pills.',
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Menstrual cramps can be painful. For some, they are bearable but for many they are not. However, the pain intensity varies from each woman and their body type. Women suffering are usually looking for remedies for the relief and many times end up taking pain killers. '),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Painkillers are usually available to ease your daily lifestyle and benefit you with the ability to complete your work. Mild doses at times are suggested to be taken while on the other hand, as per the specialists, painkillers come with adverse side effects too',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'As per the experts, taking more than two pills a day can be risky - because you may face side effects like digestive issues, acid reflux, stomach inflammation and may also feel the problem of ulcers. ',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Usually one should avoid taking pills and look for alternatives for the cure. Everyone has their own way to manage their pain - but these are few of the alternatives that can benefit you.',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                    child: Column(
                      children: [
                        UnorderedList([
                          "Keeping a hot water bag on your pelvic area can help you to reduce inflammation and pain caused by period cramps. ",
                          "Keeping yourself hydrated also helps. Ensure having drinks that are rich in nutrients and vitamins",
                          "Avoid sugary and caffeinated drinks ",
                          "Ensure taking enough vitamin B1 in your diet. Taking in vitamin B1 helps to regulate your body’s muscular system and ease off your pain ultimately. Include foods like oats, nuts, beef and seeds for vitamin B1."
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.w,
            ),
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
                  leading: 'images/lead1.png',
                  title: 'Avoid Caffine',
                  subtitle: 'Published Aug 23, 2021',
                  image: 'images/list1.png',
                  path: Two(
                    image: 'images/two.png',
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
