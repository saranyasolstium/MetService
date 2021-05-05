import 'dart:convert';
import 'dart:io';

import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'urls.dart';

class APIService {
  static final shared = APIService();

  // Future login(LoginRequestModel requestModel) async {
  //   Uri url = Uri.parse('https://pixel.solstium.net/oauth/token');
  //   try {
  //     // final http.Response response =
  //     //     await http.post(url, body: requestModel.toJson(), headers: header);
  //     // print('Login response');
  //     // if (response.statusCode == 200 || response.statusCode == 400) {
  //     //   String data = response.body;
  //     //   print(data);
  //     //   return LoginResponseModel.fromJson(
  //     //     jsonDecode(data),
  //     //   );
  //     // } else {
  //     //   print(response.statusCode);
  //     // }
  //   } catch (error) {
  //     print('Failed to load data!$error');
  //   }
  // }
}

class API {
  void some(EndPoint url) {
    some(EndPoint.profile);
  }

  //Request Parameters
  /*
  1. Url - Completed.
  2. header - Completed.
  3. parameter or body
  4. encoding - safe to send data
  5. Methods - get, post, delete, Multipart
  6. Generic
  7. Exeception Handling

   */

  final APIRouter route = APIRouter();

  static final service = API();
  Future<http.Response> call({
    @required EndPoint endPoint,
    Map<dynamic, dynamic> body,
    Map<String, String> header,
  }) async {
    final String url = route.url(endPoint.string);
    final Map<String, String> safeHeader = header ??= endPoint.header;
    print('url $url');
    print('header $header');
    print('body $body');
    print('method ${endPoint.method}');
    if (endPoint.method == HTTPMethod.post) {
      var resp =
          await http.post(Uri.parse(url), headers: safeHeader, body: body);
      print("response - ${resp.body.toString()}");
      return resp;
    } else {
      final Map<String, String> queryParam = body;
      final Uri uri = Uri.parse(url);
      var resp = await http.get(uri, headers: safeHeader);

      print("response - ${resp.body.toString()}");
      return resp;
    }
  }
}

bool success(String status) {
  if (status == 'success') {
    return true;
  } else {
    return false;
  }
}

extension StatusExtension on String {
  bool get isSuccess {
    if (this == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
