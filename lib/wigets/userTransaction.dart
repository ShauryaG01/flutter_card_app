import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class UserTransaction extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;
  UserTransaction(this.transaction,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return  transaction.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Transactions Karo Bhaii!!',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: constraints.maxHeight*0.7,
                  child: Image.asset(
                    'images/playstore.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
    })
          : ListView.builder(
              itemBuilder: (contx, itemno) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${transaction[itemno].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              // color: Colors.purple,
                              //color: Theme.of(context).primaryColor,
                              fontFamily: 'Pacifico',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transaction[itemno].txName,
                      style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transaction[itemno].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: (){deleteTx(transaction[itemno].txId);},
                      color: Colors.deepOrange,
                    ),
                  ),
                );
              },
              itemCount: transaction.length,

    );
  }
}
