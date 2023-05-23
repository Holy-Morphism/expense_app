import 'dart:io';

import 'package:expense/Database/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './Database/sql_helper.dart';
import 'dart:math';

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
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.blue,
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

  void _deleteTransaction(String id) async {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
    await SQLHelper.deleteTransaction(id);
  }

  void _addNewTransaction(String title, double amount, DateTime newdate) async {
    final transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: newdate,
        color: colors[Random().nextInt(4)]);
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

  Widget _buildLandScape() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch.adaptive(
            value: _showchart,
            onChanged: (val) {
              setState(() {
                _showchart = val;
              });
            })
      ],
    );
  }

  Widget _buildChart(
      MediaQueryData mediaQuery, PreferredSizeWidget appbar, double size) {
    return Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            size,
        child: Chart(_recentTransactions));
  }

  Widget _buildTransactionList(
      MediaQueryData mediaQuery, PreferredSizeWidget appbar, double size) {
    return Container(
      height: (mediaQuery.size.height -
              appbar.preferredSize.height -
              mediaQuery.padding.top) *
          0.8,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
  }

  List<Widget> _buildPotrait(
      MediaQueryData mediaQuery, PreferredSizeWidget appbar) {
    return [
      _buildChart(mediaQuery, appbar, 0.3),
      _buildTransactionList(mediaQuery, appbar, 0.7),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation;
    final PreferredSizeWidget appbar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
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
          )) as PreferredSizeWidget;
    final _pageBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandScape == Orientation.landscape) _buildLandScape(),
          if (_isLandScape == Orientation.landscape)
            _showchart
                ? _buildChart(mediaQuery, appbar, 0.8)
                : _buildTransactionList(mediaQuery, appbar, 0.8),
          if (_isLandScape != Orientation.landscape)
            ..._buildPotrait(mediaQuery, appbar)
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: appbar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appbar,
            body: _pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () {
                      _playAudio();
                      _startAddNewTransaction(context);
                    },
                  ),
          );
  }
}
