import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/create_job/create_job_screen2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/controller/createjob_controller.dart';

import '../../model/abstract_class.dart';
import 'package:toast/toast.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';

//extension CreateJobAction on _CreateJobScreenState {
//   onCreateJob() async {
//     final param = ParamCreateJob(
//       customerID: selectedCustomer.value!.aId,
//       productItemID: "",
//       serviceTypeID: selectedServiceType.value!.aId,
//       serviceDate: DateFormat(AppDateFormat.yyyy_MM_dd).format(DateTime.now()),
//       subject: _enterSub1.text,
//       description: _enterSub1.text,
//     );

//     print(param);
//     try {
//       final isJobCreated = await createJob.scCreateJob(param);
//       if (isJobCreated) {
//         Get.back();
//         Toast.show('New Job created successfully', duration: 2);
//         print('New Job created successfully');
//       } else {
//         Toast.show(kErrorMsg);
//       }
//     } catch (e) {
//       Toast.show('$e');
//       print(e);
//     }
//   }
// }

class CreateJobScreen extends StatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final CreateJobController createJob = Get.put(CreateJobController());

  final Rx<ADropDown?> selectedCustomer = Rx(null);
  // final Rx<ADropDown?> selectedProduct = Rx(null);
  final Rx<ADropDown?> selectedServiceType = Rx(null);

  String? email = "";
  String? phoneNO = "";
  String? billingAddress = "";
  String? selectedSource = "Select Source";
  String? selectedProduct = "Select Product";

  String? selectedProj = "Choose Project";
  String? selectedPriority = "Select Priority";
  String? selectedStatus = "Select Status";
  String? selectedAppoinment = "Select Appointment";
  String? selectedSaleOrder = "Select Sale Order";
  String? selectedprojectCode = "Select Project Code";
  String selectedService = "";
  String selectedSubService = "Select Sub Service";
  String selectedcustomerType = "Select Customer type";

  final _formKey = GlobalKey<FormState>();

  // String get dSelectedProduct {
  //   final selected = selectedProduct.value as MCustomerProductItem?;
  //   if (selected == null) {
  //     return 'Select Product';
  //   }
  //   return '${selected.aName} - ${selected.productId}';
  // }

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
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Choose Customer',
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
                                          validator: (item) {
                                            if (item == null)
                                              return '* Required';
                                            else
                                              return null;
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Choose Customer",
                                            ),
                                          ),

                                          popupProps:
                                              PopupProps.modalBottomSheet(
                                                  showSelectedItems: true,
                                                  showSearchBox: true),

                                          items: createJob.arrString(
                                              createJob.customerList),
                                          onChanged: (val) async {
                                            setState(() {
                                              selectedAppoinment =
                                                  "Select Appointment";
                                              createJob.oppoinmentList.clear();
                                            });

                                            selectedCustomer.value =
                                                createJob.find(val!,
                                                    createJob.customerList);
                                            phoneNO = selectedCustomer
                                                .value!.aPhoneNo;
                                            billingAddress = selectedCustomer
                                                .value!.aBillingAddress;
                                            createJob.addressCtrl.text =
                                                selectedCustomer
                                                    .value!.aBillingAddress;
                                            email =
                                                selectedCustomer.value!.aEmail;
                                            print("choose value" +
                                                selectedCustomer.value!.aId);
                                            createJob.customerID = int.parse(
                                                selectedCustomer.value!.aId);

                                            await createJob
                                                .fetchOppoinmentRequest(
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
                                                    ],
                                                  ),
                                                  SizedBox(height: 12.dynamic),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      JobDetailTitleDescriptionView(
                                                          'Contact No:',
                                                          phoneNO),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Appointment Request',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Appointment",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: createJob.oppoinmentList
                                              .map((appointment) {
                                            return '${appointment.bookingDate} - ${appointment.address}';
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedAppoinment = null;
                                            });
                                            selectedAppoinment = val;
                                            createJob.getAppoinmentFromName(
                                                selectedAppoinment!);
                                          },
                                          selectedItem: selectedAppoinment,
                                        ),
                                      ),

                                      SizedBox(height: 10.dynamic),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Sale Order',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Sales Order",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          onChanged: (val) {},
                                          selectedItem: selectedSaleOrder,
                                        ),
                                      ),
                                      SizedBox(height: 10.dynamic),
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
                                          controller: createJob.addressCtrl,
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
                                        height: 10.dynamic,
                                      ),

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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Product",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: createJob.productList
                                              .map((product) =>
                                                  product.name ?? '')
                                              .toList(),
                                          onChanged: (val) {
                                            selectedProduct = val;
                                            createJob.getProductFromName(
                                                selectedProduct!);
                                          },
                                          selectedItem: selectedProduct,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Department",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: ['Residential', 'Commercial'],
                                          onChanged: (val) {
                                            if (val == "Residential") {
                                              createJob.selectedDepartId = "29";
                                            } else {
                                              createJob.selectedDepartId = "38";
                                            }
                                            print(createJob.selectedDepartId);
                                          },
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Project Code',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Choose Project Code",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: [
                                            'Choose Project Code',
                                          ],
                                          onChanged: (val) {
                                            // Handle department selection here
                                          },
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 10.dynamic,
                                      // ),
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     'Priority',
                                      //     style: TextStyle(
                                      //       fontSize: 14.dynamic,
                                      //       color: Colour.appBlack,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 10.dynamic,
                                      // ),
                                      // Container(
                                      //   margin:
                                      //       EdgeInsets.only(bottom: 19.dynamic),
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 2, horizontal: 15),
                                      //   width: double.infinity,
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(5.dynamic),
                                      //     ),
                                      //   ),
                                      //   child: DropdownSearch<String>(
                                      //     dropdownDecoratorProps:
                                      //         DropDownDecoratorProps(
                                      //       dropdownSearchDecoration:
                                      //           InputDecoration(
                                      //         border: InputBorder.none,
                                      //         hintText: "Select Priority",
                                      //       ),
                                      //     ),
                                      //     popupProps: PopupProps.menu(
                                      //       showSelectedItems: true,
                                      //     ),
                                      //     items: [
                                      //       'Select Priority',
                                      //       'Low',
                                      //       'Medium',
                                      //       'High',
                                      //       'Urgent'
                                      //     ],
                                      //     onChanged: (val) {
                                      //       if (val == "Low") {
                                      //         createJob.selectedPriorityId =
                                      //             "1";
                                      //       } else if (val == "Medium") {
                                      //         createJob.selectedPriorityId =
                                      //             "2";
                                      //       } else if (val == "High") {
                                      //         createJob.selectedPriorityId =
                                      //             "3";
                                      //       } else if (val == "Urgent") {
                                      //         createJob.selectedPriorityId =
                                      //             "4";
                                      //       } else {
                                      //         createJob.selectedPriorityId = "";
                                      //       }
                                      //       print(createJob.selectedPriorityId);
                                      //     },
                                      //   ),
                                      // ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Service Amount',
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
                                      Padding(
                                        padding:
                                            EdgeInsets.only(bottom: 19.dynamic),
                                        child: TextFormField(
                                          obscureText: false,
                                          controller:
                                              createJob.serviceAmountCtrl,
                                          keyboardType: TextInputType.number,
                                          onChanged: (val) {},
                                          style: TextStyle(
                                              fontSize: 14.dynamic,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Enter Service Amount",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Service',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Service",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: createJob.serviceList
                                              .map((serviceName) =>
                                                  serviceName.serviceName ?? '')
                                              .toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedSubService =
                                                  "Select Sub Service";
                                              createJob.subServiceList.clear();
                                            });

                                            createJob.subServiceList.clear();
                                            int? selectedServiceId = createJob
                                                .getServiceIdFromName(val!);
                                            print(selectedServiceId);
                                            createJob.fetchSubServiceRequest(
                                                selectedServiceId!);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Sub Service',
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
                                      MultiSelectDialogField(
                                        items: createJob.subServiceList
                                            .map((subService) =>
                                                MultiSelectItem<String>(
                                                  subService.id.toString(),
                                                  subService.serviceName!,
                                                ))
                                            .toList(),
                                        listType: MultiSelectListType.CHIP,
                                        onConfirm: (values) {
                                          createJob.selectedSubServiceIds =
                                              values.cast<String>().toList();
                                          // Now you have the IDs of the selected sub-services
                                          print(
                                              createJob.selectedSubServiceIds);
                                        },
                                      ),

                                      SizedBox(
                                        height: 20.dynamic,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Customer Type',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Customer Type",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: [
                                            'Select Customer Type',
                                            'CONTRACT',
                                            'AD HOC',
                                            'OTHERS'
                                          ],
                                          onChanged: (val) {
                                            if (val == "Select Customer Type") {
                                              createJob.selectedCustomerType =
                                                  "";
                                            } else {
                                              createJob.selectedCustomerType =
                                                  val!;
                                            }
                                            print(
                                                createJob.selectedCustomerType);
                                          },
                                          selectedItem: selectedcustomerType,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Status',
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
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Select Status",
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            showSelectedItems: true,
                                          ),
                                          items: [
                                            'Select Status',
                                            'Open',
                                            'Pending',
                                            'Resolved',
                                            'Closed',
                                            'Waiting On Customer',
                                            'Waiting On Third Party',
                                          ],
                                          onChanged: (val) {
                                            if (val == "Open") {
                                              createJob.selectedStatusId = "2";
                                            } else if (val == "Pending") {
                                              createJob.selectedStatusId = "3";
                                            } else if (val == "Resolved") {
                                              createJob.selectedStatusId = "4";
                                            } else if (val == "Closed") {
                                              createJob.selectedStatusId = "5";
                                            } else if (val ==
                                                "Waiting On Customer") {
                                              createJob.selectedStatusId = "6";
                                            } else if (val ==
                                                "Waiting On Third Party") {
                                              createJob.selectedStatusId = "7";
                                            } else {
                                              createJob.selectedStatusId = "";
                                            }
                                            print(createJob.selectedStatusId);
                                          },
                                        ),
                                      ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      // Align(
                                      //   alignment: Alignment.topLeft,
                                      //   child: Text(
                                      //     'Attention',
                                      //     style: TextStyle(
                                      //       fontSize: 14.dynamic,
                                      //       color: Colour.appBlack,
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //   height: 10.dynamic,
                                      // ),
                                      // Padding(
                                      //   padding:
                                      //       EdgeInsets.only(bottom: 19.dynamic),
                                      //   child: TextFormField(
                                      //     obscureText: false,
                                      //     controller: createJob.attentionCtrl,
                                      //     onChanged: (val) {},
                                      //     style: TextStyle(
                                      //         fontSize: 14.dynamic,
                                      //         fontWeight: FontWeight.w300),
                                      //     decoration: InputDecoration(
                                      //       filled: true,
                                      //       fillColor: Colors.white,
                                      //       contentPadding: EdgeInsets.fromLTRB(
                                      //           20.0, 15.0, 20.0, 15.0),
                                      //       hintText: "Enter Attention",
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),

                                      // SizedBox(
                                      //   height: 12.dynamic,
                                      // ),
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
                                    // if (_formKey.currentState!.validate()) {
                                    //   _formKey.currentState!.save();
                                    //  // this.onCreateJob();
                                    // }
                                    if (selectedCustomer.value == null) {
                                      Toast.show(
                                        "please select customer",
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      );
                                    } else if (createJob
                                        .addressCtrl.text.isEmpty) {
                                      Toast.show(
                                        "please enter address",
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      );
                                    } else if (createJob
                                        .selectedDepartId.isEmpty) {
                                      Toast.show(
                                        "please select type of permise",
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      );
                                    } else {
                                      Get.to(CreateJobScreen2());
                                    }
                                  },
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.dynamic,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.all(
                              //       Radius.circular(5.dynamic),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Get.back();
                              //     },
                              //     child: Text(
                              //       'Cancel',
                              //       style: TextStyle(
                              //           color: Colour.appRed,
                              //           fontSize: 16.dynamic,
                              //           fontWeight: FontWeight.w300),
                              //     ),
                              //   ),
                              // ),
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
