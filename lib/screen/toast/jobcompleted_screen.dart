import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/clockin_model.dart';
import 'package:eagle_pixels/model/schedule_job_detail_model.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';

extension JobCompletedAction on JobCompletedScreen {
//   onComplete() async {
//     try {
//       Position position = await AppController.to.determinePosition();
//       var body = {
//         'SiteID': detail.siteId,
//         'latitude': '${position.latitude}',
//         'longitude': '${position.longitude}',
//         'serviceID': detail.aServiceId
//       };

//       var response = await API.service.call(
//         model: MClockInResponse(),
//         endPoint: EndPoint.clockOut,
//         body: body,
//       );
//       if (response.isSuccess) {
//         navigator!.popUntil((route) => route.settings.name == NavPage.root);
//       } else {
//         Toast.show(
//           response.message ?? 'Failed to clock out',
//           backgroundColor: Colors.white,
//           textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
//         );
//         return;
//       }
//     } catch (e) {
//       Toast.show(
//         e.toString(),
//         backgroundColor: Colors.white,
//         textStyle: TextStyle(fontSize: 16.0, color: Colors.black),
//       );
//       return;
//     }
//   }
}

class JobCompletedScreen extends StatelessWidget {
  final JobDetailController detailController = Get.find();
  MJobDetail get detail {
    return detailController.detail.value as MJobDetail;
  }

  static Widget space() {
    return SizedBox(height: 10.dynamic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'images/jobcompleted_background.png',
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                // color: Colors.white,
                width: Get.width - 30.dynamic,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/note.png',
                    ),
                    space(),
                    Text(
                      'Hurray!',
                      style: TextStyle(
                        fontSize: 20.dynamic,
                        fontWeight: FontWeight.w500,
                        color: Colour.appBlue,
                      ),
                    ),
                    space(),
                    Text(
                      'You have reached another Milestone',
                      style: TextStyle(
                        fontSize: 14.dynamic,
                        fontWeight: FontWeight.normal,
                        color: HexColor.fromHex("9A9A9A"),
                      ),
                    ),
                    space(),
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: TextStyle(
                          fontSize: 14.dynamic,
                          fontWeight: FontWeight.normal,
                          color: Colour.appBlack,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' ${detailController.completedMessage} ',
                            style: TextStyle(
                              fontSize: 20.dynamic,
                              fontWeight: FontWeight.w600,
                              color: Colour.appBlue,
                            ),
                          ),
                          TextSpan(
                            text: '',
                            style: TextStyle(
                              fontSize: 14.dynamic,
                              fontWeight: FontWeight.normal,
                              color: Colour.appBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.dynamic),
                    Container(
                      decoration: BoxDecoration(
                        color: Colour.appBlue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.dynamic),
                        ),
                      ),
                      width: Get.width * 0.7,
                      child: TextButton(
                        onPressed: () {
                          // onComplete();
                          // navigator!.popUntil(
                          //     (route) => route.settings.name == NavPage.root);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Nav()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Close attendance',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.dynamic,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Align(child: Image.asset('images/poweredby.png'))],
            )
          ],
        ),
      ),
    );
  }
}
