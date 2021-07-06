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
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          print(selectedIndex);
          selectedCurrency = currenciesList[selectedIndex];
        });
      },
      children: textList,
    );
  }

  //create a map to hold coin values from api
  Map<String, String> coinValues = {};
  // is waiting check if the request has complete or not ,initially not
  bool isWaiting = false;
  Future getData() async {
    try {
      isWaiting = true; //start
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false; //end
      setState(() {
        coinValues = data;
      });
    } catch (e) {
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
          CryptoCard(
            value: isWaiting ? '?' : coinValues['BTC'],
            selectedCurrency: selectedCurrency,
            cryptoSelected: 'BTC',
          ),
          CryptoCard(
              value: isWaiting ? '?' : coinValues['ETH'],
              selectedCurrency: selectedCurrency,
              cryptoSelected: 'ETH'),
          CryptoCard(
              value: isWaiting ? '?' : coinValues['LTC'],
              selectedCurrency: selectedCurrency,
              cryptoSelected: 'LTC'),
          Container(
            alignment: Alignment.center,
            height: 150,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Platform.isIOS ? iosPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.value,
    @required this.selectedCurrency,
    @required this.cryptoSelected,
  }) : super(key: key);

  final String value;
  final String selectedCurrency;
  final String cryptoSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoSelected= $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
