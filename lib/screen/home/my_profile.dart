import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr/qr.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/colors.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colour.appLightGrey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 339.dynamic,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 21.dynamic, left: 16.dynamic, right: 16.dynamic),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 75.0,
                                height: 75.0,
                                decoration: BoxDecoration(
                                  color: Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'http://i.imgur.com/QSev0hg.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(37.5),
                                  ),
                                  border: Border.all(
                                    color: Colour.appBlue,
                                    width: 5.0,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 28.0,
                                    height: 28.0,
                                    alignment: Alignment.bottomRight,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/bronze_crown.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '   Sounak Sikdar',
                                  style: TextStyle(
                                      color: Colour.appText,
                                      fontSize: 16.dynamic,
                                      fontWeight: FontWeight.w400),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '   Edit Profile  ',
                                      style: TextStyle(
                                          color: Colour.appBlue,
                                          fontSize: 16.dynamic,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colour.appBlue,
                                      size: 14.dynamic,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: PrettyQr(
                                      typeNumber: 3,
                                      size: 162.95.dynamic,
                                      data: 'https://www.google.ru',
                                      errorCorrectLevel: QrErrorCorrectLevel.M,
                                      roundEdges: true),
                                ),
                                SizedBox(
                                  height: 14.6.dynamic,
                                ),
                                Text(
                                  '    Scan QR Code ',
                                  style: TextStyle(
                                      color: Colour.appBlue,
                                      fontSize: 16.dynamic,
                                      fontWeight: FontWeight.w400),
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
                      top: 22.6.dynamic, left: 17.dynamic, right: 16.dynamic),
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colour.appLightGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Bronze',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '350 Points  ',
                                      style: TextStyle(
                                        color: Colour.appDarkGrey,
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
                          ListOptions(
                            listName: 'Rewards',
                          ),
                          SizedBox(
                            height: 18.dynamic,
                          ),
                          ListOptions(
                            listName: 'View Points History',
                          ),
                          SizedBox(
                            height: 18.dynamic,
                          ),
                          ListOptions(
                            listName: 'My Purchases',
                          ),
                          SizedBox(
                            height: 18.dynamic,
                          ),
                          ListOptions(
                            listName: 'Settings',
                          ),
                          SizedBox(
                            height: 18.dynamic,
                          ),
                          ListOptions(
                            listName: 'Help Centre',
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
    );
  }
}

class ListOptions extends StatelessWidget {
  final String listName;
  ListOptions({this.listName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$listName',
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
    );
  }
}

// Container(
// height: 74.dynamic,
// width: 72.dynamic,
// child: CircleAvatar(
// backgroundImage:
// AssetImage('images/user.png'),
// radius: 26.dynamic,
// child: Align(
// alignment: Alignment.bottomRight,
// child: CircleAvatar(
// backgroundColor: Colors.white,
// child: Image(
// width: 28.dynamic,
// height: 28.dynamic,
// image: AssetImage(
// 'images/bronze_crown.png'),
// ),
// ),
// ),
// ),
// decoration: BoxDecoration(
// border:
// Border.all(color: Colors.white, width: 5),
// borderRadius:
// BorderRadius.circular(40.dynamic),
// ),
// ),
