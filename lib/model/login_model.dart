// LoginResponse fromJson(String str) => LoginResponse.fromJson(json.decode(str));
// String toJson(LoginResponse data) =>o json.encode(data.tJson());

class LoginResponseModel {
  LoginResponseModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
    this.refreshToken,
    this.error,
  });

  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;
  String? error;
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        error: json["error"] != null ? json["error"] : "",
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
        "expires_in": expiresIn,
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}

class LoginRequestModel {
  String? email;
  String? password;

  // ignore: non_constant_identifier_names
  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': email!.trim(),
      'password': password!.trim(),
      'grant_type': 'password',
      'client_id': '6',
      'client_secret': 'XHZgV3oFMGAZOzYEG9e9EqWE7OTWECS2MICTjoGX',
      'scope': ''
    };
    return map;
  }
}
