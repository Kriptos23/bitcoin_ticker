import 'package:bitcoin_ticker/Utilities/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../coin_data.dart';

class CurrencyContainer extends StatelessWidget {
  List<String>? cryptoList2;
  String? crypto;
  int ?num;

  CurrencyContainer({this.cryptoList2, this.num, this.crypto, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${cryptoList2?.elementAt(num!)} =  ${crypto}'
                '$selected',
            textAlign: TextAlign.center,
            style: Currencies,
          ),
        ),
      ),
    );
  }
}
