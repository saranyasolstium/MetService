import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/methods.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'urls.dart';
import 'package:pretty_json/pretty_json.dart';

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
    Map<String, String> safeHeader = header ?? await endPoint.header;
    http.Response? response;
    String? error;

    // print('header $header');

    try {
      if (needLoader) {
        showLoading();
      }

      if (endPoint.method == HTTPMethod.post) {
        if (endPoint.paramType == ParamType.raw) {
          var convertedBody;
          convertedBody = jsonEncode(body);
          print('$convertedBody Json Encode');
          response = await http
              .post(
                Uri.parse(url),
                headers: safeHeader,
                body: convertedBody,
              )
              .timeout(Duration(seconds: 60));
        } else {
          Map<String, String> convertedBody = {};
          body?.forEach((key, value) {
            convertedBody['$key'] = '$value';
          });
          response = await http
              .post(Uri.parse(url), headers: safeHeader, body: convertedBody)
              .timeout(Duration(seconds: 60));
        }
      } else {
        final String getParam = queryParam(body);
        final Uri uri = Uri.parse('$url?$getParam');
        response = await http
            .get(uri, headers: safeHeader)
            .timeout(Duration(seconds: 60));
      }
    } on SocketException catch (networkError) {
      error = networkError.message;
    } on TimeoutException catch (timeOutError) {
      error = timeOutError.message;
      // print(timeOutError.message);
    } catch (otherErrors) {
      print('${otherErrors.toString()}');
      error = "Something went wrong. Please try again";
    } finally {
      print('url -> ${endPoint.method.string} $url');
      print('Header -> ${endPoint.toString()}');
      print('body ->');
      print(body);

      if (needLoader) {
        hideLoading();
      }

      // if (response != null) {
      //   print(
      //       "response - ${(JsonEncoder.withIndent(' ').convert(response.body))}");
      // } else {
      //   print("response - Empty");
      // }
      // ignore: control_flow_in_finally
      return APIResponse(model,
          response: response,
          error: error,
          isNeedModel: (model != null),
          endPoint: endPoint);
    }
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
    return (model as Codable).isValid && error == null;
  }

  Map<dynamic, dynamic> get map {
    return _maps[0];
  }

  http.Response? responseObj;
  List<dynamic> _maps = [];
  List<T> models = [];
  String? error;

  bool get isSuccess {
    if (map[K.status] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  String? get message {
    return map['message'].toString();
  }

  APIResponse(this._model,
      {required http.Response? response,
      this.error,
      this.isNeedModel = false,
      required EndPoint endPoint}) {
    // _model = object;
    updateResponse(response, endPoint);
  }

  updateResponse(http.Response? response, EndPoint endPoint) {
    try {
      print(endPoint.toString());

      if (endPoint == EndPoint.profile ||
          endPoint == EndPoint.getCustomerProductItemList ||
          endPoint == EndPoint.scheduled_job_list) {
        print(response!.statusCode);
        if (response.statusCode == 401) {
          print('logout');
          Get.offAllNamed(NavPage.root);
          AppController.to.storage.remove('token');
          AppController.to.loginStatus.value = LoginStatus.logout;
        }
      }

      if (error != null) {
        print('response - Empty');
        throw Exception(error!);
      }
      responseObj = response;

      var decoded = jsonDecode(responseObj!.body);

      if (decoded != null) {
        print('response ->');
        printPrettyJson(decoded, indent: 2);
        if (decoded is List<dynamic>) {
          _maps = decoded;
        } else {
          _maps = [decoded];
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
        // print('model created');
      } else {
        print('response - Empty');
      }
    } catch (err) {
      error = err.toString();
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

bool isSuccess(dynamic? status) {
  if (status == null) {
    return false;
  } else {
    String stringValue = status.toString();
    if (stringValue == K.success) {
      return true;
    } else {
      return false;
    }
  }
}
