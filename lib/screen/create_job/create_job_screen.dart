import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/create_job_itemList_model.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/create_job/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../api/ParamModel.dart';
import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/controller/createjob_controller.dart';

import '../../model/abstract_class.dart';
import '../../reuse/date_manager.dart';
import 'package:toast/toast.dart';

extension CreateJobAction on _CreateJobScreenState {
  onCreateJob() async {
    final param = ParamCreateJob(
      customerID: selectedCustomer.value!.aId,
      productItemID: selectedProduct.value!.aId,
      serviceTypeID: selectedServiceType.value!.aId,
      serviceDate: DateFormat(AppDateFormat.yyyy_MM_dd).format(DateTime.now()),
      subject: _enterSub1.text,
      description: _enterSub1.text,
    );

    print(param);
    try {
      final isJobCreated = await createJob.scCreateJob(param);
      if (isJobCreated) {
        Get.back();
        Toast.show('New Job created successfully', duration: 2);
        print('New Job created successfully');
      } else {
        Toast.show(kErrorMsg);
      }
    } catch (e) {
      Toast.show('$e');
      print(e);
    }
  }
}

class CreateJobScreen extends StatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final CreateJobController createJob = Get.put(CreateJobController());

  final Rx<ADropDown?> selectedCustomer = Rx(null);
  final Rx<ADropDown?> selectedProduct = Rx(null);
  final Rx<ADropDown?> selectedServiceType = Rx(null);

  final TextEditingController _enterSub1 = TextEditingController();

  final TextEditingController _enterSub2 = TextEditingController();
  String? email = "";
  String? phoneNO = "";
  String? billingAddress = "";
  String? selectedSource = "Select Source";
  String? selectedProj = "Choose Project";
  String? selectedPriority = "Select Priority";
  String? selectedStatus = "Select Status";

  final _formKey = GlobalKey<FormState>();

  String get dSelectedProduct {
    final selected = selectedProduct.value as MCustomerProductItem?;
    if (selected == null) {
      return 'Select Product';
    }
    return '${selected.aName} - ${selected.productId}';
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
              'Create Job',
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
            return Stack(
              children: [
                Container(
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
                                  key: _formKey,
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

                                          validator: (item) {
                                            if (item == null)
                                              return '* Required';
                                            else
                                              return null;
                                          },
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          mode: Mode.MENU,
                                          showSelectedItem: true,
                                          items: createJob.arrString(
                                              createJob.customerList),

                                          //label: "Menu mode",
                                          hint: "Choose Customer",

                                          onChanged: (val) async {
                                            selectedProduct.value = null;

                                            selectedCustomer.value =
                                                createJob.find(val!,
                                                    createJob.customerList);
                                            phoneNO = selectedCustomer
                                                .value!.aPhoneNo;
                                            billingAddress = selectedCustomer
                                                .value!.aBillingAddress;
                                            email =
                                                selectedCustomer.value!.aEmail;
                                            print("choose value" +
                                                selectedCustomer.value!.aId);
                                            await createJob
                                                .fetchCustomerProductList(
                                                    selectedCustomer
                                                        .value!.aId);
                                          },

                                          // selectedItem: createJob.valueOfDrop.value,
                                        ),
                                      ),
                                      email!.isNotEmpty
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        6.dynamic),
                                                color: Colors.white,
                                              ),
                                              padding:
                                                  EdgeInsets.all(14.dynamic),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Customer Info',
                                                    style: TextStyle(
                                                      fontSize: 14.dynamic,
                                                      color: Colour.appBlack,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 12.dynamic),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      JobDetailTitleDescriptionView(
                                                          'Email:', email),
                                                      JobDetailTitleDescriptionView(
                                                          'Contact No:',
                                                          phoneNO),
                                                    ],
                                                  ),
                                                  SizedBox(height: 12.dynamic),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      JobDetailTitleDescriptionView(
                                                          'Billing Address:',
                                                          billingAddress),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),

                                      // Select Product DropDown
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Product',
                                          style: TextStyle(
                                            fontSize: 14.dynamic,
                                            color: Colour.appBlack,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
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
                                          items: createJob
                                              .arrStringForProductList(),
                                          // selectedItem: selectedCustomerProduct
                                          //         .value?.aName ??
                                          //     'Select',
                                          // label: "Menu mode",
                                          hint: "Select Product",
                                          // popupItemDisabled: (String s) =>
                                          //     s.startsWith('I'),
                                          onChanged: (val) {
                                            selectedProduct.value =
                                                createJob.findProduct(
                                                    val!,
                                                    createJob
                                                        .customerProductList);
                                          },
                                          validator: (item) {
                                            if (dSelectedProduct == '')
                                              return '* Required';
                                            else
                                              return null;
                                          },
                                          selectedItem: dSelectedProduct,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Type of permise',
                                            style: TextStyle(
                                              fontSize: 14.dynamic,
                                              color: Colour.appBlack,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Colors
                                                      .red, // Set the asterisk (*) color to red
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
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
                                          mode: Mode.MENU,
                                          showAsSuffixIcons: true,
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          items: ['Residential', 'Commercial'],
                                          hint: "Select Department",
                                          onChanged: (val) {
                                            // Handle department selection here
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Address',
                                            style: TextStyle(
                                              fontSize: 14.dynamic,
                                              color: Colour.appBlack,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '*',
                                                style: TextStyle(
                                                  color: Colors
                                                      .red, // Set the asterisk (*) color to red
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          obscureText: false,
                                          maxLines: 4,
                                          controller: _enterSub2,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (val) {},
                                          style: TextStyle(
                                              fontSize: 14.dynamic,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Address",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 12.dynamic,
                                      ),

                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: CustomDropdown(
                                              items: [
                                                'Choose Project',
                                              ],
                                              value: selectedProj!,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedProj = newValue!;
                                                });
                                              },
                                            )),
                                            Expanded(
                                                child: CustomDropdown(
                                              items: [
                                                'Select Source',
                                                'Email',
                                                'Web Site',
                                                'Phone',
                                                'Forum',
                                                'Twitter',
                                                'Facebook',
                                                'Chat',
                                                'MobiHelp',
                                                'Feedback Widget',
                                                'Outbound Email',
                                                'Ecommerce',
                                                'Bot',
                                                'Whatsapp'
                                              ],
                                              value: selectedSource!,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedSource = newValue!;
                                                });
                                              },
                                            ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.dynamic,
                                      ),

                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: CustomDropdown(
                                              items: [
                                                'Select Priority',
                                                'Low',
                                                'Medium',
                                                'High',
                                                'Urgent'
                                              ],
                                              value: selectedPriority!,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedPriority = newValue!;
                                                });
                                              },
                                            )),
                                            Expanded(
                                              child: CustomDropdown(
                                                items: [
                                                  'Select Status',
                                                  'Open',
                                                  'Pending',
                                                  'Resolved',
                                                  'Closed',
                                                  'Waiting On Customer',
                                                  'Waiting On Third Party',
                                                ],
                                                value: selectedStatus!,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedStatus = newValue;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.dynamic,
                                      ),
                                       

                                      Container(
                                        margin:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: CustomDropdown(
                                              items: [
                                                'Select Priority',
                                                'Low',
                                                'Medium',
                                                'High',
                                                'Urgent'
                                              ],
                                              value: selectedPriority!,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  selectedPriority = newValue!;
                                                });
                                              },
                                            )),
                                            Expanded(
                                              child: CustomDropdown(
                                                items: [
                                                  'Select Status',
                                                  'Open',
                                                  'Pending',
                                                  'Resolved',
                                                  'Closed',
                                                  'Waiting On Customer',
                                                  'Waiting On Third Party',
                                                ],
                                                value: selectedStatus!,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    selectedStatus = newValue;
                                                  });
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                       SizedBox(
                                        height: 12.dynamic,
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
                                          items: createJob.arrString(
                                              createJob.serviceTypeList),
                                          // label: "Menu mode",
                                          hint: "Choose Service Type",
                                          onChanged: (val) {
                                            selectedServiceType.value =
                                                createJob.find(val!,
                                                    createJob.serviceTypeList);
                                          },
                                          validator: (item) {
                                            if (item == null)
                                              return '* Required';
                                            else
                                              return null;
                                          },
                                          // selectedItem: "Brazil",
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        child: TextFormField(
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                          ]),
                                          obscureText: false,
                                          controller: _enterSub1,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (val) {},
                                          style: TextStyle(
                                              fontSize: 14.dynamic,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Enter Subject",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: TextFormField(
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                          ]),
                                          obscureText: false,
                                          maxLines: 4,
                                          controller: _enterSub2,
                                          keyboardType: TextInputType.multiline,
                                          onChanged: (val) {},
                                          style: TextStyle(
                                              fontSize: 14.dynamic,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Description",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 19.dynamic,
                            left: 17.dynamic,
                            right: 17.dynamic,
                            // bottom: 10.dynamic,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colour.appBlue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.dynamic),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      this.onCreateJob();
                                    }
                                  },
                                  child: Text(
                                    'Create Job',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.dynamic,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              // SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.dynamic),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colour.appRed,
                                        fontSize: 16.dynamic,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppController.to.defaultLoaderView(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
