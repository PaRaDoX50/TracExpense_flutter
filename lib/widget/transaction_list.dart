
import 'package:expensebuilder/model/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;
  final BuildContext scaffoldCtx;

  TransactionList(this._userTransactions, this._deleteTransaction,this.scaffoldCtx);

  @override
  Widget build(BuildContext context) {
    return Container(
alignment: Alignment.topCenter,
      child: (_userTransactions.isEmpty == true)
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
                                "₹${_userTransactions[index].amount.toStringAsFixed(0)}")),
                        padding: EdgeInsets.all(6),
                      ),
                      radius: 30,
                    ),
                    title: Text(_userTransactions[index].title),
                    subtitle: Text(DateFormat.yMMMEd()
                        .format(_userTransactions[index].date)),
                    trailing: FlatButton(
                      child: Icon(
                        Icons.delete,
                      ),
                      onPressed: () {
                        _deleteTransaction(_userTransactions[index],scaffoldCtx);
                      },
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
