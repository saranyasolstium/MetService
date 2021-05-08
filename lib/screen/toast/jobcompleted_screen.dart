import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobCompletedScreen extends StatelessWidget {
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
                        text: 'You have Completed',
                        style: TextStyle(
                          fontSize: 14.dynamic,
                          fontWeight: FontWeight.normal,
                          color: Colour.appBlack,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' 81 ',
                            style: TextStyle(
                              fontSize: 20.dynamic,
                              fontWeight: FontWeight.w600,
                              color: Colour.appBlue,
                            ),
                          ),
                          TextSpan(
                            text: 'Job',
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
                        onPressed: () {},
                        child: Text(
                          'Back to Home',
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
