// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eagle_pixels/constant.dart';
// import 'package:eagle_pixels/controller/job_checklist_controller.dart';
// import 'package:eagle_pixels/controller/timer_controller.dart';
// import 'package:eagle_pixels/model/abstract_class.dart';
// import 'package:eagle_pixels/screen/schedule/service_report_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:eagle_pixels/colors.dart';
// import 'package:eagle_pixels/dynamic_font.dart';
// import 'package:get/get.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:eagle_pixels/controller/job_detail_controller.dart';
//
// import '../../main.dart';
//
// class ScheduleJobDetailsScreen extends StatelessWidget {
//   final detailController = Get.put(JobDetailController());
//
//   final bool isNeedServiceReport;
//   final bool isNeedBottomView;
//
//   ScheduleJobDetailsScreen(
//       {this.isNeedBottomView = false, this.isNeedServiceReport = false});
//   AJobDetail get detail {
//     return detailController.detail.value;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(
//           () => Container(
//             color: Color(0xff757575),
//             child: Container(
//               // padding: EdgeInsets.only(top: 30.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 13.dynamic,
//                   ),
//                   Center(
//                     child: this.cancelButton,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.only(
//                           left: 30.dynamic,
//                           bottom: 21.dynamic,
//                         ),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           color: Colors.white,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 13.dynamic,
//                             ),
//                             Text(
//                               'Job Details',
//                               style: TextStyle(
//                                   color: Colour.appBlue,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16.dynamic),
//                             ),
//                             SizedBox(
//                               height: 21.dynamic,
//                             ),
//                             this.cameraInfoView,
//                             this.detailsView,
//                             isNeedServiceReport
//                                 ? Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: 10.dynamic,
//                                         ),
//                                         Divider(
//                                           color: Colors.grey,
//                                         ),
//                                         SizedBox(
//                                           height: 10.dynamic,
//                                         ),
//                                         Text(
//                                           'Service Report',
//                                           style: TextStyle(
//                                               color: Colour.appBlue,
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 16.dynamic),
//                                         ),
//                                         this.serviceReportView
//                                       ],
//                                     ),
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   isNeedBottomView ? this.bottomView : Container(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// extension JobDetailWidgets on ScheduleJobDetailsScreen {
//   Widget get cancelButton {
//     return CircleAvatar(
//       backgroundColor: Colour.appLightGrey,
//       radius: 23.dynamic,
//       child: IconButton(
//         onPressed: () {
//           Get.back();
//         },
//         icon: Icon(
//           Icons.close,
//           size: 23.dynamic,
//           color: Colour.appBlue,
//         ),
//       ),
//     );
//   }
//
//   Widget androidDropdown() {
//     List<DropdownMenuItem<String>> dropdownItems = [];
//     var siteList = detailController.arrSites;
//     siteList.forEach((site) {
//       dropdownItems.add(
//         DropdownMenuItem(
//           child: Text(site.displayText),
//           value: site.displayText,
//         ),
//       );
//     });
//
//     // for (String site in siteList.value) {
//     //   var newItem = DropdownMenuItem(
//     //     child: Text(site.),
//     //     value: site,
//     //   );
//     //   dropdownItems.add(newItem);
//     // }
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 19.dynamic),
//       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colour.appLightGrey,
//         borderRadius: BorderRadius.all(
//           Radius.circular(5.dynamic),
//         ),
//       ),
//       child: DropdownButton<String>(
//         value: detailController.selectedSite.value?.displayText ?? '',
//         items: dropdownItems,
//         underline: Container(),
//         icon: Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Icon(
//                 Icons.keyboard_arrow_down,
//                 size: 30.dynamic,
//                 color: Colour.appDarkGrey,
//               ),
//             ],
//           ),
//         ),
//         onChanged: (value) {
//           detailController.selectedSite.value = detailController.arrSites
//               .where((element) => element.displayText == value)
//               .first;
//         },
//       ),
//     );
//   }
//
//   Widget get cameraInfoView {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Image.asset(
//           'images/camera.png',
//         ),
//         SizedBox(
//           width: 13.dynamic,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Hitech Security Camera',
//                 style: TextStyle(
//                     color: Colour.appBlack,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 16.dynamic),
//               ),
//               SizedBox(
//                 height: 4.dynamic,
//               ),
//               Text(
//                 'ID - CCTVCAM5698533',
//                 style: TextStyle(
//                     color: Colour.appDarkGrey,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12.dynamic),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget get detailsView {
//     return Column(
//       children: [
//         SizedBox(
//           height: 20.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             JobDetailTitleDescriptionView(
//                 'Purchase Date:', detail.aPurchaseDate),
//             JobDetailTitleDescriptionView(
//                 'Purchase Order Number:', detail.aPurchaseOrderNumber),
//           ],
//         ),
//         SizedBox(
//           height: 15.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             JobDetailTitleDescriptionView(
//                 'Scheduled Date:', detail.aScheduleDate),
//             JobDetailTitleDescriptionImageView('Customer Name:',
//                 detail.aCustomerName, detail.aCameraImage ?? '')
//           ],
//         ),
//         SizedBox(
//           height: 15.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             JobDetailTitleDescriptionView(
//                 'Scheduled Time:', detail.aScheduleTime),
//             JobDetailTitleDescriptionImageView(
//                 'Scheduled By:', detail.aScheduledBy, detail.aScheduledBy)
//           ],
//         ),
//         SizedBox(
//           height: 15.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             JobDetailTitleDescriptionView(
//                 'Warranty Status', detail.aWarrantyStatus),
//             JobDetailTitleDescriptionView(
//                 'Warranty Ending On', detail.aWarrantyEndingOn),
//           ],
//         ),
//         SizedBox(
//           height: 15.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Instructions from Customer',
//                     style: TextStyle(
//                         color: Colour.appDarkGrey,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12.dynamic),
//                   ),
//                   SizedBox(
//                     height: 4.dynamic,
//                   ),
//                   Text(
//                     detail.aCustomerInstruction ?? 'NA',
//                     style: TextStyle(
//                         color: Colour.appRed,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14.dynamic),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget get serviceReportView {
//     return Column(
//       children: [
//         SizedBox(
//           height: 20.dynamic,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             JobDetailTitleDescriptionView(
//                 'Job Start Time:', detail.aPurchaseDate),
//             JobDetailTitleDescriptionView(
//                 'Job  End Time:', detail.aPurchaseOrderNumber),
//           ],
//         ),
//         // GetBuilder<JobCheckListController>(
//         //   builder: (_) {
//         //     return ListView.builder(
//         //       shrinkWrap: true,
//         //       physics: NeverScrollableScrollPhysics(),
//         //       itemBuilder: (builder, index) {
//         //         var item = checkListController.selectedlist[index];
//         //         return ReportItem(
//         //           item: item,
//         //         );
//         //       },
//         //       itemCount: checkListController.selectedlist.length,
//         //     );
//         //   },
//         // ),
//       ],
//     );
//   }
//
//   Widget get bottomView {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(15.0),
//           topRight: Radius.circular(15.0),
//         ),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 10,
//             spreadRadius: 1,
//           )
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: 19.dynamic,
//           left: 17.dynamic,
//           right: 17.dynamic,
//           bottom: 10.dynamic,
//         ),
//         child: Column(
//           children: [
//             Obx(
//               () => Text(
//                 // var time = DateFormat('hh:mm a').format(DateTime.now());
//                 Jiffy(TimerController.to.currentDate.value)
//                     .format('hh:mm a  |  do MMMM yyyy'),
//                 // DateFormat('hh:mm a | MMst MMMM yyyy').format(DateTime.now()),
//                 // '09:10 AM  |  21st September 2021',
//                 style: TextStyle(
//                   fontSize: 14.dynamic,
//                   fontWeight: FontWeight.w600,
//                   color: HexColor.fromHex("333333"),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 19.dynamic,
//             ),
//             androidDropdown(),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colour.appBlue,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(5.dynamic),
//                 ),
//               ),
//               child: TextButton(
//                 onPressed: () {
//                   Get.toNamed(NavPage.jobCheckListScreen);
//                 },
//                 child: Text(
//                   'Save & Continue',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.dynamic,
//                       fontWeight: FontWeight.w300),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class JobDetailTitleDescriptionView extends StatelessWidget {
//   final String title;
//   final String? description;
//   JobDetailTitleDescriptionView(this.title, this.description);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 color: Colour.appDarkGrey,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12.dynamic),
//           ),
//           SizedBox(
//             height: 4.dynamic,
//           ),
//           Text(
//             safeString(description),
//             style: TextStyle(
//                 color: Colour.appBlack,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.dynamic),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class JobDetailTitleDescriptionImageView extends StatelessWidget {
//   final String title;
//   final String? description;
//   final String? image;
//   JobDetailTitleDescriptionImageView(this.title, this.description, this.image);
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//                 color: Colour.appDarkGrey,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12.dynamic),
//           ),
//           SizedBox(
//             height: 4.dynamic,
//           ),
//           Row(
//             children: [
//               Container(
//                 width: 24.dynamic,
//                 height: 24.dynamic,
//                 alignment: Alignment.center,
//                 child: CachedNetworkImage(
//                   fit: BoxFit.fill,
//                   imageUrl: image ?? "",
//                   placeholder: (_, url) => Image.asset(
//                     'images/user.png',
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   // image: DecorationImage(
//                   //   fit: BoxFit.contain,
//                   //   image:
//                   //   AssetImage('images/user.png'),
//                   // ),
//                   border: Border.all(
//                     color: Colors.blue,
//                   ),
//                   borderRadius: BorderRadius.circular(37.5.dynamic),
//                 ),
//               ),
//               SizedBox(
//                 width: 7.dynamic,
//               ),
//               Text(
//                 safeString(description),
//                 style: TextStyle(
//                     color: Colour.appBlack,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14.dynamic),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
