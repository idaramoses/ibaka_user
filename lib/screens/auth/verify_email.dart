import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onproperty/utils/colorscheme.dart';

class verfiy extends StatefulWidget {
  const verfiy({Key key}) : super(key: key);

  @override
  _verfiyState createState() => _verfiyState();
}

class _verfiyState extends State<verfiy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Icon(CupertinoIcons.mail, size: 50, color: primaryColor),
        SizedBox(
          height: 30,
        ),
        Text('Verify your email')
      ],
    ));
  }
}
