import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL ='https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1BEB0849-FBCC-42A1-9F6F-FFA47BB90437';

class CoinData {
  Future<Map<String,String>> getCoinData(String selectedCurrency) async{
    Map<String,String> cryptoPrices = {};

    for(String crypto in cryptoList) {
      Uri requestURl = Uri.https(
        'rest.coinapi.io',
        '/v1/exchangerate/$crypto/$selectedCurrency',
        {'apikey': apiKey},
      );
      await Future.delayed(Duration(seconds: 1));
      http.Response response = await http.get(requestURl);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}