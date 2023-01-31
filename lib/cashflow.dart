import 'package:flutter/material.dart';

class CashFlow extends StatelessWidget {
  final String id, title;
  final double amount;
  final DateTime date;
  const CashFlow({
    this.id,
    @required this.title,
    this.amount,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontFamily: 'SofiaSansCondensed',
      ),
    ));
  }
}
