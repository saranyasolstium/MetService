import 'package:eagle_pixels/colors.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

extension FeebackWidgets on FeedbackScreen {
  AppBar get appBar {
    return AppBar(
      title: Text(
        'Feedback',
        style: TextStyle(fontSize: 16.dynamic, fontWeight: FontWeight.normal),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  // const FeedbackScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      backgroundColor: HexColor.fromHex('F7F7F7'),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.dynamic),
            color: Colors.white,
          ),
          margin: EdgeInsets.symmetric(
              vertical: 24.dynamic, horizontal: 17.dynamic),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 16.dynamic),
                Container(
                  width: 129.dynamic,
                  height: 147.dynamic,
                  child: Image.asset(
                    'images/person_like.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.dynamic),
                    color: HexColor.fromHex('EAF4FD'),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 15.dynamic),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.dynamic),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.fromLTRB(
                            24.dynamic, 24.dynamic, 24.dynamic, 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.dynamic),
                              height: 3,
                              width: 45.dynamic,
                              color: HexColor.fromHex('28ABE3'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.dynamic),
                              child: Text(
                                'Feedback',
                                style: TextStyle(
                                    fontSize: 12.dynamic,
                                    fontWeight: FontWeight.w500,
                                    color: Colour.appText),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.dynamic),
                              child: Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown',
                                style: TextStyle(
                                    fontSize: 12.dynamic,
                                    fontWeight: FontWeight.w200,
                                    color: Colour.appText),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.dynamic),
                        child: Text(
                          'Your Rating',
                          style: TextStyle(
                            color: Colour.appBlue,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.dynamic,
                          ),
                        ),
                      ),
                      RatingBar.builder(
                        itemSize: 23.dynamic,
                        unratedColor: HexColor.fromHex('B1D7DD'),
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      SizedBox(height: 16.dynamic),
                    ],
                  ),
                ),
                SizedBox(height: 35.dynamic),
                Column(
                  children: [
                    Image.asset('images/user.png'),
                    Text('Checked By'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
