import 'package:dropdown_search/dropdown_search.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/controller/createjob_controller.dart';

// ignore: must_be_immutable
class CreateJobScreen extends StatelessWidget {
  // final CreateJobController createJob = Get.put(CreateJobController());

  // final _formkey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _enterSub1 = TextEditingController();

  final TextEditingController _enterSub2 = TextEditingController();

  // Widget dropDownView(String hint, List<String> dropDownValues) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 19.dynamic),
  //     padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.all(
  //         Radius.circular(5.dynamic),
  //       ),
  //     ),
  //     child: DropdownButton<String>(
  //       value: createJob.valueOfDrop.value,
  //       hint: Text(hint),
  //       onChanged: (val) {
  //         createJob.setSelected(val.toString());
  //       },
  //       items: dropDownValues.map<DropdownMenuItem<String>>((String value) {
  //         return DropdownMenuItem<String>(
  //           value: value,
  //           child: Text(value),
  //         );
  //       }).toList(),
  //       underline: Container(),
  //       icon: Expanded(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Icon(
  //               Icons.keyboard_arrow_down,
  //               size: 30.dynamic,
  //               color: Colour.appDarkGrey,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
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
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
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
                                    validator: (item) {
                                      if (item == null)
                                        return 'Required Field';
                                      else
                                        return null;
                                    },
                                    dropdownSearchDecoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    mode: Mode.MENU,
                                    // showSelectedItem: true,
                                    items: [
                                      "Brazil",
                                      "Italia (Disabled)",
                                      "Tunisia",
                                      'Canada'
                                    ],
                                    // label: "Menu mode",
                                    hint: "Choose Customer",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('I'),
                                    onChanged: (val) {}
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
                                  items: [
                                    "Brazil",
                                    "Italia (Disabled)",
                                    "Tunisia",
                                    'Canada'
                                  ],
                                  // label: "Menu mode",
                                  hint: "Select Product",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (val) {},
                                  validator: (item) {
                                    if (item == null)
                                      return 'Required Field';
                                    else
                                      return null;
                                  },
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
                                  items: [
                                    "Brazil",
                                    "Italia (Disabled)",
                                    "Tunisia",
                                    'Canada'
                                  ],
                                  // label: "Menu mode",
                                  hint: "Choose Service Type",
                                  popupItemDisabled: (String s) =>
                                      s.startsWith('I'),
                                  onChanged: (val) {},
                                  validator: (item) {
                                    if (item == null)
                                      return 'Required Field';
                                    else
                                      return null;
                                  },
                                  // selectedItem: "Brazil",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 19.dynamic),
                                child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
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
                                    RequiredValidator(errorText: "* Required"),
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
                                    hintText: "Enter Subject",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
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
                              // if (_formkey.currentState!.validate()) {
                              //   _formkey.currentState!.save();
                              // }
                              // this.onCompleteJob();
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
                            onPressed: () {},
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
      ),
    );
  }
}
