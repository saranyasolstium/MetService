import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/methods.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:http/http.dart' as http;
import 'urls.dart';

abstract class Codable {
  toJson();
  Codable fromJson(Map<String, dynamic> map);
  bool get isValid;
  String? status;
}

class API {
  final APIRouter route = APIRouter();
  static final service = API();

  Future<APIResponse<T?>> call<T>({
    T? model,
    required EndPoint endPoint,
    Map<dynamic, dynamic>? body,
    Map<String, String>? header,
    // Map<String, String> query,
    bool needLoader = true,
  }) async {
    final String url = route.url(endPoint.string);
    final Map<String, String> safeHeader = header ??= endPoint.header;
    http.Response? response;

    print('url $url');
    print('header $header');
    print('body $body');
    print('method ${endPoint.method}');

    try {
      if (needLoader) {
        showLoading();
      }

      if (endPoint.method == HTTPMethod.post) {
        response = await http
            .post(Uri.parse(url), headers: safeHeader, body: body)
            .timeout(Duration(seconds: 60));
      } else {
        final String getParam = queryParam(body);
        print('Query param - $getParam');
        final Uri uri = Uri.parse('$url?$getParam');
        response = await http
            .get(uri, headers: safeHeader)
            .timeout(Duration(seconds: 60));
      }
    } on TimeoutException catch (_) {} finally {
      if (needLoader) {
        hideLoading();
      }
    }
    if (response != null) {
      print("response - ${(response.body)}");
    } else {
      print("response - Empty");
    }

    return APIResponse(model, response: response, isNeedModel: (model != null));
  }

  String queryParam(Map<dynamic, dynamic>? query) {
    if (query == null) {
      return '';
    }
    var initial = '';
    query.forEach((key, value) {
      initial = '$initial&${key.toString()}=${value.toString()}';
    });

    return initial.substring(1);
  }
}

class APIResponse<T> {
  final T _model;
  final bool isNeedModel;
  T get model {
    return models[0];
  }

  bool get isValidModel {
    return (model as Codable).isValid;
  }

  Map<dynamic, dynamic> get map {
    return _maps[0];
  }

  http.Response? responseObj;
  List<dynamic> _maps = [];
  List<T> models = [];
  // bool get isSuccess {
  //   if (this == 'success') {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  APIResponse(this._model,
      {required http.Response? response, this.isNeedModel = false}) {
    // _model = object;
    updateResponse(response);
  }

  updateResponse(http.Response? response) {
    try {
      responseObj = response;
      var decoded = jsonDecode(responseObj!.body);
      if (decoded != null) {
        if (decoded is List<dynamic>) {
          _maps = decoded;
        } else {
          _maps = [decoded];
          // models = [(_model as Codable).fromJson(map) as T];
        }
        if (!isNeedModel) {
          return;
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
      print('Error in service $error');
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

extension StringStatus on String? {
  bool get isSuccess {
    if (this == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
