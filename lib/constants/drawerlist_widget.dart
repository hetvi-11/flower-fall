import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class DrawerList extends StatelessWidget {
  DrawerList({required this.text, required this.icon, this.onTap});
  final text;
  final icon;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.w400,
        color: Color(0xFF464646)),
      ),
      leading: Container(
        margin: EdgeInsets.only(left: 10),
        child: SvgPicture.asset(icon,
        fit: BoxFit.fitHeight,
        height: 25,
        width: 25,),
      ),
      onTap: onTap,
    );
  }
}