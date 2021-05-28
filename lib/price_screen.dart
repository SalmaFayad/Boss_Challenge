import 'package:flutter/material.dart';
import 'coin.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  //DropDownPicker for Android
  Widget androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
          });
        });
  }
   //Drop Down Picker for IOS
  Widget iosPicker() {
    List<Text> textList = [];
    for (String currency in currenciesList) {
      var textItem = Text(currency);
      textList.add(textItem);
    }
    return CupertinoPicker(
      itemExtent: 35.0,
      onSelectedItemChanged: (value) {
        setState(() {
          //selectedCurrency = value;
        });
      },
      children: textList,
    );
  }
  String bitCoinValueInUSD= '?';
  Future getData()async{
    try {
      double data = await CoinData().getCoinData();
      setState(() {
        bitCoinValueInUSD=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCurrency = $bitCoinValueInUSD USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

