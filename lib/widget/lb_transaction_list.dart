
import 'package:expensebuilder/model/l_b_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LBTransactionList extends StatelessWidget {
  final List<LBTransaction> _LBuserTransactions;
  final Function _deleteTransaction;
  final BuildContext scaffoldCtx;

  LBTransactionList(this._LBuserTransactions, this._deleteTransaction,this.scaffoldCtx);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: (_LBuserTransactions.isEmpty == true)
          ? (Stack(alignment: Alignment.center,
        children: <Widget>[

          Container(
            child: Card(
              child: Image(
                  image: AssetImage('assets/images/no_transaction.png')),
              elevation: 5,
            ),
          ),
          Container(color: Theme.of(context).primaryColor,padding: EdgeInsets.all(10),child: Text("TRANSACTIONS LIST EMPTY",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'OpenSans',color: Colors.white),)),
        ],
      ))
          : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  child: FittedBox(
                      child: Text(
                          "₹${_LBuserTransactions[index].amount.toStringAsFixed(0)}",style: TextStyle(color: Colors.white),)),
                  padding: EdgeInsets.all(6),
                ),
                radius: 30,
              ),
              title: Text(_LBuserTransactions[index].title),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(DateFormat.yMMMEd()
                      .format(_LBuserTransactions[index].date) ),
                      Text(_LBuserTransactions[index].lendBorrow == 1 ? "Borrowed" : "Gave",style: TextStyle(color: (_LBuserTransactions[index].lendBorrow == 1 ? Colors.red : Colors.green)),),
                ],
              ),
              trailing: FlatButton(
                child: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  _deleteTransaction(_LBuserTransactions[index],scaffoldCtx);
                },
              ),
            ),
          );
        },
        itemCount: _LBuserTransactions.length,
      ),
    );
  }
}
