import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function _selectHandler;
  NewTransaction(this._selectHandler);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
          ),
          ElevatedButton(
            onPressed: () {
              _selectHandler(
                titleController.text,
                double.parse(amountController.text),
              );
            },
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
