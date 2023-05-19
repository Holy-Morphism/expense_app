import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deletTx;
  const TransactionList(this._userTransactions, this._deletTx);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (context, constraits) {
            return Container(
              height: constraits.maxHeight,
              child: Image.asset(
                'assets/images/lovehashira.png',
                fit: BoxFit.contain,
              ),
            );
          })
        : Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    key: key,
                    userTransactions: _userTransactions[index],
                    deletTx: _deletTx);
              },
              itemCount: _userTransactions.length,
            ),
          );
  }
}
