// lib/utils/currency_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

/// CurrencyHelper
/// - call getCurrencyCodeFromCountry(countryString) to map a country/ISO -> currency code
/// - call convert(amount, fromCurrency, toCurrency) to convert the amount
class CurrencyHelper {
    // Your ExchangeRate-API key
    static const String _apiKey = "d86f7486a27d680d08ff8f13"; // replace with your key

    /// Convert [amount] from [fromCurrency] -> [toCurrency]
    /// Returns 0.0 on failure.
    static Future<double> convert(double amount, String fromCurrency, String toCurrency) async {
        if (amount == 0) return 0.0;

        final from = fromCurrency.trim().toUpperCase();
        final to = toCurrency.trim().toUpperCase();

        if (from == to) return double.parse(amount.toStringAsFixed(2));

        try {
            // Use ExchangeRate-API pair endpoint
            final url = Uri.parse('https://v6.exchangerate-api.com/v6/$_apiKey/pair/$from/$to/$amount');
            final res = await http.get(url).timeout(const Duration(seconds: 5));

            if (res.statusCode == 200) {
                final data = json.decode(res.body);
                if (data['result'] == 'success') {
                    final double result = (data['conversion_result'] as num).toDouble();
                    return double.parse(result.toStringAsFixed(2));
                }
            }

            return 0.0;
        } catch (e) {
            print('CurrencyHelper.convert error: $e');
            return 0.0;
        }
    }

    /// Map from user-provided country name or ISO code to a 3-letter currency code.
    /// Accepts:
    ///  - full country name ("United Kingdom"), case-insensitive
    ///  - ISO-2 code ("GB", "UK", "US")
    ///  - or already a currency code ("GBP", "USD") -> returned as-is
    static String getCurrencyCodeFromCountry(String countryOrCode) {
        if (countryOrCode == null) return 'USD';
        final raw = countryOrCode.trim();
        if (raw.isEmpty) return 'USD';
        final up = raw.toUpperCase();

        // if looks like currency code (3 letters) and in known set, return
        if (_knownCurrencyCodes.contains(up)) return up;

        // if looks like ISO-2 code (2 letters)
        if (up.length == 2 && _countryCode2ToCurrency.containsKey(up)) {
            return _countryCode2ToCurrency[up]!;
        }

        // normalize name
        final nameKey = up.replaceAll(RegExp(r'\s+'), ' ').trim();
        if (_countryNameToCurrency.containsKey(nameKey)) {
            return _countryNameToCurrency[nameKey]!;
        }

        // alias lookup
        if (_aliases.containsKey(nameKey)) {
            return _aliases[nameKey]!;
        }

        // fallback
        return 'USD';
    }

    // Minimal but practical currency code set
    static const Set<String> _knownCurrencyCodes = {
        'USD','NGN','GHS','KES','ZAR','INR','PKR','BDT','IDR','PHP','EGP','SAR','AED',
        'GBP','EUR','BRL','MXN','CAD','AUD','NZD','CNY','JPY','KRW','TRY','RUB','UAH',
    };

    // ISO-2 country code -> currency code
    static const Map<String, String> _countryCode2ToCurrency = {
        'NG': 'NGN', 'GH': 'GHS', 'KE': 'KES', 'ZA': 'ZAR', 'EG': 'EGP', 'MA': 'MAD',
        'DZ': 'DZD', 'TN': 'TND', 'ET': 'ETB', 'UG': 'UGX', 'TZ': 'TZS',
        'US': 'USD', 'CA': 'CAD', 'MX': 'MXN', 'BR': 'BRL', 'AR': 'ARS', 'CL': 'CLP',
        'CO': 'COP', 'PE': 'PEN', 'GB': 'GBP', 'UK': 'GBP', 'DE': 'EUR', 'FR': 'EUR',
        'ES': 'EUR', 'IT': 'EUR', 'NL': 'EUR', 'BE': 'EUR', 'TR': 'TRY', 'RU': 'RUB',
        'UA': 'UAH', 'SA': 'SAR', 'AE': 'AED', 'IN': 'INR', 'PK': 'PKR', 'BD': 'BDT',
        'ID': 'IDR', 'PH': 'PHP', 'CN': 'CNY', 'JP': 'JPY', 'KR': 'KRW', 'AU': 'AUD',
        'NZ': 'NZD',
    };

    // Country name -> currency code
    static final Map<String, String> _countryNameToCurrency = {
        'NIGERIA':'NGN', 'GHANA':'GHS', 'KENYA':'KES', 'SOUTH AFRICA':'ZAR',
        'EGYPT':'EGP', 'MOROCCO':'MAD', 'UNITED STATES':'USD','USA':'USD',
        'CANADA':'CAD','MEXICO':'MXN','BRAZIL':'BRL','ARGENTINA':'ARS','CHILE':'CLP',
        'COLOMBIA':'COP','PERU':'PEN','UNITED KINGDOM':'GBP','UK':'GBP','ENGLAND':'GBP',
        'GERMANY':'EUR','FRANCE':'EUR','SPAIN':'EUR','ITALY':'EUR','NETHERLANDS':'EUR',
        'TURKEY':'TRY','RUSSIA':'RUB','UKRAINE':'UAH','SAUDI ARABIA':'SAR',
        'UNITED ARAB EMIRATES':'AED','UAE':'AED','INDIA':'INR','PAKISTAN':'PKR',
        'BANGLADESH':'BDT','INDONESIA':'IDR','PHILIPPINES':'PHP','CHINA':'CNY',
        'JAPAN':'JPY','SOUTH KOREA':'KRW','AUSTRALIA':'AUD','NEW ZEALAND':'NZD',
    };

    static final Map<String, String> _aliases = {
        'NIG':'NGN','NGA':'NGN',
    };
}
