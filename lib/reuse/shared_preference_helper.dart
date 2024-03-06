import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._privateConstructor();

  static final SharedPreferencesHelper instance =
      SharedPreferencesHelper._privateConstructor();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
