import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deletTx;
  TransactionList(this._userTransactions, this._deletTx);
  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Container(child: Image.asset('assets/images/lovehashira.png'))
        : Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child:
                                Text('\$${_userTransactions[index].amount}')),
                      ),
                      radius: 30,
                    ),
                    title: Text(_userTransactions[index].title,
                        style: Theme.of(ctx).textTheme.bodyLarge),
                    subtitle: Text(DateFormat.yMMMMEEEEd()
                        .format(_userTransactions[index].date)),
                    trailing: IconButton(
                      onPressed: () => _deletTx(_userTransactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(ctx).colorScheme.error,
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
          );
  }
}
