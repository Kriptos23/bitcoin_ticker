import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'coin_data.dart';
import 'dart:io' show Platform; //using to check what operating system is the
// app is running, android, ios or web or any other
import 'package:flutter/foundation.dart'; //to check if we are running on web
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownValue = currenciesList.first;

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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $costOfSelected $selected',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
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

  Future<dynamic> getData(String Selected) async {
    Response response = await http.get(Uri.parse('https://rest.coinapi'
        '.io/v1/exchangerate/BTC/$selected?apikey=082D2371-492E-432A-907C'
        '-611B9EC00A82'
        ''));
    String data = response.body;
    setState(() {
      var decodedData = jsonDecode(data);
      costOfSelected = decodedData['rate'].toString();
      print(decodedData['time']);
    });
    print("for the $selected the btc cost is: $costOfSelected");
    print('Get data func here: the dropdownValue now is: $dropdownValue');
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

  Widget IOS_Picker() {
    //https://rest.coinapi.io/v1/exchangerate/:USD/:BTC

    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedPicker) {
          // print('selected: $selectedPicker');
          selected = currenciesList[selectedPicker];
          // print(selected);
          setState(() {
            getData(selected);
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
        style: const TextStyle(
            color: Colors.black, textBaseline: TextBaseline.alphabetic),
        dropdownColor: Colors.white,
        alignment: AlignmentDirectional.center,
        items: currenciesList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          print('The selected one from the Android Picker is the $value');
          setState(() {
            dropdownValue = value!;
            print('Dropdown value is: $dropdownValue');
            selected = value;
            getData(value);
          });
        });
  }
}
