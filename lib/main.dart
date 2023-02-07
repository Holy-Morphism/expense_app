import 'package:expense/widgets/new_transaction.dart';
import 'package:expense/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import './widgets/user_transaction.dart';
import './models/transaction.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
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

  void _addNewTransaction(String title, double amount) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context, _addNewTransaction),
      ),
    );
  }
}

void _showDialog(BuildContext context, Function func) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: NewTransaction(func, () => Navigator.pop(context)),
        );
      });
}
