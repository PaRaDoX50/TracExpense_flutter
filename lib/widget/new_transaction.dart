

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function function;
  final BuildContext scaffoldCtx;


  NewTransaction(this.function,this.scaffoldCtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime datePicked;

  void datePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then((selectedDate){
          setState(() {
            datePicked = selectedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
              ),
              Row(
                children: <Widget>[

                  Expanded(child: Text(datePicked == null?"No date picked!":"Date Picked: ${DateFormat.MEd().format(datePicked)}")),
                  FlatButton(
                      onPressed: datePicker,
                      child: Text(
                        "Pick a date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ))
                ],
              ),
              RaisedButton(
                child: Text(
                  "Add Transaction",
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                  if(datePicked == null|| titleController.text == null|| amountController.text == null){

                  }
                  else {
                    widget.function(
                        titleController.text, amountController.text, datePicked,widget.scaffoldCtx);
                  }
                },
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.end,
          ),
        ),
        padding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: MediaQuery.of(context).viewInsets.bottom + 0),
      ),
    );
  }
}
