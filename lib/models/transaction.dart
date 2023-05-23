import 'package:flutter/material.dart';

class Transaction {
  final String id, title;
  final double amount;
  final DateTime date;
  final Color color;
  const Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.color});
}
