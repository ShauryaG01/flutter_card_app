import 'package:flutter/foundation.dart';

class Transaction {
  @required final String txName;
  @required final String txId;
  @required final double amount;
  @required final DateTime date;

  Transaction({this.txId,this.amount,this.date,this.txName});
}