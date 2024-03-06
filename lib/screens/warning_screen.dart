import 'package:flower_fall/constants/para_widget.dart';
import 'package:flower_fall/constants/question_title.dart';
import 'package:flutter/material.dart';
import 'package:flower_fall/constants/bullet_points.dart';

class Warning extends StatefulWidget {
  const Warning({Key? key}) : super(key: key);

  @override
  _WarningState createState() => _WarningState();
}

class _WarningState extends State<Warning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation : 0.0,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.view_headline_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    QuestionTitle(
                      question: 'Warning.',
                      subtitle: '',),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/warning.png'),
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      children: [
                        Para(
                            text:'Morbi sed suscipit dolor. Phasellus faucibus nisl sed augue blandit, sed vestibulum eros ornare. Aenean vel auctor purus. Quisque posuere risus efficitur lorem vehicula tincidunt. Vivamus id odio dapibus, ultrices nibh sit amet, fermentum est. Nunc porta diam neque, in laoreet augue faucibus ut. Integer justo lacus, rhoncus id tortor at, malesuada pulvinar velit. Aliquam hendrerit sapien quis lorem lacinia sodales.'
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              UnorderedList([
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi mattis sodales vulputate. Donec at justo convallis, varius est ac, vehicula mauris. Praesent a pretium tortor",
                              ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}