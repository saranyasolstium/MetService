import 'package:eagle_pixels/api/api_service.dart';

class MSiteResponse extends Codable {
  String? status;
  String? message;
  List<MSite>? data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MSite>[];
      json['data'].forEach((v) {
        data?.add(MSite.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isValid => (data!.length > 0);
}

class MSite {
  int? id;
  int? clientId;
  int? location;
  int? sublocation;
  String? name;
  String? address1;
  Null address2;
  String? country;
  String? state;
  String? city;
  String? zipCode;
  String? status;
  String? createdAt;
  Null updatedAt;
  int? siteID;
  String? siteName;

  String get displayText {
    return '${siteName ?? ''} - ${siteID ?? ''}';
  }

  MSite(
      {this.id,
      this.clientId,
      this.location,
      this.sublocation,
      this.name,
      this.address1,
      this.address2,
      this.country,
      this.state,
      this.city,
      this.zipCode,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.siteID,
      this.siteName});

  MSite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    location = json['location'];
    sublocation = json['sublocation'];
    name = json['name'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipCode = json['zip_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    siteID = json['SiteID'];
    siteName = json['SiteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['location'] = this.location;
    data['sublocation'] = this.sublocation;
    data['name'] = this.name;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['SiteID'] = this.siteID;
    data['SiteName'] = this.siteName;
    return data;
  }
}
