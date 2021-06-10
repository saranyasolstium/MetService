import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/customer_information_controller.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class CustomerInformationScreen extends StatelessWidget {
  final customer = Get.put(CustomerInformationController());
  Widget get contentView {
    if (customer.viewState.isSuccess) {
      return ListView.builder(
        itemBuilder: (con, index) {
          return Text('fdsa');
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
