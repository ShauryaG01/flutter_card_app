import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;
  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void enterTransaction() {
    if(amountController.text.isEmpty){
      return;
    }
    final enterText = textController.text;
    final enterAmount = double.parse(amountController.text);

    if (enterText.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addtx(
      enterText,
      enterAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Transaction Name'),
              controller: textController,
              onSubmitted: (_) => enterTransaction(),
              // onChanged: (val) {
              //   textInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => enterTransaction(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : DateFormat.yMd().format(_selectedDate)),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: enterTransaction,
              // textColor: Colors.purple,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
