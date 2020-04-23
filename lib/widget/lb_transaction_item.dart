import 'package:flutter/material.dart';

class LBTransactionItem extends StatelessWidget {
  String personName;
  double amount;
  DateTime dateTime;
  int lendBorrow;
  Function function;
  LBTransactionItem({this.personName,this.amount,this.dateTime,this.lendBorrow,this.function});

  @override
  Widget build(BuildContext context) {
    return Center(child:Text("AAp chutiye ho"));
  }
}
