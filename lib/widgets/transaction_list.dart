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
            child: ListView(
              children: _userTransactions
                  .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      userTransactions: tx,
                      deletTx: _deletTx))
                  .toList(),
            ),
            // child: ListView.custom(
            //   childrenDelegate: SliverChildBuilderDelegate(
            //     (context, index) {
            //       return TransactionItem(
            //           key: ValueKey(_userTransactions[index].id),
            //           userTransactions: _userTransactions[index],
            //           deletTx: _deletTx);
            //     },
            //     childCount: _userTransactions.length,
            //   ),
            // ),
          );
  }
}
