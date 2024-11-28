import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; //using to check what operating system is the
// app is running, android, ios or web or any other
import 'package:flutter/foundation.dart'; //to check if we are running on web
import 'Utilities/style.dart';
import 'Utilities/Containers.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = currenciesList.first;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    coinData.getData(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CurrencyContainer(cryptoList2: cryptoList, num: 0, crypto: Bitcoin),
          CurrencyContainer(cryptoList2: cryptoList, num: 1, crypto: Ethereum,),
          CurrencyContainer(cryptoList2: cryptoList, num: 2, crypto: Dogecoin,),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: Picker(),
          ),
          Text('the picked one is now: $selected or $dropdownValue: ',
              style: const TextStyle(color: Colors.red)),
          // FloatingActionButton(onPressed: (){
          //   setState(() {
          //     getData();
          //
          //   });
          // })
        ],
      ),
    );
  }

  ///////////////////////////////FUNCTIONS/////////////////////////////////////
  List<Widget> makeWidgetListFromStringList(List<String> list) {
    List<Widget> widgets = [];
    for (String element in list) {
      widgets.add(Text(element));
    }
    return widgets;
  }

  //Return a picker widget based on what operation system is running
  Widget Picker() {
    if (kIsWeb) {
      // return IOS_Picker();
      return And_Picker(dropdownValue);
      //for some reason we should check if we are
      // running
      // on web before any other platform
    } else if (Platform.isAndroid) {
      // return And_Picker(dropdownValue);
      return IOS_Picker();
    } else if (Platform.isIOS) {
      return IOS_Picker();
    } else {
      return And_Picker(dropdownValue);
    }
  }

  CoinData coinData = CoinData();


  Widget IOS_Picker() {
    //https://rest.coinapi.io/v1/exchangerate/:USD/:BTC
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedPicker) {
          // print('selected: $selectedPicker');
          selected = currenciesList[selectedPicker];
          // print(selected);
          setState(() async {
            await coinData.getData(selected);
            // costOfSelected = coinData.decodedData['rate'].toString();
          });
          // setState(() async {
          //   responce = await http.get('$url' as Uri);
          //   String a = jsonDecode(responce);
          //   print('$a');
          // });
        },
        children: makeWidgetListFromStringList(currenciesList));
  }

  Widget And_Picker(String droppedValue) {
    return DropdownButton<String>(
        value: droppedValue,
        style: AndPickerStyle,
        dropdownColor: Colors.lightBlueAccent,
        alignment: AlignmentDirectional.center,
        items: currenciesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) async {
          // This is called when the user selects an item.
          await coinData.getData(value!);
          setState(() {
            dropdownValue = value!;
            selected = value;
          });
        });
  }
}
