import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/model/login_model.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);

  final _formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _obsecureText = false;
  bool isApiCallService = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _obsecureText = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        EmailValidator(errorText: "Enter valid email id"),
      ]),
      obscureText: false,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: InputBorder.none,
      ),
    );

    final passwordField = TextFormField(
      validator: MultiValidator([
        RequiredValidator(errorText: "* Required"),
        MinLengthValidator(6,
            errorText: "Password should be atleast 6 characters"),
        MaxLengthValidator(15,
            errorText: "Password should not be greater than 15 characters")
      ]),
      controller: _passwordController,
      obscureText: _obsecureText,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obsecureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obsecureText = !_obsecureText;
            });
          },
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border: InputBorder.none,
      ),
    );
    final loginButton = Material(
      // elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Colour.appBlue,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          var email = _emailController.text;
          var password = _passwordController.text;
          if (_formkey.currentState.validate()) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
            LoginRequestModel loginRequestModel =
                LoginRequestModel(email: email, password: password);

            var response = await API.service.call(
                model: LoginResponseModel(),
                endPoint: EndPoint.login,
                body: loginRequestModel.toJson());

            var map = response.map;

            var token = map['access_token'] as String;
            token = "fdasfd"; //temp
            if (token != null && token.isNotEmpty) {
              AppController.to.storage.write('token', token);
              print('Stored Token - $token');
              AppController.to.loginStatus.value = LoginStatus.logged;
              Future.delayed(
                Duration(seconds: 1),
                () => Get.snackbar("Login Success", 'Successfully logged in.'),
              );
            } else {
              var message =
                  map['error'] ??= 'Something went wrong. Please try again';
              Get.snackbar("Login Failed", '$message');
            }
          } else {
            print('Not Validated');
          }
        },
        child: Text('Login',
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.w300)),
      ),
    );

    return ModalProgressHUD(
      inAsyncCall: isApiCallService,
      child: Stack(
        children: [
          Container(
            color: Color(0xFFF7F7F7),
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
              child: Image.asset(
                'images/login.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.0, bottom: 20.0),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Hello',
                                        style: TextStyle(
                                            color: Colour.appBlue,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 45.0.dynamic),
                                      ),
                                      Image.asset(
                                        'images/pixellogo.png',
                                        fit: BoxFit.fill,
                                        width: 60.dynamic,
                                        height: 60.dynamic,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Welcome to Pixels Connect.',
                                  style: TextStyle(
                                      color: Colour.appBlack,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0.dynamic),
                                ),
                                Text(
                                  'Login to our platform',
                                  style: TextStyle(
                                      color: Colour.appDarkGrey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.0.dynamic),
                                ),
                                SizedBox(
                                  height: 150.dynamic,
                                ),
                              ],
                            ),
                            Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Engineer Login',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.0.dynamic),
                                  ),
                                  SizedBox(
                                    height: 18.dynamic,
                                  ),
                                  Container(
                                    child: emailField,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    child: passwordField,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  loginButton,
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SignUpScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Create new account',
                                        style: TextStyle(
                                            color: Colour.appBlue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0.dynamic),
                                      ),
                                    ),
                                  ),
                                  SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85.0, bottom: 34.0),
                                      child: Center(
                                        child: Image.asset(
                                          'images/poweredby.png',
                                          fit: BoxFit.fill,
                                          // width: 60.dynamic,
                                          // height: 60.dynamic,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AppController.to.defaultLoaderView(),
        ],
      ),
    );
  }
}
