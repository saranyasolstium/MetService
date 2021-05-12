import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/screen/schedule/schedule_job_details.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';

import '../../colors.dart';
import '../../constant.dart';

abstract class MService {
  String name;
}

class ServiceView extends StatelessWidget {
  ServiceView({
    @required this.item,
    @required this.buttonTitle,
    this.isNeedDetail = true,
    @required this.onJob,
    this.isNeedStatus = false,
    @required this.onSeeDetail,
  });
  final bool isNeedStatus;
  final bool isNeedDetail;
  final String buttonTitle;
  final Function onSeeDetail;
  final Function onJob;
  final ScheduleList item;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              CachedNetworkImage(
                imageUrl: item.customerImage,
                placeholder: (_, url) => Image.asset(
                  'images/camera.png',
                ),
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
                      safeString(item.productName),
                      style: TextStyle(
                          color: Colour.appBlack,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.dynamic),
                    ),
                    SizedBox(
                      height: 4.dynamic,
                    ),
                    Text(
                      'ID - ${safeString(item.ticketId)}',
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
                      'Customer Name:',
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
                        Container(
                          width: 24.dynamic,
                          height: 24.dynamic,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('images/user.png'),
                            ),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(37.5.dynamic),
                          ),
                        ),
                        SizedBox(
                          width: 7.dynamic,
                        ),
                        Text(
                          'Luis Philippe',
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
            children: [
              buttonTitle != null
                  ? ExpanderOrContainer(
                      isContainer: !isNeedDetail,
                      child: Container(
                        margin: EdgeInsets.only(right: 18.dynamic),
                        child: Material(
                          // elevation: 5.0,
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colour.appBlue,
                          child: MaterialButton(
                            minWidth: 121.dynamic,
                            height: 44.dynamic,
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            onPressed: onJob,
                            child: Text(
                              buttonTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.dynamic,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isNeedDetail
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: ScheduleJobDetailsScreen(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'View Details',
                          style: TextStyle(
                              color: Colour.appBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.dynamic),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpanderOrContainer extends StatelessWidget {
  ExpanderOrContainer({this.child, this.isContainer = true});
  final bool isContainer;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return isContainer ? Container(child: child) : Expanded(child: child);
  }
}
