import 'package:eagle_pixels/screen/views/ChangeDateView.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/home/mypurchase_detail_screen.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/my_purchase_controller.dart';
import '../../constant.dart';
import '../../controller/app_controller.dart';
import '../views/service_view.dart';

class MyPurchaseScreen extends StatelessWidget {
  Widget get _contentView {
    if (purchase.viewState.value.isSuccess) {
      return ListView.builder(
        itemBuilder: (context, index) {
          var item = purchase.jobList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ServiceView(
                isNeedDetail: true,
                item: item,
                isNeedStartJob: false,
                onJob: () {},
                onSeeDetail: () {}),
          );
        },
        itemCount: purchase.jobList.length,
      );
    } else if (purchase.viewState.value.isFailed) {
      return Center(
        child: Text(
          'No Purchases on this day',
          style: TextStyle(fontSize: 15.dynamic),
        ),
      );
    } else {
      return Container();
    }
  }

  final MyPurchaseController purchase = Get.find();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colour.appLightGrey,
        appBar: AppBar(
          toolbarHeight: 66.dynamic,
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          // leading: RawMaterialButton(
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Nav(),
          //     ),
          //   ),
          //   child: Icon(
          //     Icons.arrow_back,
          //     color: Colour.appBlue,
          //   ),
          // ),
          title: titleText(
            'My Purchases',
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChangeDateView(
                  date: purchase.selectedDate,
                  didEnd: () {
                    purchase.viewState.value = ViewState.loading;
                    purchase.fetchProducts();
                  },
                ),
                SizedBox(
                  height: 17.dynamic,
                ),
                Obx(() {
                  return Stack(children: [
                    _contentView,
                  ]);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
