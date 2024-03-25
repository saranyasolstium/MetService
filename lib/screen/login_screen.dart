import 'dart:convert';
import 'dart:ui';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/model/login_model.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

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
  Position? _currentPosition;
  String? _countryCode;

  @override
  void initState() {
    super.initState();
    _obsecureText = false;
    _getLocation();
  }

   Future<void> _getLocation() async {
  try {
    Position position = await AppController().determinePosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String? countryCode = placemark.isoCountryCode;
      if (countryCode != null) {
        String? currencyCode =
            await getCurrencyCodeFromCountryCode(countryCode);
        if (currencyCode != null) {
          // Save the currency code using SharedPreferences
          await SharedPreferencesHelper.instance.saveCurrencyCode(currencyCode);
          await SharedPreferencesHelper.instance.saveCurrencySymbol("₹");

          print('Currency Code: $currencyCode');
        } else {
          print('Currency code not found for country code: $countryCode');
        }
      } else {
        print('Country code not found.');
      }
    } else {
      print('No placemarks found.');
    }
  } catch (e) {
    print('Error getting location or currency code: $e');
  }
}



  //   Future<void> _getLocation() async {
  //   // Check if the widget is still mounted
  //   if (!mounted) return;

  //   // Check if location permission is already granted
  //   PermissionStatus permission = await Permission.location.status;
  //   if (permission != PermissionStatus.granted &&
  //       permission != PermissionStatus.denied) {
  //     try {
  //       // Request location permission
  //       permission = await Permission.location.request();
  //     } catch (e) {
  //       print("Error requesting location permission: $e");
  //       return;
  //     }
  //   }

  //   // If permission is granted, get the location
  //   if (permission == PermissionStatus.granted) {
  //     try {
  //       // Get the current position
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       if (!mounted) return;
  //       setState(() {
  //         _currentPosition = position;
  //         // Print latitude and longitude values
  //         print('Latitude: ${_currentPosition?.latitude}, Longitude: ${_currentPosition?.longitude}');
  //       });

  //       // Get the address details from latitude and longitude
  //       List<Placemark> placemarks = await placemarkFromCoordinates(
  //           _currentPosition!.latitude, _currentPosition!.longitude);
  //       if (placemarks.isNotEmpty) {
  //         Placemark placemark = placemarks.first;
  //         // Print address details
  //         print(
  //             'Address: ${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.isoCountryCode}');
  //         String? currencyCode = await getCurrencyCodeFromCountryCode(
  //             placemark.isoCountryCode.toString());

  //         await SharedPreferencesHelper.instance
  //             .saveCurrencyCode(currencyCode!);

  //         // Save the currency symbol using SharedPreferences
  //         await SharedPreferencesHelper.instance.saveCurrencySymbol("₹");
  //         print(currencyCode);
  //       }
  //     } catch (e) {
  //       print("Error getting location: $e");
  //     }
  //   } else {
  //     // Handle the case where the user denied location permission
  //     print('Location permission denied by user');
  //     // Optionally, prompt the user to check app permissions or provide instructions on enabling location services.
  //   }
  // }


  Future<String?> getCurrencyCodeFromCountryCode(String countryCode) async {
    try {
      final response = await http
          .get(Uri.parse('https://restcountries.com/v3.1/alpha/$countryCode'));
      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        final currencies = jsonResult[0]['currencies'];
        print(currencies);
        if (currencies != null && currencies.isNotEmpty) {
          // Assuming there's only one currency per country, so taking the first one
          final currencyCode = currencies.keys.first;
          return currencyCode;
        }
      }
    } catch (e) {
      print("Error fetching currency code: $e");
    }
    return null;
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
          _getLocation();
          String? toCurrency =
              await SharedPreferencesHelper.instance.readCurrencyCode();
          print(toCurrency);
          if (_formkey.currentState!.validate()) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
            LoginRequestModel loginRequestModel =
                LoginRequestModel(email: email, password: password);

            var response = await API.service.call(
                // model: LoginResponseModel(),
                endPoint: EndPoint.login,
                body: loginRequestModel.toJson());

            var map = response.map;
            var status = map['status'] as String;
            var message = map['message'] ?? 'Invalid Login Credentials';
            if (status == 'success') {
              var dataMap = map['data'][0] as Map<String, dynamic>;
              var token = dataMap['token'] as String?;

              if (token != null && token.isNotEmpty) {
                SharedPreferencesHelper.setToken(token);
                print('Stored Token - $token');
                AppController.to.fetchProfile();
                Future.delayed(
                  Duration(seconds: 0),
                  () =>
                      Get.snackbar("Login Success", 'Successfully logged in.'),
                );
              } else {
                Get.snackbar("Login Failed", 'Invalid token received.');
              }
            } else {
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

    return ProgressHUD(
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
                                        'images/met.png',
                                        fit: BoxFit.fill,
                                        width: 120.dynamic,
                                        height: 60.dynamic,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Welcome to Met.',
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
                                  // Align(
                                  //   alignment: Alignment.center,
                                  //   child: RawMaterialButton(
                                  //     onPressed: () {
                                  //       Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               SignUpScreen(),
                                  //         ),
                                  //       );
                                  //     },
                                  //     child: Text(
                                  //       'Create new account',
                                  //       style: TextStyle(
                                  //           color: Colour.appBlue,
                                  //           fontWeight: FontWeight.w400,
                                  //           fontSize: 16.0.dynamic),
                                  //     ),
                                  //   ),
                                  // ),
                                  //commnet by saranya
                                  // SafeArea(
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(
                                  //         top: 85.0, bottom: 34.0),
                                  //     child: Center(
                                  //       child: Image.asset(
                                  //         'images/poweredby.png',
                                  //         fit: BoxFit.fill,
                                  //         // width: 60.dynamic,
                                  //         // height: 60.dynamic,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
