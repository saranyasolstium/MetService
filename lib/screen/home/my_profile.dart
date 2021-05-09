import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/screen/home/my_reward_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child: SingleChildScrollView(
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
                            top: 21.dynamic,
                            left: 16.dynamic,
                            right: 16.dynamic),
                        child: Row(
                          children: [
                            Container(
                              width: 75.dynamic,
                              height: 75.dynamic,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: AssetImage('images/user.png'),
                                  ),
                                  border: Border.all(
                                    color: Colors.blue,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(37.5.dynamic)),
                              child: Container(
                                width: 37.5.dynamic,
                                height: 37.5.dynamic,
                                margin: EdgeInsets.only(
                                    left: 40.dynamic, top: 40.dynamic),
                                decoration: BoxDecoration(
                                    color: Colors.white,
// border: Border.all(
//   color: Colors.blue,
// ),
                                    borderRadius:
                                        BorderRadius.circular(37.5.dynamic)),
                                child: Image.asset('images/platinum_crown.png'),
// color: Colors.red,
                              ),
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
                                        errorCorrectLevel:
                                            QrErrorCorrectLevel.M,
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
                            RawMaterialButton(
                              onPressed: () {
                                Get.toNamed(NavPage.clockOut);
                              },
                              child: ListOptions(
                                listName: 'Rewards',
                              ),
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
                            SizedBox(
                              height: 18.dynamic,
                            ),
                            RawMaterialButton(
                              onPressed: () {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (_) {
                                      return CupertinoAlertDialog(
                                        title: Text('Confirmation'),
                                        content: Text(
                                            'Are you sure you want to logout?'),
                                        actions: [
                                          CupertinoButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                            },
                                          ),
                                          CupertinoButton(
                                            child: Text('Yes'),
                                            onPressed: () {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop(true);
                                              AppController.to.storage
                                                  .remove('token');
                                              AppController.to.loginStatus
                                                  .value = LoginStatus.logout;
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                // Get.defaultDialog(
                                //     title: 'Confirm',
                                //     content: Text(
                                //         'Are you sure you want to logout?'),
                                //     textConfirm: 'Confirm',
                                //     textCancel: 'Cancel',
                                //     onConfirm: () {
                                //       AppController.to.storage.remove('token');
                                //       AppController.to.loginStatus.value =
                                //           LoginStatus.logout;
                                //     });
                              },
                              child: ListOptions(
                                listName: 'Logout',
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
