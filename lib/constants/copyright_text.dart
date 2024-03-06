import 'package:flutter/material.dart';
import 'colors.dart';

class kCopyright extends StatelessWidget {
  const kCopyright({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17,
      child: Text(
        '© 2020-2021 FLOWERS FALL. All Rights Reserved.',
        style: TextStyle(
          color: kGrey,
          fontSize: 15,
        ),
      ),
    );
  }
}