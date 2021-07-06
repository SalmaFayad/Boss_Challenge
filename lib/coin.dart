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
const apiId='C095C839-BBBA-400D-805D-CAA434B4DB6F';
const coinAPIURL ='https://rest.coinapi.io/v1/exchangerate';
class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map <String, String> cryptoData={};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(Uri.parse(
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiId'));
      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        var lastPrice = decodedData['rate'];
        cryptoData[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request'; //an error if the request fails
      }
    }
    return cryptoData;
  }
}