import 'package:flower_fall/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HealthTip extends StatelessWidget {
  HealthTip(
      {required this.leading,
        required this.title,
        required this.subtitle,
        this.path,
        required this.image});
  final leading;
  final title;
  final subtitle;
  final image;
  final path;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(1.5.w, 0.0, 1.5.w, 0.0),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
          ),
          child: ListTile(
            leading: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage(leading), fit: BoxFit.cover),
                )),
            title: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: kGrey,
                ),
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => path));
            },
          ),
        ),
      ),
    );
  }
}