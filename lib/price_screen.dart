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
            getDataInBTC();
            getDataInETH();
            getDataInLTC();
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
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
         print(selectedIndex);
         selectedCurrency=currenciesList[selectedIndex];
         getDataInBTC();
         getDataInETH();
         getDataInLTC();
        });
      },
      children: textList,
    );
  }
  String bitCoinInBTC= '?';
  String bitCoinInETH= '?';
  String bitCoinInLTC= '?';
  Future getDataInBTC()async{
    try {
      double data = await CoinData().getCoinBTCData(selectedCurrency);
      setState(() {
        bitCoinInBTC=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  Future getDataInETH()async{
    try {
      double data = await CoinData().getCoinETHData(selectedCurrency);
      setState(() {
        bitCoinInETH=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  Future getDataInLTC()async{
    try {
      double data = await CoinData().getCoinLTC(selectedCurrency);
      setState(() {
        bitCoinInLTC=data.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataInBTC();
    getDataInETH();
    getDataInLTC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18 ,left: 18,right: 18),
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
                  '1 BTC= $bitCoinInBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
          padding: const EdgeInsets.only(top: 18 ,left: 18,right: 18),
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
                  '1 ETH= $bitCoinInETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 LTC= $bitCoinInLTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Container(
              alignment: Alignment.center,
              height: 150,
              color: Colors.lightBlueAccent,
              padding: EdgeInsets.only(bottom: 30.0),
              child: Platform.isIOS? iosPicker() : androidDropDown(),
            ),
          ),
        ],
      ),
    );
  }
}

