import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._privateConstructor();

  static final SharedPreferencesHelper instance =
      SharedPreferencesHelper._privateConstructor();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

 static Future<String?> getFCMToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  static Future<void> setFCMToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


  Future<void> saveCurrencyCode(String currencyCode) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('currencyCode', currencyCode);
  }

  Future<String?> readCurrencyCode() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('currencyCode');
  }

  Future<void> saveCurrencySymbol(String currencySymbol) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('currencySymbol', currencySymbol);
  }

  Future<String?> readCurrencySymbol() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('currencySymbol');
  }

}
