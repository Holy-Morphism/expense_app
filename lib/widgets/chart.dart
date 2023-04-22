import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bars.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double weekdayAmount = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.year == weekday.year &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.day == weekday.day) {
          weekdayAmount += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': weekdayAmount,
      };
    }).reversed.toList();
  }

  double get percentOfMax {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue += element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/tanjiro.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ...groupedTransactions.map(
                (data) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        percentOfMax == 0
                            ? 0.0
                            : (data['amount'] as double) / percentOfMax),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
