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

class CoinData {
  CoinData();
  var decodedData;

  Future<dynamic> getData(String Selected) async {
    print('WE ARE INSIDE OF THE GET DATA METHOD');
    // http.Response response = await http.get(Uri.parse('https://rest.coinapi'
    //     '.io/v1/exchangerate/BTC/$selected?apikey=082D2371-492E-432A-907C'
    //     '-611B9EC00A82'));

    http.Response response = await http.get(Uri.parse('https://blockchain.info/ticker'));
    String data = response.body;

    decodedData = await jsonDecode(data);
    // costOfSelected = decodedData['rate'].toString();
    costOfSelected = decodedData['$Selected']['sell'].toString();
    // print("Here is the Time from the coin data class ${decodedData['time']}");
    // print("Here is the Time from the coin data class $costOfSelected");

    print("for the $selected the btc cost is: $costOfSelected");
    print('Get data func here: the dropdownValue now is: $dropdownValue');
  }
}

String selected = "Choose currency first";
String ?costOfSelected;

String dropdownValue = currenciesList.first;
