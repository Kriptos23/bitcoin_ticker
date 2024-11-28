import 'package:http/http.dart' as http;

import 'dart:convert';

const List<String> currenciesList = [
  'aud',
  'brl',
  'cad',
  'cny',
  'eur',
  'gbp',
  'hkd',
  'idr',
  'ild',
  'inr',
  'jpy',
  'mxn',
  'nok',
  'nzd',
  'pln',
  'ron',
  'rub',
  'sek',
  'sgd',
  'usd',
  'zar'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'DOGE',
  // 'LTC':,
];

class CoinData {
  CoinData();
  var decodedData;

  Future<dynamic> getData(String Selected) async {
    print('WE ARE INSIDE OF THE GET DATA METHOD');
    // http.Response response = await http.get(Uri.parse('https://rest.coinapi'
    //     '.io/v1/exchangerate/BTC/$selected?apikey=082D2371-492E-432A-907C'
    //     '-611B9EC00A82'));this useless coinAPI is not longer working for me

    http.Response response = await http.get(Uri.parse('https://api.coingecko.com'
        '/api/v3/simple/price?ids=bitcoin,ethereum,dogecoin&vs_currencies=$Selected'));
    String data = response.body;

    decodedData = await jsonDecode(data);
    // costOfSelected = decodedData['rate'].toString();

    // Bitcoin = decodedData[Selected]['sell'].toString();//This is for the "https://blockchain.info/ticker"

    Bitcoin = (decodedData['bitcoin'][Selected]).toString();
    Ethereum = decodedData['ethereum'][Selected].toString();
    Dogecoin = decodedData['dogecoin'][Selected].toString();

    print("for the $Selected the btc cost is: $Bitcoin");
  }
}

String selected = "\$";
String Bitcoin = "?";
String Ethereum = "?";
String Dogecoin = "?";

