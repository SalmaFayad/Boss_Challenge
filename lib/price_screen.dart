import 'package:flutter/material.dart';
class PriceScreen extends StatelessWidget {
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
                padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 28.0),
                child: Text('1 BTC = ? USD',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150,
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.only(bottom: 30.0),
            child: null,
          ),
        ],
      ),
    );
  }
}
