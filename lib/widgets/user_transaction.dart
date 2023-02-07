import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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
  Widget _addNewTransaction(String title, double amount) {
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
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
