import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/customer_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:toast/toast.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class CustomerInformationScreen extends StatelessWidget {
  final customer = Get.put(CustomerInformationController());
  Widget get contentView {
    if (customer.viewState.isSuccess) {
      return ListView.builder(
        itemBuilder: (con, index) {
          var item;
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "",
                      placeholder: (_, url) => Image.asset(
                        'images/camera.png',
                      ),
                      width: 61.dynamic,
                      height: 61.dynamic,
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
                            safeString('Product Name'),
                            style: TextStyle(
                                color: Colour.appDarkGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.dynamic),
                          ),
                          SizedBox(
                            height: 4.dynamic,
                          ),
                          Text(
                            '${safeString('Hitech Security Camera')}',
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
                JobDetailTitleDescriptionView('Serial Number', 'CCTVCAM569853'),
                SizedBox(
                  height: 15.dynamic,
                ),
                JobDetailTitleDescriptionView('Warranty Date', '12.12.12'),
                SizedBox(
                  height: 15.dynamic,
                ),
                JobDetailTitleDescriptionView('Location',
                    'Dummy flat, dummy road, dummy state, pincode - 11221'),
                SizedBox(
                  height: 15.dynamic,
                ),
                JobDetailTitleDescriptionView('Sub Location',
                    'Dummy flat, dummy road, dummy state, pincode - 11221'),
                SizedBox(
                  height: 15.dynamic,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Floor Plan',
                      style: TextStyle(
                          color: Colour.appDarkGrey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.dynamic),
                    ),
                    SizedBox(
                      height: 4.dynamic,
                    ),
                    GestureDetector(
                      onTap: () async {
                        // final floorText = detail.aFloorPlan;
                        // if (floorText != null && floorText.length > 3) {
                        //   final isPDF =
                        //       floorText.substring(floorText.length - 3) == 'pdf';
                        //   if (isPDF) {
                        //     Get.bottomSheet(
                        //       Center(
                        //         child: Container(
                        //           child: PDFViewer(
                        //             document:
                        //             await PDFDocument.fromURL(floorText),
                        //           ),
                        //         ),
                        //       ),
                        //       isScrollControlled: true,
                        //       ignoreSafeArea: false,
                        //     );
                        //   } else {
                        //     Get.bottomSheet(
                        //       Center(
                        //         child: PhotoView(
                        //           imageProvider: NetworkImage(floorText),
                        //         ),
                        //       ),
                        //       isScrollControlled: true,
                        //       ignoreSafeArea: false,
                        //     );
                        //   }
                        // } else {
                        //   Toast.show('Invalid Floor Plan', Get.context);
                        // }
                      },
                      child: Text(
                        'NA',
                        style: TextStyle(
                            color: Colour.appBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.dynamic),
                      ),
                    ),
                  ],
                ),
              ],
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

  // final _formKey = GlobalKey<FormState>();
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
              child: Column(
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
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
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
                                      dropdownSearchDecoration: InputDecoration(
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
                                            customer.find(
                                                val!, customer.customerList);
                                        customer.fetchCustomerProductList();
                                        // await createJob
                                        //     .fetchCustomerProductList(
                                        //         selectedCustomer
                                        //             .value!.aId);
                                      },

                                      // selectedItem: createJob.valueOfDrop.value,
                                    ),
                                  ),
                                  // Select Product DropDown
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
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
                                      dropdownSearchDecoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      mode: Mode.MENU,
                                      // showSelectedItem: true,
                                      items: customer
                                          .arrString(customer.locationList),
                                      // selectedItem: selectedCustomerProduct
                                      //         .value?.aName ??
                                      //     'Select',
                                      // label: "Menu mode",
                                      hint: "Select Location",
                                      popupItemDisabled: (String s) =>
                                          s.startsWith('I'),
                                      onChanged: (val) {
                                        customer.selectedLocation.value =
                                            customer.find(
                                                val!, customer.locationList);
                                        customer.fetchCustomerProductList();
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
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
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
                                      dropdownSearchDecoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      mode: Mode.MENU,
                                      // showSelectedItem: true,
                                      items: customer
                                          .arrString(customer.productList),
                                      // label: "Menu mode",
                                      hint: 'Select Product',
                                      onChanged: (val) {
                                        customer.selectedProduct.value =
                                            customer.find(
                                                val!, customer.productList);
                                        customer.fetchCustomerProductList();
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
          safeString(description),
          style: TextStyle(
              color: Colour.appBlack,
              fontWeight: FontWeight.w400,
              fontSize: 14.dynamic),
        ),
      ],
    );
  }
}
