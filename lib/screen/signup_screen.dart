import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/gestures.dart';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/model/register_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  var txt = TextEditingController();
  final DateFormat format = DateFormat('dd-MM-yyyy');
  bool? _checkboxAgree = false;
  bool? _checkboxTerms = false;
  bool isApiCallService = false;

  String? _userName;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _countryCode;
  String? _phoneNumber;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        txt.text = format.format(selectedDate);
        print(txt.text);
      });
  }

  TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      //inAsyncCall: isApiCallService,
      child: MaterialApp(
        home: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            key: scaffoldKey,
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
                        padding:
                            EdgeInsets.only(left: 16, top: 10.0, bottom: 24.0),
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
                            autovalidateMode: AutovalidateMode.always,
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
                                        fontSize: 16.dynamic.dynamic),
                                  ),
                                ),
                                SizedBox(
                                  height: 21.dynamic,
                                ),
                                Container(
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      // Using MultiValidator to validate the input
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                        MinLengthValidator(6,
                                            errorText:
                                                "User Name should be at least 6 characters"),
                                      ]);

                                      return multiValidator(value);
                                    },
                                    obscureText: false,
                                    onChanged: (userName) =>
                                        _userName = userName,
                                    keyboardType: TextInputType.text,
                                    style: style,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "User Name",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13.dynamic,
                                ),
                                Container(
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                      ]);

                                      return multiValidator(value);
                                    },
                                    obscureText: false,
                                    onChanged: (firstName) =>
                                        _firstName = firstName,
                                    keyboardType: TextInputType.text,
                                    style: style,
                                    decoration: InputDecoration(
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
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                      ]);

                                      return multiValidator(value);
                                    },
                                    obscureText: false,
                                    onChanged: (lastName) =>
                                        _lastName = lastName,
                                    keyboardType: TextInputType.text,
                                    style: style,
                                    decoration: InputDecoration(
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
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: TextFormField(
                                      controller: txt,
                                      validator: (value) {
                                        final multiValidator = MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                        ]);
                                        return multiValidator(value);
                                      },

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
                                        suffixIcon:
                                            Icon(CupertinoIcons.calendar),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13.dynamic,
                                ),
                                Container(
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                      ]);
                                      return multiValidator(value);
                                    },
                                    obscureText: false,
                                    onChanged: (email) => _email = email,
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
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      // Using MultiValidator to validate the input
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                        MinLengthValidator(6,
                                            errorText:
                                                "Password should be at least 6 characters"),
                                        MaxLengthValidator(15,
                                            errorText:
                                                "Password should not be greater than 15 characters"),
                                      ]);

                                      return multiValidator(value);
                                    },
                                    obscureText: true,
                                    onChanged: (password) =>
                                        _password = password,
                                    keyboardType: TextInputType.text,
                                    style: style,
                                    decoration: InputDecoration(
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
                                  height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    validator: (value) {
                                      // Using MultiValidator to validate the input
                                      final multiValidator = MultiValidator([
                                        RequiredValidator(
                                            errorText: "* Required"),
                                        MinLengthValidator(6,
                                            errorText:
                                                "Password should be at least 6 characters"),
                                        MaxLengthValidator(15,
                                            errorText:
                                                "Password should not be greater than 15 characters"),
                                      ]);

                                      // Applying the validation and returning the error message if any
                                      return multiValidator(value);
                                    },
                                    obscureText:
                                        true, // Set to true if this is a password field
                                    onChanged: (confirmPassword) =>
                                        _confirmPassword = confirmPassword,
                                    keyboardType: TextInputType.text,
                                    style: style,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Confirm password*",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 13.dynamic,
                                ),
                                Container(
                                 height: 60.0.dynamic,
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child:Padding(
                                    padding: EdgeInsets.only(top: 10),
                                     child: IntlPhoneField(
                                  
                                    decoration: InputDecoration(
                                      // labelText: 'Phone Number',
                                      hintText: 'Phone Number',
                                      suffixIcon: Icon(Icons.phone),
                                      contentPadding: EdgeInsets.only(top: 20),
                                          
                                      border: InputBorder.none,
                                      isDense: true, 
                                            hintStyle: TextStyle(height: 1.5),

                                    ),
                                    initialCountryCode: 'IN',
                                    onChanged: (phone) {
                                      _countryCode = phone.countryCode;
                                      _phoneNumber = phone.number;
                                    },
                                  ),
                               
                                  ),
                                  ),

                                // Container(
                                //  height: 60.0.dynamic,
                                //   decoration: BoxDecoration(
                                //     color: Colour.appLightGrey,
                                //     borderRadius: BorderRadius.circular(10.0),
                                //   ),
                                //   child: IntlPhoneField(
                                //     decoration: InputDecoration(
                                //       // labelText: 'Phone Number',
                                //       hintText: 'Phone Number',
                                //       suffixIcon: Icon(Icons.phone),
                                //       border: InputBorder.none,
                                //     ),
                                //     initialCountryCode: 'IN',
                                //     onChanged: (phone) {
                                //       _countryCode = phone.countryCode;
                                //       _phoneNumber = phone.number;
                                //     },
                                //   ),
                                // ),
                                FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor:
                                                    Color(0xFFC0C0C0),
                                              ),
                                              child: Checkbox(
                                                  value: _checkboxAgree,
                                                  tristate: false,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _checkboxAgree = val;
                                                      state.didChange(val);
                                                    });
                                                  }),
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
                                        _checkboxAgree!
                                            ? Container()
                                            : Text(
                                                state.errorText ?? '',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                  validator: (value) {
                                    if (!_checkboxAgree!) {
                                      return 'You must  accept the agreement';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                FormField<bool>(
                                  builder: (state) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor:
                                                    Color(0xFFC0C0C0),
                                              ),
                                              child: Checkbox(
                                                  value: _checkboxTerms,
                                                  onChanged: (bool? val) {
                                                    setState(() {
                                                      _checkboxTerms = val;
                                                      state.didChange(val);
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  80,
                                              alignment: Alignment.center,
                                              child: Center(
                                                child: Text.rich(
                                                  TextSpan(
                                                    text: 'I agree to the ',
                                                    style: TextStyle(
                                                      color: Color(0xFF9A9A9A),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16.dynamic,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Terms of Service',
                                                          style: TextStyle(
                                                            color:
                                                                Colour.appBlue,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize:
                                                                14.dynamic,
                                                          ),
                                                          recognizer:
                                                              TapGestureRecognizer()
                                                                ..onTap = () {
                                                                  // code to open / launch terms of service link here
                                                                }),
                                                      TextSpan(
                                                        text: ' and ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:
                                                                Colors.black),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  'Privacy Policy',
                                                              style: TextStyle(
                                                                color: Colour
                                                                    .appBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    14.dynamic,
                                                              ),
                                                              recognizer:
                                                                  TapGestureRecognizer()
                                                                    ..onTap =
                                                                        () {
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
                                        _checkboxTerms!
                                            ? Container()
                                            : Text(
                                                state.errorText ?? '',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                ),
                                              ),
                                      ],
                                    );
                                  },
                                  validator: (val) {
                                    if (!_checkboxTerms!) {
                                      return 'You must  accept the Terms and Conditions';
                                    } else {
                                      return null;
                                    }
                                  },
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
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () async {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      // RegisterRequestModel registerRequestModel =
                                      //     RegisterRequestModel(
                                      //         firstName: 'demo',
                                      //         lastName: 'acc',
                                      //         password: '123456',
                                      //         email: 'demo@yopmail.com',
                                      //         confirmPassword: '123456',
                                      //         countryCode: '+91',
                                      //         dob: '01-01-1999',
                                      //         mobileNumber: '7410075100',
                                      //         userName: 'demouser');

                                      RegisterRequestModel
                                          registerRequestModel =
                                          RegisterRequestModel(
                                              firstName: _firstName,
                                              lastName: _lastName,
                                              password: _password,
                                              email: _email,
                                              confirmPassword: _confirmPassword,
                                              countryCode: _countryCode,
                                              dob: txt.text,
                                              mobileNumber: _phoneNumber,
                                              userName: _userName);
                                      RegisterResponseModel? model;

                                      try {
                                        setState(() {
                                          isApiCallService = true;
                                        });
                                        var response = await API.service.call(
                                            model: RegisterResponseModel(),
                                            endPoint: EndPoint.register,
                                            body:
                                                registerRequestModel.toJson());
                                        model = response.model;
                                        print(model!.message);
                                        if (model.status.isSuccess) {
                                          print('true');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Register Successful'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        } else {
                                          print('false');
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  '${model.message} Hello Welcome'),
                                              duration: Duration(seconds: 1),
                                            ),
                                          );
                                        }
                                        print('ERROR${model.status}');
                                      } catch (err) {
                                        print(err);
                                      }
                                      setState(() {
                                        isApiCallService = false;
                                      });

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (_formkey.currentState!.validate()) {
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
        ),
      ),
    );
  }
}
