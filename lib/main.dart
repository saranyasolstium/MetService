import 'dart:core';
import 'dart:math';

import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'colors.dart';
import 'dynamic_font.dart';
import 'screen/nav_bottom.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    double minimum = min(query.size.width, query.size.height);
    double defaultSize = 360;
    scale = minimum / defaultSize;
    return GetMaterialApp(
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
            name: '/',
            page: () {
              print('root loaded');
              return Obx(() {
                print('root loaded');
                return AppController.to.rootView();
              });
            }),
      ],
      initialBinding: AppBinding(),
      theme: ThemeData(
          primaryColor: Colour.appBlue,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins'),
      initialRoute: '/',
    );
  }
}
