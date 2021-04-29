import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:flutter/painting.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  final DateFormat format = DateFormat('yy-MM-dd');

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        txt.text = format.format(selectedDate);
      });
  }

  TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'images/signup_background.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Colors.white,
                        size: 30.dynamic,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, top: 10.0, bottom: 24.0),
                    child: Text(
                      'Hello,',
                      style: TextStyle(
                          fontSize: 25.dynamic,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          16.0,
                        ),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 31.0),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign up',
                                    style: TextStyle(
                                        color: Colour.appBlue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 22.0.dynamic),
                                  ),
                                  Image.asset(
                                    'images/eagle_logo.png',
                                    fit: BoxFit.fill,
                                    width: 88.79.dynamic,
                                    height: 32.58.dynamic,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'to our platform',
                                style: TextStyle(
                                    color: Color(0xFF9A9A9A),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0.dynamic),
                              ),
                            ),
                            SizedBox(
                              height: 21.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                ]),
                                obscureText: false,
                                // onChanged: (emailTyped) => email = emailTyped,
                                keyboardType: TextInputType.text,
                                style: style,

                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "First Name",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                ]),
                                obscureText: false,
                                // onChanged: (emailTyped) => email = emailTyped,
                                keyboardType: TextInputType.text,
                                style: style,

                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Last Name",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: TextFormField(
                                  controller: txt,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "* Required"),
                                  ]),
                                  obscureText: false,
                                  readOnly: true,

                                  onTap: () => _selectDate(context),
                                  // onChanged: (emailTyped) => email = emailTyped,
                                  style: style,
                                  decoration: InputDecoration(
                                    // prefixIcon: Icon(Icons.email),
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Choose date of birth",
                                    // labelText: 'Choose date of birth',
                                    suffixIcon: Icon(CupertinoIcons.calendar),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                ]),
                                obscureText: false,
                                // onChanged: (emailTyped) => email = emailTyped,
                                keyboardType: TextInputType.text,
                                style: style,

                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Email*",
                                  suffixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  MinLengthValidator(6,
                                      errorText:
                                          "Password should be atleast 6 characters"),
                                  MaxLengthValidator(15,
                                      errorText:
                                          "Password should not be greater than 15 characters")
                                ]),
                                obscureText: false,
                                // onChanged: (emailTyped) => email = emailTyped,
                                keyboardType: TextInputType.text,
                                style: style,

                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Enter password*",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                validator: MultiValidator([
                                  RequiredValidator(errorText: "* Required"),
                                  MinLengthValidator(6,
                                      errorText:
                                          "Password should be atleast 6 characters"),
                                  MaxLengthValidator(15,
                                      errorText:
                                          "Password should not be greater than 15 characters")
                                ]),
                                obscureText: false,
                                // onChanged: (emailTyped) => email = emailTyped,
                                keyboardType: TextInputType.text,
                                style: style,

                                decoration: InputDecoration(
                                  // prefixIcon: Icon(Icons.email),
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  hintText: "Confirm password *",

                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 13.dynamic,
                            ),
                            Container(
                              height: 48.0.dynamic,
                              decoration: BoxDecoration(
                                color: Colour.appLightGrey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: IntlPhoneField(
                                decoration: InputDecoration(
                                  // labelText: 'Phone Number',
                                  hintText: 'Phone Number',
                                  suffixIcon: Icon(Icons.phone),
                                  border: InputBorder.none,
                                ),
                                initialCountryCode: 'IN',
                                onChanged: (phone) {
                                  print(phone.completeNumber);
                                },
                              ),
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Color(0xFFC0C0C0),
                                  ),
                                  child: Checkbox(
                                      value: false,
                                      tristate: false,
                                      onChanged: (val) {}),
                                ),
                                Text(
                                  'I agree to share my personal details ',
                                  style: TextStyle(
                                    color: Color(0xFF9A9A9A),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16.dynamic,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Color(0xFFC0C0C0),
                                  ),
                                  child: Checkbox(
                                      value: false, onChanged: (val) {}),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 80,
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'I agree to the ',
                                        style: TextStyle(
                                          color: Color(0xFF9A9A9A),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.dynamic,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: 'Terms of Service',
                                              style: TextStyle(
                                                color: Colour.appBlue,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.dynamic,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  // code to open / launch terms of service link here
                                                }),
                                          TextSpan(
                                            text: ' and ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                            children: [
                                              TextSpan(
                                                  text: 'Privacy Policy',
                                                  style: TextStyle(
                                                    color: Colour.appBlue,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.dynamic,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          // code to open / launch privacy policy link here
                                                        })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 19.dynamic,
                            ),
                            Material(
                              // elevation: 5.0,
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colour.appBlue,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                height: 48.dynamic,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    Navigator.pop(context);

                                    print('Validated');
                                  } else {
                                    print('Not Validated');
                                  }
                                },
                                child: Text(
                                  'Create Account',
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 17.dynamic,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 26.0),
                              child: Text(
                                'www.solstium.net',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colour.appBlue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.dynamic,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
