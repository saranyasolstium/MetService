import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatelessWidget {
  bool get isEngineer => AppController.to.isEngineer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          
          child: Column(
            children: [
              SizedBox(
                height: 18.dynamic,
              ),
              Text(
                "My Profile",
                style: TextStyle(
                  color: Colour.appBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.dynamic,
                ),
              ),
              this.profileView,
              this.qrScannerView,
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Colour.appLightGrey,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 22.6.dynamic,
                          left: 17.dynamic,
                          right: 16.dynamic),
                      child: SingleChildScrollView(
                        child: Container(
                          color: Colour.appLightGrey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (!isEngineer)
                                Column(
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
                                                Icons
                                                    .arrow_forward_ios_outlined,
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
                                        Get.toNamed(NavPage.myReward);
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
                                  ],
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
                                                SharedPreferencesHelper.clearToken();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension MyProfileScreenWidgets on MyProfileScreen {
  Widget get profileView {
    return Padding(
      padding:
          EdgeInsets.only(top: 21.dynamic, left: 16.dynamic, right: 16.dynamic),
      child: Row(
        children: [
          Container(
            width: 75.dynamic,
            height: 75.dynamic,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                ),
                borderRadius: BorderRadius.circular(37.5.dynamic)),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                        AppController.user.employeeDetails?.profileImage ?? "",
                    placeholder: (_, url) => Image.asset('images/user.png'),
                    errorWidget: (_, __, ___) => Image.asset('images/user.png'),
                  ),
                ),
                Container(
                  width: 37.5.dynamic,
                  height: 37.5.dynamic,
                  margin: EdgeInsets.only(left: 40.dynamic, top: 40.dynamic),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(37.5.dynamic),
                  ),
                  child: Image.asset('images/platinum_crown.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ${AppController.user.name}',
                  style: TextStyle(
                      color: Colour.appText,
                      fontSize: 16.dynamic,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget builProfileRow(String title, String description, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colour.appBlack,
            fontWeight: FontWeight.w400,
            fontSize: 14.dynamic,
          ),
        ),
        SizedBox(
          width: 8.dynamic,
        ),
        Text(
          description,
          style: TextStyle(
            color: color ?? Colour.appBlack,
            fontWeight: FontWeight.w600,
            fontSize: 14.dynamic,
          ),
        ),
      ],
    );
  }

  Widget get qrScannerView {
    String mobileNumber = AppController.user.employeeDetails?.mobileNumber.toString() ?? "NA";
String countryCode = AppController.user.employeeDetails?.countryCode?.toString() ?? "";
String formattedNumber = (mobileNumber != "NA") ? "$countryCode $mobileNumber" : "NA";

    return Container(
      // constraints: BoxConstraints(
      //   minHeight: 339.dynamic,
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
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
                      builProfileRow(
                          "Employee Code : ",
                          AppController.user.employeeDetails!.employeeCode
                              .toString(),
                          color: Colour.appGreen),
                      SizedBox(
                        height: 14.dynamic,
                      ),
                      builProfileRow(
                          "Email : ", AppController.user.email.toString(),
                          color: Colour.appBlue),
                      SizedBox(
                        height: 14.dynamic,
                      ),
                      builProfileRow(
                          "Designation : ",
                          AppController.user.employeeDetails!.designation
                              .toString(),
                          color: Colour.appBlack),
                      SizedBox(
                        height: 14.dynamic,
                      ),
                      builProfileRow(
                          "Mobile No : ",
                          formattedNumber,
                          color: Colour.appBlack),
                      SizedBox(
                        height: 14.dynamic,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 22.dynamic,
          ),
        ],
      ),
    );
  }
}

class ListOptions extends StatelessWidget {
  final String? listName;
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
