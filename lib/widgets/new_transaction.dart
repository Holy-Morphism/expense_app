import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function _addTx;
  final VoidCallback _close;
  NewTransaction(this._addTx, this._close);

  void _submitData() {
    final submittedTitle = titleController.text;
    final submittedAmount = double.parse(amountController.text);
    if (submittedTitle.isEmpty || submittedAmount <= 0) {
      return;
    }
    _addTx(submittedTitle, submittedAmount);
    _close.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
            onSubmitted: (_) => _submitData,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submitData,
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text("SAVE"),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(5)),
          )
        ]),
      ),
    );
  }
}
