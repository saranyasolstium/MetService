import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/methods.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'urls.dart';
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

abstract class Codable {
  toJson();
  Codable fromJson(Map<String, dynamic> map);
  bool get isValid;
  String status;
}

class API {
  final APIRouter route = APIRouter();
  static final service = API();

  Future<APIResponse<T>> call<T>({
    T model,
    @required EndPoint endPoint,
    Map<dynamic, dynamic> body,
    Map<String, String> header,
    // Map<String, String> query,
    bool needLoader = true,
  }) async {
    final String url = route.url(endPoint.string);
    final Map<String, String> safeHeader = header ??= endPoint.header;
    http.Response response;

    print('url $url');
    print('header $header');
    print('body $body');
    print('method ${endPoint.method}');

    try {
      showLoading();
      if (endPoint.method == HTTPMethod.post) {
        response =
            await http.post(Uri.parse(url), headers: safeHeader, body: body);
      } else {
        final String getParam = queryParam(body);
        print('Query param - $getParam');
        final Uri uri = Uri.parse('$url?$getParam');
        response = await http.get(uri, headers: safeHeader);
      }
    } finally {
      hideLoading();
    }

    print("response - ${response.body.toString()}");
    return APIResponse(model, response);
  }

  String queryParam(Map<String, String> query) {
    if (query == null) {
      return '';
    }
    var initial = '';
    query.forEach((key, value) {
      initial = '$initial&$key=$value';
    });

    return initial.substring(1);
  }
}

class APIResponse<T> {
  T _model;
  T get model {
    return models[0];
  }

  Map<dynamic, dynamic> get map {
    return _maps[0];
  }

  http.Response responseObj;
  List<dynamic> _maps = [];
  List<T> models = [];
  // bool get isSuccess {
  //   if (this == 'success') {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  APIResponse(this._model, http.Response response) {
    // _model = object;
    updateResponse(response);
  }

  updateResponse(http.Response response) {
    try {
      responseObj = response;
      var decoded = jsonDecode(responseObj.body);
      if (decoded != null) {
        if (decoded is List<dynamic>) {
          _maps = decoded;
        } else {
          _maps = [decoded];
          // models = [(_model as Codable).fromJson(map) as T];
        }

        if (_model != null) {
          (_maps).forEach((element) {
            var newModel = (_model as Codable).fromJson(element);
            if (newModel.isValid) {
              models.add(newModel as T);
            }
          });
        }
      }
    } on SocketException {
      print('No internet connection');
    } catch (error) {
      print('Error in service');
    } finally {
      if (models.length == 0) {
        models = [_model];
        if (_maps.length == 0) {
          _maps = [{}];
        }
      }
    }
  }
}

extension StringStatus on String {
  bool get isSuccess {
    if (this == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
