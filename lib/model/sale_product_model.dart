import '../api/api_service.dart';
import 'abstract_class.dart';

class MSaleProductResponse implements Codable {
  String? status;
  String? message;
  late List<MOppointment> data;

  MSaleProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List<MOppointment>.from((json['data'] ?? []).map((x) => MOppointment.fromJson(x)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.map((x) => x.toJson()).toList();
    return data;
  }

  bool get isValid => data.isNotEmpty;

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return MSaleProductResponse.fromJson(json);
  }
}

class MOppointment {
  late int id;
  String? address;
  String? bookingDate;

  MOppointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    bookingDate = json['bookingdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['address'] = address;
    data['bookingdate'] = bookingDate;
    return data;
  }
}


