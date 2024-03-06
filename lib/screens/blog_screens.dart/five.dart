import 'package:flower_fall/constants/blog_heading.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/screens/blog_screens.dart/four.dart';
import 'package:flower_fall/screens/blog_screens.dart/one.dart';
import 'package:flower_fall/screens/blog_screens.dart/three.dart';
import 'package:flower_fall/screens/blog_screens.dart/two.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Five extends StatefulWidget {
  const Five({Key? key, required this.image}) : super(key: key);
  final image;
  @override
  _FiveState createState() => _FiveState();
}

class _FiveState extends State<Five> {
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
                    question: 'Healthline Nutrition.',
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
                          'Menstruation can be painful for some & usual for many. However, taking in nutritious food is consequential for all. Hence, we\'ve curated a checklist of edible items you should prioritize while menstruating.',
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Water:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Staying hydrated is significant when menstruating. It not only helps you to relieve bloating but also reduces your chances of being dehydrated.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  BlogHeading(text: 'Fruits:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Eating high in water content fruits can keep you hydrated for a longer time. Additionally, the sugar content can also benefit you to curb cravings & avoid processed sweets.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Green leafy vegetables:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Greens are beneficial for you - anytime, any day! Taking it can balance your iron levels which are usually dropped while menstruating. Consider spinach & kale for maximum benefits.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Ginger:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Ginger is well known for its anti-oxidant properties. It can benefit you to ease muscle cramps.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Chicken:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Chicken is another protein-rich diet that you can add to your diet. It can help you to stay full & curb cravings.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Turmeric:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Turmeric is well known for its anti-inflammatory properties. Hence, intaking turmeric can assist you with relieving muscle cramps by stimulating the blood flow in the uterus and the pelvic region.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                 BlogHeading(text: 'Yogurt:'),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Many people do get infected with yeast during or after menstruating. Hence, yogurt having good bacteria can assist you in fighting vaginal infections.'),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  BlogHeading(text: 'Lentils & Beans:',),
                  SizedBox(
                    height: 7,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                    child: Para(
                        text:
                            'Including lentils, beans can assist you in maintaining your iron levels if you\'re someone having iron deficiency. These are good vegan sources that can be included in your meal for maintaining balance.'),
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
                  leading: 'images/lead3.png',
                  title: 'Avoid Pills',
                  subtitle: 'Published Aug 19, 2021',
                  image: 'images/list3.png',
                  path: Four(
                    image: 'images/four.png',
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


