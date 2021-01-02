import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './wigets/chart.dart';
import './wigets/newTransaction.dart';
import './wigets/userTransaction.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepPurple[400],
        fontFamily: 'SourceSansPro',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart =false;
  final List<Transaction> _transaction = [
    // Transaction(txId: 't1', amount: 80, txName: 'Trans1', date: DateTime.now()),
    // Transaction(txId: 't2', amount: 30, txName: 'Trans2', date: DateTime.now()),
  ];
  List<Transaction> get _recentTransaction {
    return _transaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime pickedDate) {
    final tx = Transaction(
      txName: txTitle,
      txId: DateTime.now().toString(),
      date: pickedDate,
      amount: txAmount,
    );
    setState(() {
      _transaction.add(tx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tx) => tx.txId == id);
    });
  }

  void _showAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final _isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showAddNewTransaction(context),
        ),
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
          appBar.preferredSize.height -
          MediaQuery.of(context).padding.top) *
          0.7,
      child: UserTransaction(_transaction, deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if(_isLandscape)Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show Chart'),
                Switch(value: _showChart, onChanged: (abc){
                  setState(() {
                    _showChart = abc;
                  });
                })
              ],
            ),
            if (!_isLandscape) Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
                  0.3,
              child: Chart(_recentTransaction),
            ),
            if (!_isLandscape) txList,
            if (_isLandscape) _showChart ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransaction),
            ): txList
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
