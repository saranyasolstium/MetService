import 'dart:core';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/signup_screen.dart';
import 'package:eagle_pixels/screen/home/my_reward_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'colors.dart';
import 'dynamic_font.dart';
import 'screen/home_screen.dart';
import 'screen/nav_bottom.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    double minimum = min(query.size.width, query.size.height);
    double defaultSize = 360;
    scale = minimum / defaultSize;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colour.appBlue,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins'),
      home: Nav(),
    );
  }
}
