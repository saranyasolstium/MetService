import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:bordered_text/bordered_text.dart';

class MyRewardScreen extends StatefulWidget {
  @override
  _MyRewardScreenState createState() => _MyRewardScreenState();
}

class _MyRewardScreenState extends State<MyRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 285.dynamic,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/silver.png'),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 21.dynamic,
                            left: 16.dynamic,
                            right: 16.dynamic),
                        child: Row(
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 26.dynamic,
                                child: Icon(
                                  Icons.person,
                                  size: 20.dynamic,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colour.appBlue,
                                ),
                                borderRadius: BorderRadius.circular(30.dynamic),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '   Hi',
                                    style: TextStyle(
                                        color: Colour.appText,
                                        fontSize: 20.dynamic,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '    Sounak',
                                        style: TextStyle(
                                            color: Colour.appText,
                                            fontSize: 16.dynamic,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colour.appBlue,
                                        size: 20.dynamic,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 27.dynamic,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.dynamic,
                          right: 16.dynamic,
                        ),
                        child: Container(
                          height: 170.dynamic,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('images/myreward_silver.png'),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 19.5.dynamic, left: 24.5.dynamic),
                                    child: BorderedText(
                                      strokeWidth: 2,
                                      strokeColor: Colors.white,
                                      child: Text(
                                        'SILVER',
                                        style: TextStyle(
                                            // color: Color(0xFF97735D),
                                            // color: Color(0x70707070),
                                            color: Colors.transparent,
                                            fontSize: 29.dynamic,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 6.0.dynamic),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 9.5.dynamic, left: 24.5.dynamic),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5.dynamic,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Voila, you will need 150 more points to be a Gold Member ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.dynamic,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Image.asset(
                                          'images/silver_crown.png',
                                          width: 83.46.dynamic,
                                          height: 50.46.dynamic,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10.dynamic, left: 24.5.dynamic),
                                    child: GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 13.dynamic,
                                        ),
                                        width: 140.dynamic,
                                        height: 40.dynamic,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          // color: Color(0xFF45210A),
                                          color: Color(0x70323232),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'View Benifits',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.dynamic,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              color: Colors.white,
                                              size: 13.dynamic,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 19.dynamic, left: 17.dynamic, right: 16.dynamic),
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colour.appLightGrey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'You have ',
                              style: TextStyle(
                                  color: Colour.appDarkGrey,
                                  fontSize: 14.dynamic,
                                  fontWeight: FontWeight.w400),
                            ),
                            Row(
                              children: [
                                Text(
                                  '350 ',
                                  style: TextStyle(
                                      color: Colour.appBlack,
                                      fontSize: 20.dynamic,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 6.dynamic,
                                ),
                                Text(
                                  'Total Reward Points',
                                  style: TextStyle(
                                      color: Colour.appBlack,
                                      fontSize: 16.dynamic,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.dynamic,
                            ),
                            Container(
                              height: 116.dynamic,
                              padding: EdgeInsets.only(
                                  top: 11.dynamic,
                                  left: 14.dynamic,
                                  right: 21.dynamic),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFDBDBDB)),
                                borderRadius: BorderRadius.circular(7.0),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your bonus points will expire on 31.12.2021',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 6.dynamic,
                                  ),
                                  Text(
                                    'Use your bonus points while purchase to get discount on total price.',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 6.dynamic,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      'Learn More',
                                      style: TextStyle(
                                          color: Colour.appBlue,
                                          fontSize: 16.dynamic,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.dynamic,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'View Benifits',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.grey,
                                        size: 13.dynamic,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.dynamic,
                                  ),
                                  Divider(
                                    color: Colour.appDarkGrey,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.dynamic,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'View Points History',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.grey,
                                        size: 13.dynamic,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.dynamic,
                                  ),
                                  Divider(
                                    color: Colour.appDarkGrey,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18.dynamic,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Know How to Earn More Points',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.grey,
                                        size: 13.dynamic,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.dynamic,
                                  ),
                                  Divider(
                                    color: Colour.appDarkGrey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
