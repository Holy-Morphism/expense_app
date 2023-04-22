import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(error: Colors.red),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'SofiaSansCondensed',
            fontSize: 40,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontFamily: 'SofiaSansCondensed',
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showchart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime newdate) {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: newdate);
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0),
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _playAudio() async {
    AudioCache audioCache = AudioCache();
    await audioCache.load('audio/voice.mp3');
    await audioCache.play('audio/voice.mp3');
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      elevation: 5,
      // backgroundColor: Colors.black,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      centerTitle: true,
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    })
              ],
            ),
            _showchart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.4,
                    child: Chart(_recentTransactions))
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    child:
                        TransactionList(_userTransactions, _deleteTransaction),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _playAudio();
          _startAddNewTransaction(context);
        },
      ),
    );
  }
}
