import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pretty_json/pretty_json.dart';

abstract class Codable {
  toJson();
  Codable fromJson(Map<String, dynamic> map);
  bool get isValid;
}

class APIResponse<T> {
  T model;
  List<T> models = [];
  http.Response responseObj;
  bool decodeAsArray;

  APIResponse(this.model, http.Response response, {bool asArray = false}) {
    decodeAsArray = asArray;
    updateResponse(response);
  }

  updateResponse(http.Response response) {
    responseObj = response;

    // print(map);
    if (decodeAsArray) {
      // var map = jsonDecode(responseObj.body);
      // print('if');
      // (map as List<dynamic>).forEach((element) {
      //   var newModel = (model as Codable).fromJson(element);
      //   if (newModel.isValid) {
      //     models.add(newModel as T);
      //   }
      // });
    } else {
      var map = jsonDecode(responseObj.body);
      print('else');
      model = (model as Codable).fromJson(map) as T;
      print('Model Loaded');
    }
  }
}

void main() async {
  // RegisterRequestModel registerRequestModel = RegisterRequestModel(
  //     firstName: 'demo',
  //     lastName: 'acc',
  //     password: '123456',
  //     email: 'demo@yopmail.com',
  //     confirmPassword: '123456',
  //     countryCode: '+91',
  //     dob: '01-01-1999',
  //     mobileNumber: '7410075100',
  //     userName: 'demouser');
  // RegisterResponseModel model;
  //
  // var response = await API.service
  //     .call(endPoint: EndPoint.login, body: registerRequestModel.toJson());
  // model = RegisterResponseModel.fromJson(jsonDecode(response.body));
  // var date = DateFormat.M().format(DateTime.now());
  // var year = DateFormat.y().format(DateTime.now());
  // print(date);
  // print(year);

  var resp = await http.get(Uri.parse('https://reqres.in/api/unknown'));
  var response = APIResponse(Resource(), resp).model;
  print('${response.data.map((e) => e.name)}');
}

class Resource implements Codable {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Support support;

  fromJson(Map<String, dynamic> json) {
    var resource = Resource();
    resource.page = json['page'];
    resource.perPage = json['per_page'];
    resource.total = json['total'];
    resource.totalPages = json['total_pages'];
    if (json['data'] != null) {
      resource.data = [];
      json['data'].forEach((v) {
        resource.data.add(new Data.fromJson(v));
      });
    }
    resource.support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
    return resource;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['total_pages'] = this.totalPages;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support.toJson();
    }
    return data;
  }

  bool get isValid => true;
}

class Data {
  int id;
  String name;
  int year;
  String color;
  String pantoneValue;

  Data({this.id, this.name, this.year, this.color, this.pantoneValue});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    color = json['color'];
    pantoneValue = json['pantone_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['color'] = this.color;
    data['pantone_value'] = this.pantoneValue;
    return data;
  }
}

class Support {
  String url;
  String text;

  Support({this.url, this.text});

  Support.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['text'] = this.text;
    return data;
  }
}

// class Post implements Codable {
//   int userId;
//   int id;
//   String title;
//   String body;
//
//   Post fromJson(Map<String, dynamic> json) {
//     var post = Post();
//     post.userId = json['userId'];
//     post.id = json['id'];
//     post.title = json['title'];
//     post.body = json['body'];
//     return post;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['body'] = this.body;
//     return data;
//   }
//
//   bool get isValid => true;
// }
