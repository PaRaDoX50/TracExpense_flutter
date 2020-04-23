import 'dart:convert';
import 'package:expensebuilder/screens/stats_screen.dart';
import 'package:expensebuilder/widget/lb_transaction_list.dart';
import 'package:expensebuilder/widget/new_lend_borrow_transaction.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/l_b_transaction.dart';
import '../model/transaction.dart';
import 'package:flutter/material.dart';

class LendBorrowScreen extends StatefulWidget {
  @override
  _LendBorrowScreenState createState() => _LendBorrowScreenState();
}

class _LendBorrowScreenState extends State<LendBorrowScreen> {
  AppBar appBar = AppBar(
    title: Text('LendBOrrow'),
  );
  final noTransaction = SnackBar(
    content: Text(
      'No transactions!',
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,
    duration: Duration(milliseconds: 800),
  );
  final transactionAdded = SnackBar(
      content: Text(
        'Transaction Added!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 1000));
  final listCleared = SnackBar(
      content: Text(
        'List Cleared!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 800));
  final transactionDeleted = SnackBar(
      content: Text(
        'Transaction Deleted!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
      duration: Duration(milliseconds: 800));
  List<LBTransaction> userLBTransactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactions();
    print("initiated12356");
  }

  void loadTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("listLB") == null) {
      print("hello123");
    } else {
      setState(() {
        String stillEncoded = preferences.getString("listLB");
        print("1");
        var decodedList = jsonDecode(stillEncoded) as List;
        print("2");

        List<LBTransaction> loadedList =
            (decodedList).map((e) => LBTransaction.fromJson(e)).toList();
        userLBTransactions = loadedList;
        print(loadedList);
      });

      print("hello");
    }
  }

  void addToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(userLBTransactions);
//    var encodableList = userTransactions.map((element){
//      print(element);
//      element.toJson();
//    }).toList();
//    print(encodableList);
    String encoded = jsonEncode(userLBTransactions);
    print(encoded);
    prefs.setString("listLB", encoded);
  }

  void startNewTransaction(BuildContext ctx, BuildContext ctx2) {
    showModalBottomSheet(
        context: ctx,
        builder: (idgaf) {
          return NewLBTransaction(_addNewTransaction, ctx2);
        });
  }

  List<Transaction> recentTransations(List<Transaction> all) {
    return all.where((E) {
      return E.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void clearAll(BuildContext ctx) {
    userLBTransactions.isEmpty == false
        ? showDialog(
            context: context,
            builder: (_) => AlertDialog(
                    content: Text("Do you want to clear all the transactions?"),
                    elevation: 5,
                    title: Text("Delete"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("No")),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              userLBTransactions.clear();
                            });
                            Scaffold.of(ctx).showSnackBar(listCleared);
                            addToPrefs();
                            Navigator.pop(context);
                          },
                          child: Text("Yes"))
                    ]))
        : Scaffold.of(ctx).showSnackBar(noTransaction);
  }

  void _deleteTransaction(LBTransaction target, BuildContext ctx) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              content: Text("Do you want to delete this transaction?"),
              elevation: 5,
              title: Text("Delete"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context), child: Text("No")),
                FlatButton(
                    onPressed: () {
                      setState(() {
                        userLBTransactions.remove(target);
                      });
                      Scaffold.of(ctx).showSnackBar(transactionDeleted);
                      addToPrefs();
                      Navigator.pop(context);
                    },
                    child: Text("Yes"))
              ]);
        });
  }

  void _addNewTransaction(String title, String amount, DateTime pickedDate,
      int LendBorrow, BuildContext ctx) {
    Navigator.pop(context);
    setState(() {
      userLBTransactions.add(LBTransaction(
          id: "id",
          title: title,
          amount: double.parse(amount),
          date: pickedDate,
          lendBorrow: LendBorrow));
    });
    Scaffold.of(ctx).showSnackBar(transactionAdded);
    addToPrefs();
  }

  double getAmountBorrowed(List<LBTransaction> transactions) {
    var amountBorrowed = 0.0;
    List<LBTransaction> temp = transactions.map((E) {
      if (E.lendBorrow == 1) {
        amountBorrowed = amountBorrowed + E.amount;
      }
      return E;
    }).toList();
    return amountBorrowed;
  }

  double getAmountGave(List<LBTransaction> transactions) {
    var amountGave = 0.0;
    List<LBTransaction> temp = transactions.map((E) {
      if (E.lendBorrow != 1) {
        amountGave = amountGave + E.amount;
      }
      return E;
    }).toList();
    return amountGave;
  }

  void showStats() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                  height: 300,
                  child: StatsScreen(
                    amountBorrowed: getAmountBorrowed(userLBTransactions),
                    amountGave: getAmountGave(userLBTransactions),
                  )),
              elevation: 6,
              title: SizedBox(
                height: 5,
              ),
              actions: <Widget>[]);
        });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                showStats();
              },
              child: Text(
                "Stats",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  clearAll(context);
                },
                child: Text(
                  "Clear All",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue),
          ],
        ),
        Container(
            height: (mediaQuery.size.height -
                    (1 * appBar.preferredSize.height) -
                    50 -
                    72 - // 50 for button 72 for tab bar
                    MediaQuery.of(context).padding.vertical) *
                (1),
            child: Builder(builder: (BuildContext ctx) {
              return LBTransactionList(
                  userLBTransactions, _deleteTransaction, ctx);
            }))
      ])),
      floatingActionButton: Builder(builder: (BuildContext context1) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startNewTransaction(context, context1);
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
