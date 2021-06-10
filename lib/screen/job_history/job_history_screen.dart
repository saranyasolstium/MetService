import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_history_controller.dart';
// import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/screen/views/ChangeDateView.dart';
import 'package:eagle_pixels/screen/views/service_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';

import '../../colors.dart';
import '../../constant.dart';

class JobHistoryScreen extends StatelessWidget {
  // const JobHistoryScreen({Key key}) : super(key: key);
  final JobHistoryController history = Get.put(JobHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colour.appLightGrey,
      appBar: this.appBar,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ChangeDateView(
                  date: history.selectedDate,
                  didEnd: () {
                    print('change date called');
                    history.viewState.value = ViewState.loading;
                    history.fetchProducts();
                  },
                ),
                SizedBox(
                  height: 17.dynamic,
                ),
                Expanded(
                  child: Obx(() {
                    if (history.viewState.value.isSuccess) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var item = history.jobList[index];
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
                        itemCount: history.jobList.length,
                      );
                    } else if (history.viewState.value.isFailed) {
                      return Center(
                        child: Text(
                          'No job history on this day',
                          style: TextStyle(fontSize: 15.dynamic),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
              ],
            ),
          ),
          AppController.to.defaultLoaderView(),
        ],
      ),
    );
  }
}

extension JobHistoryWidgets on JobHistoryScreen {
  AppBar get appBar {
    return AppBar(
      title: titleText(
        'Job History',
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: RawMaterialButton(
        onPressed: () => Get.back(),
        child: Icon(
          Icons.arrow_back,
          color: Colour.appBlue,
        ),
      ),
    );
  }
}

// class JobHistoryItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Container(
//         width: double.infinity,
//         height: 100,
//         color: Colors.red,
//       ),
//     );
//   }
// }
