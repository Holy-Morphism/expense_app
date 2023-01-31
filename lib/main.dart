import 'package:flutter/material.dart';

import './transaction.dart';
import './cashflow.dart';

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
  final List<Transaction> transactions = [
    Transaction(
      id: '12345',
      title: 'chai',
      amount: 50,
      date: DateTime.now(),
    ),
    Transaction(
      id: '12346',
      title: 'Lays',
      amount: 60,
      date: DateTime.now(),
    ),
    Transaction(
      id: '12347',
      title: 'Mango Juice',
      amount: 30,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: transactions
                .map((transaction) => CashFlow(title: transaction.title))
                .toList()));
  }
}
