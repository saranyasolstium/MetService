// LoginResponse fromJson(String str) => LoginResponse.fromJson(json.decode(str));
// String toJson(LoginResponse data) =>o json.encode(data.tJson());

class LoginResponseModel {
  LoginResponseModel({
    this.tokenType,
    this.error,
  });

  String? tokenType;

  String? error;
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        tokenType: json["token_type"],
        error: json["error"] != null ? json["error"] : "",
      );

  Map<String, dynamic> toJson() => {
        "token_type": tokenType,
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
      'email': "usipweb+1@gmail.com",
      'password': "12345678",
      // 'grant_type': 'password',
      // 'client_id': '22',
      // 'client_secret': 'XxYwnq03sDonxUXKzq5sYQQE1i9ukbxInOePXY9H',
      // 'scope': '*'
    };
    return map;
  }
}
