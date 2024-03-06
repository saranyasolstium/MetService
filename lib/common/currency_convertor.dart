import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyConversionService {
  static final CurrencyConversionService _instance = CurrencyConversionService._internal();

  factory CurrencyConversionService() {
    return _instance;
  }

  CurrencyConversionService._internal();

  Future<double> convertAmount(double amount, String fromCurrency, String toCurrency) async {
    try {
      const apiKey = '6ad17a10442becefdadff26e';
      final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$fromCurrency',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final rate = jsonResponse['conversion_rates'][toCurrency];
        if (rate is double) {
          return amount * rate;
        } else {
          throw Exception('Invalid rate type');
        }
      } else {
        throw Exception('Failed to load exchange rate');
      }
    } catch (e) {
      throw Exception('Error fetching exchange rate: $e');
    }
  }
}
