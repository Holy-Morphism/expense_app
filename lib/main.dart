import 'package:flutter/material.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images\\tanjiro.jpeg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Text(
                  'CHART!',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'SofiaSansCondensed',
                  ),
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              ),
            ),
          ],
        ));
  }
}
