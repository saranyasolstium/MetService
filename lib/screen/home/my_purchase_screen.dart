import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/home/mypurchase_detail_screen.dart';

class MyPurchaseScreen extends StatefulWidget {
  static String id = '/schedule_screen';

  @override
  _MyPurchaseScreenState createState() => _MyPurchaseScreenState();
}

class _MyPurchaseScreenState extends State<MyPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colour.appLightGrey,
        appBar: AppBar(
          toolbarHeight: 66.dynamic,
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          leading: RawMaterialButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Nav(),
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            'My Purchases',
            style: TextStyle(
                color: Colour.appBlack,
                fontWeight: FontWeight.w400,
                fontSize: 16.dynamic),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.dynamic,
                  vertical: 13.dynamic,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 23.dynamic,
                      color: Colour.appBlue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                color: Colour.appDarkGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.dynamic),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            '3rd March, 2021',
                            style: TextStyle(
                                color: Colour.appBlack,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.dynamic),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Change',
                      style: TextStyle(
                          color: Colour.appBlue,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.dynamic),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17.dynamic,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 16.dynamic,
                  left: 16.dynamic,
                  bottom: 13.dynamic,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/camera.png',
                        ),
                        SizedBox(
                          width: 13.dynamic,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hitech Security Camera',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                'ID - CCTVCAM5698533',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.dynamic,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Purchase Date:',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                '12th May, 2020',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dynamic),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                'PO6589OLK68',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dynamic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.dynamic,
                    ),
                    GestureDetector(
                      onTap: () {
                        //   showModalBottomSheet(
                        //     context: context,
                        //     isScrollControlled: true,
                        //     builder: (context) => SingleChildScrollView(
                        //       child: Container(
                        //
                        //           // child: HomeScreen(),
                        //           ),
                        //     ),
                        //   );
                      },
                      child: Text(
                        'See Details',
                        style: TextStyle(
                            color: Colour.appBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.dynamic),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 17.dynamic,
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 16.dynamic,
                  left: 16.dynamic,
                  bottom: 13.dynamic,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/camera.png',
                        ),
                        SizedBox(
                          width: 13.dynamic,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hitech Security Camera',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                'ID - CCTVCAM5698533',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.dynamic,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Purchase Date:',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                '12th May, 2020',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dynamic),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Order ID',
                                style: TextStyle(
                                    color: Colour.appDarkGrey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.dynamic),
                              ),
                              SizedBox(
                                height: 4.dynamic,
                              ),
                              Text(
                                'PO6589OLK68',
                                style: TextStyle(
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.dynamic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.dynamic,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: MyPurchaseDetailsScreen(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'See Details',
                        style: TextStyle(
                            color: Colour.appBlue,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.dynamic),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
