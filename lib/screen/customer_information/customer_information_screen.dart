import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/customer_information_controller.dart';
import 'package:eagle_pixels/reuse/network_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:toast/toast.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class CustomerInformationScreen extends StatefulWidget {
  @override
  _CustomerInformationScreenState createState() =>
      _CustomerInformationScreenState();
}

class _CustomerInformationScreenState extends State<CustomerInformationScreen> {
  final customer = Get.put(CustomerInformationController());

  String? _selectedRegion;
  String? _selectedSecond;

  Widget get contentView {
    if (customer.viewState.isSuccess) {
      return ListView.builder(
        itemBuilder: (con, index) {
          var item = customer.filteredProductList[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60.dynamic,
                        width: 60.dynamic,
                        child: SvgPicture.network(
                          'https://met.solstium.net/admin/images/user-profile.svg',
                          placeholderBuilder: (BuildContext context) =>
                              Image.network(kCameraPlaceholder),
                        ),

                        // child: NetworkImageView(
                        //     item.aCustomerImage, kCameraPlaceholder)
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
                              'Product Name',
                              style: TextStyle(
                                  color: Colour.appDarkGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.dynamic),
                            ),
                            SizedBox(
                              height: 4.dynamic,
                            ),
                            Text(
                              '${item.aName}',
                              style: TextStyle(
                                  color: Colour.appBlack,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.dynamic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.dynamic,
                  ),
                  JobDetailTitleDescriptionView(
                      'Serial Number', item.aSerialNumber),
                  SizedBox(
                    height: 15.dynamic,
                  ),
                  JobDetailTitleDescriptionView(
                      'Warranty Date', item.warrantyEnding),
                  SizedBox(
                    height: 15.dynamic,
                  ),
                  JobDetailTitleDescriptionView('Location', item.aLocation),
                  SizedBox(
                    height: 15.dynamic,
                  ),
                  JobDetailTitleDescriptionView(
                      'Sub Location', item.aSubLocation),
                  SizedBox(
                    height: 15.dynamic,
                  ),
                //   Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Floor Plan',
                //         style: TextStyle(
                //             color: Colour.appDarkGrey,
                //             fontWeight: FontWeight.w400,
                //             fontSize: 12.dynamic),
                //       ),
                //       SizedBox(
                //         height: 4.dynamic,
                //       ),
                //       GestureDetector(
                //         onTap: () async {
                //           final floorText = item.aFloorPlan;
                //           if (floorText != null && floorText.length > 3) {
                //             final isPDF =
                //                 floorText.substring(floorText.length - 3) ==
                //                     'pdf';
                //             if (isPDF) {
                //               Get.bottomSheet(
                //                 Center(
                //                   child: Container(
                //                     child: PDFViewer(
                //                       document:
                //                           await PDFDocument.fromURL(floorText),
                //                     ),
                //                   ),
                //                 ),
                //                 isScrollControlled: true,
                //                 ignoreSafeArea: false,
                //               );
                //             } else {
                //               Get.bottomSheet(
                //                 Center(
                //                   child: PhotoView(
                //                     imageProvider: NetworkImage(floorText),
                //                   ),
                //                 ),
                //                 isScrollControlled: true,
                //                 ignoreSafeArea: false,
                //               );
                //             }
                //           } else {
                //             Toast.show('Invalid Floor Plan',
                //                 textStyle: Get.context);
                //           }
                //         },
                //         child: Text(
                //           '${item.aFloorPlan == '' ? 'Empty' : item.aFloorPlanName}',
                //           style: TextStyle(
                //               color: Colour.appBlue,
                //               fontWeight: FontWeight.w600,
                //               fontSize: 14.dynamic),
                //         ),
                //       ),
                //     ],
                //   ),
                 ],
              ),
            ),
          );
        },
        itemCount: customer.filteredProductList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      );
    } else if (customer.viewState.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (customer.viewState.isFailed) {
      return Center(
        child: Text('Failed'),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Colour.appLightGrey,
          appBar: AppBar(
            title: titleText(
              'Customer Information',
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
          ),
          body: Obx(() {
            return Container(
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Form(
                                  // key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Choose Customer DropDown
                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.dynamic),
                                          ),
                                        ),
                                        child: DropdownSearch<String>(
                                          showAsSuffixIcons: true,
                                          // validator: (item) {
                                          //   if (item == null)
                                          //     return '* Required';
                                          //   else
                                          //     return null;
                                          // },
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          mode: Mode.MENU,
                                          // showSelectedItem: true,
                                          items: customer
                                              .arrString(customer.customerList),
                                          // label: "Menu mode",
                                          hint: "Select Customer",
                                          onChanged: (val) async {
                                            customer.selectedCustomer.value =
                                                customer.find(val!,
                                                    customer.customerList);

                                            customer.selectedLocation.value =
                                                null;
                                            customer.locationList.value = [];

                                            await customer
                                                .fetchCustomerStoreList();
                                            customer.selectedProduct.value =
                                                null;
                                            await customer
                                                .fetchCustomerProductList(true);
                                            await customer
                                                .fetchCustomerProductList(
                                                    false);
                                          },

                                          // selectedItem: createJob.valueOfDrop.value,
                                        ),
                                      ),
                                      // Select Product DropDown
                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.dynamic),
                                          ),
                                        ),
                                        child: DropdownSearch<String>(
                                          showAsSuffixIcons: true,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          mode: Mode.MENU,
                                          // showSelectedItem: true,
                                          items: customer
                                              .arrString(customer.locationList),
                                          selectedItem: customer
                                                  .selectedLocation
                                                  .value
                                                  ?.aName ??
                                              'Select Location',
                                          // label: "Menu mode",
                                          hint: "Select Location",

                                          onChanged: (val) async {
                                            customer.selectedLocation.value =
                                                customer.find(val!,
                                                    customer.locationList);
                                            customer.selectedProduct.value =
                                                null;
                                            await customer
                                                .fetchCustomerProductList(true);
                                            await customer
                                                .fetchCustomerProductList(
                                                    false);
                                          },
                                          // validator: (item) {
                                          //   if (item == null)
                                          //     return '* Required';
                                          //   else
                                          //     return null;
                                          // },
                                          // selectedItem: "Brazil",
                                        ),
                                      ),
                                      // Choose Service Type DropDown
                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 15),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.dynamic),
                                          ),
                                        ),
                                        child: DropdownSearch<String>(
                                          showAsSuffixIcons: true,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          mode: Mode.MENU,
                                          // showSelectedItem: true,
                                          items: customer
                                              .arrString(customer.productList),
                                          // label: "Menu mode",
                                          hint: 'Select Product',
                                          onChanged: (val) async {
                                            customer.selectedProduct.value =
                                                customer.find(
                                                    val!, customer.productList);
                                            await customer
                                                .fetchCustomerProductList(
                                                    false);
                                          },
                                          // validator: (item) {
                                          //   if (item == null)
                                          //     return '* Required';
                                          //   else
                                          //     return null;
                                          // },
                                          selectedItem: customer.selectedProduct
                                                  .value?.aName ??
                                              'Select Product',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                this.contentView,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppController.to.defaultLoaderView()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomerProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class JobDetailTitleDescriptionView extends StatelessWidget {
  final String title;
  final String? description;
  JobDetailTitleDescriptionView(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colour.appDarkGrey,
              fontWeight: FontWeight.normal,
              fontSize: 12.dynamic),
        ),
        SizedBox(
          height: 4.dynamic,
        ),
        Text(
          description ?? 'NA',
          style: TextStyle(
              color: Colour.appBlack,
              fontWeight: FontWeight.w400,
              fontSize: 14.dynamic),
        ),
      ],
    );
  }
}
