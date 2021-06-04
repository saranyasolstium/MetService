import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';
import '../../constant.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/controller/createjob_controller.dart';

// ignore: must_be_immutable
class CreateJobScreen extends StatelessWidget {
  final CreateJobController createJob = Get.put(CreateJobController());

  final TextEditingController _enterSub1 = TextEditingController();

  final TextEditingController _enterSub2 = TextEditingController();

  // String dropValue = 'A';
  List<String> locations = ['A', 'B', 'C', 'D'];

  Widget dropDownView(String hint, List<String> dropDownValues) {
    return Container(
      margin: EdgeInsets.only(bottom: 19.dynamic),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5.dynamic),
        ),
      ),
      child: DropdownButton<String>(
        value: createJob.valueOfDrop.value,
        hint: Text(hint),
        onChanged: (val) {
          createJob.setSelected(val.toString());
        },
        items: dropDownValues.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        underline: Container(),
        icon: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.keyboard_arrow_down,
                size: 30.dynamic,
                color: Colour.appDarkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        dropDownView('Choose Customer', locations),
                        dropDownView('Choose Customer', locations),
                        dropDownView('Choose Customer', locations),
                        Padding(
                          padding: EdgeInsets.only(bottom: 19.dynamic),
                          child: TextFormField(
                            obscureText: false,
                            controller: _enterSub1,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: 14.dynamic,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Enter Subject",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        TextFormField(
                          obscureText: false,
                          maxLines: 4,
                          controller: _enterSub2,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontSize: 14.dynamic,
                              fontWeight: FontWeight.w300),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Enter Subject",
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  )),
              AppController.to.defaultLoaderView(),
            ],
          ),
        ),
      ),
    );
  }
}
