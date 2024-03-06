import 'package:flower_fall/constants/bullet_points.dart';
import 'package:flower_fall/constants/healthtip_widget.dart';
import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flower_fall/screens/blog_screens.dart/five.dart';
import 'package:flower_fall/screens/blog_screens.dart/four.dart';
import 'package:flower_fall/screens/blog_screens.dart/three.dart';
import 'package:flower_fall/screens/blog_screens.dart/two.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class One extends StatefulWidget {
  const One({Key? key, required this.image}) : super(key: key);
final image;
  @override
  _OneState createState() => _OneState();
}

class _OneState extends State<One> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation : 0.0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
     
      ),
      body: SingleChildScrollView(
        child:  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            QuestionTitle(
                question: 'How you like to relax.',
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
          padding: const EdgeInsets.symmetric(
              horizontal: 10.0, vertical: 5),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0),
                child: Para(
                  text:
                  'Take a deep breath. Hold it for a moment, and then exhale. Feel more relaxed? Breathing exercises are one way to relax. Here you will learn about different ways to relax your mind and body. Being relaxed can help ease stress. It can also relieve anxiety, depression, and sleep problems.',
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  children: [
                    UnorderedList([
                      "relax means to calm the mind, the body, or both.",
                      "Relaxing can quiet your mind and make you feel peaceful and calm. Your body also reacts when you relax. For example, your muscles may be less tense and more flexible.",
                      "There are different ways to relax. You may find one or more ways help to calm you down and feel at peace."
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: 3.w, vertical: 5),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: Para(
                    text:
                    'There are lots of ways to relax. Some ways are designed to relax your mind and some to relax your body. But because of the way the mind and body are connected, many relaxation methods work on both the mind and the body'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 1.w),
                child: Para(
                    text:
                    'You may want to try one or more of the following relaxation tips to see what works best for you.'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: UnorderedList([
                  "Take slow, deep breaths. Or try other breathing exercises for relaxation.",
                  "Soak in a warm bath.",
                  "Listen to soothing music.",
                  "Practice mindful meditation. The goal of mindful meditation is to focus your attention on things that are happening right now in the present moment. For example, listen to your body. Is your breathing fast, slow, deep, or shallow? Do you hear noises, such as traffic, or do you hear only silence? The idea is just to note what is happening without trying to change it.",
                  "Write. Some people feel more relaxed after they write about their feelings. One way is to keep a journal.",
                  "Use guided imagery. With guided imagery, you imagine yourself in a certain setting that helps you feel calm and relaxed. You can use audiotapes, scripts, or a teacher to guide you through the process.",
                ]),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            QuestionTitle(
                question: 'You might like to read this.', subtitle: ''),
          ],
        ),
        Column(
          children: [
            HealthTip(
              leading: 'images/lead1.png',
              title: 'Avoid Caffine',
              subtitle: 'Published Aug 23, 2021',
              image: 'images/list1.png',
              path: Two(image: 'images/two.png'),
            ),
            HealthTip(
              leading: 'images/lead2.png',
              title: 'Favorite home remedies.',
              subtitle: 'Published Aug 21, 2021',
              image: 'images/list2.png',
              path: Three(image: 'images/three.png',),
            ),
            HealthTip(
              leading: 'images/lead3.png',
              title: 'Avoid Pills',
              subtitle: 'Published Aug 19, 2021',
              image: 'images/list3.png',
              path: Four(image: 'images/four.png',),
            ),
            HealthTip(
              leading: 'images/lead4.png',
              title: 'Healthline Nutrition',
              subtitle: 'Published Aug 19, 2021',
              image: 'images/list4.png',
              path: Five( image: 'images/five.png'),
            ),
          ],
        )
      ],
    ),
      ),
    );
  }
}


