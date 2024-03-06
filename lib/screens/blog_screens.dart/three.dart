import 'package:flower_fall/constants/blog_heading.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/screens/blog_screens.dart/five.dart';
import 'package:flower_fall/screens/blog_screens.dart/four.dart';
import 'package:flower_fall/screens/blog_screens.dart/one.dart';
import 'package:flower_fall/screens/blog_screens.dart/two.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Three extends StatefulWidget {
  const Three({Key? key, required this.image}) : super(key: key);
  final image;
  @override
  _ThreeState createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
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
                    question: 'Home Remedies.',
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
                            'Period cramps are typical. Women do undergo it heretofore & during their menstruation cycle. Nevertheless, they are lousy for some, whereas others are not bothered enough. While in some cases - cramps can impact the everyday routine.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Hence, if you are facing severe problems related to period cramps - this article can oblige you with home remedies to make your day go Effortless.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Use a Heat Patch:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Using a heat patch can benefit you with the utmost satisfaction & aid you with period cramps. Placing the patch below your abdomen can help you relax the muscles of your uterus, aid you to get rid of period cramps and ultimately increase the blood flow.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text:  'Massage Using Essential Oils:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'As per the studies, massaging your abdomen with essential oils can aid you to EASE pain as they are quite relaxing. To gain the utmost benefit, you can use lavender, clove, sage, rose & cinnamon essential oils.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Avoid Caffeine & Salty Foods:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'One should invariably evade food that causes bloating, retention & discomfort to normalize your cramps. It is recommended to avoid salty foods, caffeinated foods, alcohol & fatty foods.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Stay Hydrated'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'As per the specialists, women are most likely to have abdomen cramps during menstruation if they are dehydrated. Hence, we recommend you keep yourself hydrated by intaking 3-4 liters of water even if you do not feel thirsty.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text:   'Try Yoga Poses For Relief:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Yoga can aid period cramps indeed! Try Child Pose, Reclined Bound Angle & Bound Angle Pose to get rid of period cramps.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Soak In Warm Water:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                      text:
                          'Soaking in a tub of warm water can benefit you the best. Warm water can assist you in getting rid of period cramps and ease down your muscles.',
                    ),
                  ),
                ],
              ),
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
                  leading: 'images/lead1.png',
                  title: 'Avoid Caffine',
                  subtitle: 'Published Aug 23, 2021',
                  image: 'images/list1.png',
                  path: Two(
                    image: 'images/two.png',
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
