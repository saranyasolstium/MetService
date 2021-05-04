import 'dart:convert';
import 'dart:io';

import 'package:eagle_pixels/api/methods.dart';
import 'package:eagle_pixels/model/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'urls.dart';

class APIService {
  static final shared = APIService();
  static Map<String, String> headers() {
    Map<String, String> map = {
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': ''
    };
    return map;
  }

  Future login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse('https://pixel.solstium.net/oauth/token');
    try {
      final http.Response response =
          await http.post(url, body: requestModel.toJson(), headers: headers());
      print('Login response');
      if (response.statusCode == 200 || response.statusCode == 400) {
        String data = response.body;
        print(data);
        return LoginResponseModel.fromJson(
          jsonDecode(data),
        );
      } else {
        print(response.statusCode);
      }
    } catch (error) {
      print('Failed to load data!$error');
    }
  }
}

class API {
  void some(EndPoint url) {
    some(EndPoint.profile);
  }

  //Request Parameters
  /*
  1. Url - Completed.
  2. header -
  3. parameter or body
  4. encoding - safe to send data
  5. Methods - get, post, delete, Multipart
  6. Generic
  7. Exeception Handling

   */

  final APIRouter route = APIRouter();
  Map<String, String> get defaultHeader {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
    };
  }

  static final service = API();
  Future<http.Response> call({
    @required EndPoint endPoint,
    Map<dynamic, dynamic> body,
    Map<String, String> header,
  }) async {
    final String url = route.url(endPoint.string);
    final Map<String, String> safeHeader = header ??= defaultHeader;
    if (endPoint.method == HTTPMethod.post) {
      return await http.post(Uri.https(url, ""),
          headers: safeHeader, body: body);
    } else {
      final Map<String, String> queryParam = body;
      final Uri uri = Uri.https(url, "", queryParam);
      return await http.get(uri, headers: safeHeader);
    }
  }
}
