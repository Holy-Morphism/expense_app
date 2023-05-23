import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required Key key,
    required Transaction userTransactions,
    required Function deletTx,
  })  : _userTransactions = userTransactions,
        _deletTx = deletTx,
        super(key: key);

  final Transaction _userTransactions;
  final Function _deletTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _userTransactions.color,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text('\$${_userTransactions.amount}')),
          ),
          radius: 30,
        ),
        title: Text(_userTransactions.title,
            style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(DateFormat.yMMMMEEEEd().format(_userTransactions.date)),
        trailing: MediaQuery.of(context).size.width > 420
            ? TextButton.icon(
                onPressed: () => _deletTx(_userTransactions.id),
                icon: const Icon(Icons.delete),
                style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(
                        Theme.of(context).colorScheme.error)),
                label: const Text('Delete'),
              )
            : IconButton(
                onPressed: () => _deletTx(_userTransactions.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
