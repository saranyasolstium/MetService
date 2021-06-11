import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class MyPurchaseDetailsScreen extends StatelessWidget {
  final AProduct product;
  MyPurchaseDetailsScreen(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
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
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colour.appLightGrey,
                      radius: 23.dynamic,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 23.dynamic,
                          color: Colour.appBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13.dynamic,
                  ),
                  Text(
                    'Job Details',
                    style: TextStyle(
                        color: Colour.appBlue,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.dynamic),
                  ),
                  SizedBox(
                    height: 21.dynamic,
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Points Gained:',
                              style: TextStyle(
                                  color: Colour.appDarkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.dynamic),
                            ),
                            SizedBox(
                              height: 4.dynamic,
                            ),
                            Text(
                              '150',
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
                              'Warranty Status',
                              style: TextStyle(
                                  color: Colour.appDarkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.dynamic),
                            ),
                            SizedBox(
                              height: 4.dynamic,
                            ),
                            Row(
                              children: [
                                Image.asset('images/warranty.png'),
                                SizedBox(
                                  width: 4.dynamic,
                                ),
                                Text(
                                  'Under Warranty',
                                  style: TextStyle(
                                      color: Colour.appBlack,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.dynamic),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.dynamic,
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
                              'Warranty Ending On',
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
                              'Warranty Card',
                              style: TextStyle(
                                  color: Colour.appDarkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.dynamic),
                            ),
                            SizedBox(
                              height: 4.dynamic,
                            ),
                            Text(
                              'PO6589.pdf',
                              style: TextStyle(
                                  color: Colour.appBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.dynamic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
