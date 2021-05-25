import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';

import '../../colors.dart';
import 'package:eagle_pixels/colors.dart';

// extension ConfiramtionAction on ConfirmationScreen {
//   onYes() {
//     // Get.back();
//     print('yes called');
//     navigator!.pop();
//   }
//
//   onNo() {
//     Get.back();
//     // Navigator.of(Get.overlayContext).pop();
//   }
// }

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Container(
          //   color: Colors.black.withOpacity(0.52),
          // ),
          Center(
            child: Container(
              padding: EdgeInsets.all(30.dynamic),
              width: Get.width - 45,
              constraints: BoxConstraints(
                minHeight: Get.width - 45,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure that you are\ndone for the day?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colour.appBlack,
                      fontSize: 16.dynamic,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 25.dynamic),
                  Image.asset(
                    'images/think.png',
                    // width: 100,
                    // height: 100,
                  ),
                  SizedBox(height: 25.dynamic),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: HexColor.fromHex('28ABE3'),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'YES',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.dynamic,
                                color: HexColor.fromHex('28ABE3'),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            padding: EdgeInsets.all(10.dynamic),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.dynamic,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: HexColor.fromHex('DB1A1A'),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'NO',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.dynamic,
                                color: HexColor.fromHex('DB1A1A'),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            padding: EdgeInsets.all(10.dynamic),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
