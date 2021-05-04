import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/login_model.dart';

void main() async {
  LoginRequestModel loginRequestModel =
      LoginRequestModel(email: 'kishore@yopmail.com', password: '1234567');
  var model = await APIService.shared.login(loginRequestModel);
  print(model.accessToken);
}
