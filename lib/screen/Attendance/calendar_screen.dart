import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  List _list = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: 100,
            color: Colors.blue,
          )),
    );
  }
}
