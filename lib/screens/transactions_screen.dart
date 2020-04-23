import 'dart:convert';
import 'package:expensebuilder/widget/chart.dart';
import 'package:expensebuilder/widget/new_transaction.dart';
import 'package:expensebuilder/widget/transaction_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/transaction.dart';
import 'package:flutter/material.dart';



class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  AppBar appBar = AppBar(
    title: Text('Expense Tracker'),
  );
  final noTransaction = SnackBar(
    content: Text(
      'No transactions!',
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.red,duration: Duration(milliseconds: 800) ,
  );
  final transactionAdded = SnackBar(
      content: Text(
        'Transaction Added!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,duration: Duration(milliseconds: 1000)
  );
  final listCleared = SnackBar(
      content: Text(
        'List Cleared!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,duration: Duration(milliseconds: 800)
  );
  final transactionDeleted = SnackBar(
      content: Text(
        'Transaction Deleted!',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,duration: Duration(milliseconds: 800)
  );
  List<Transaction> userTransactions = [];

  @override
  void initState() {
    super.initState();
    loadTransactions();
    print("initiated12356");
  }

  void loadTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.getString("list") == null) {
      print("hello123");
    } else {
      setState(() {
        String stillEncoded = preferences.getString("list");
        print("1");
        var decodedList = jsonDecode(stillEncoded) as List;
        print("2");

        List<Transaction> loadedList =
        (decodedList).map((e) => Transaction.fromJson(e)).toList();
        userTransactions = loadedList;
        print(loadedList);
      });

      print("hello");
    }
  }

  void addToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print(userTransactions);
//    var encodableList = userTransactions.map((element){
//      print(element);
//      element.toJson();
//    }).toList();
//    print(encodableList);
    String encoded = jsonEncode(userTransactions);
    print(encoded);
    prefs.setString("list", encoded);
  }

  void startNewTransaction(BuildContext ctx, BuildContext ctx2) {
    showModalBottomSheet(
        context: ctx,
        builder: (idgaf) {
          return NewTransaction(_addNewTransaction, ctx2);
        });
  }

  List<Transaction> recentTransations(List<Transaction> all) {
    return all.where((E) {
      return E.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void clearAll(BuildContext ctx) {
    userTransactions.isEmpty == false
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
                      userTransactions.clear();
                    });
                    Scaffold.of(ctx).showSnackBar(listCleared);
                    addToPrefs();
                    Navigator.pop(context);
                  },
                  child: Text("Yes"))
            ]))
        : Scaffold.of(ctx).showSnackBar(noTransaction);
  }

  void _deleteTransaction(Transaction target, BuildContext ctx) {
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
                        userTransactions.remove(target);
                      });
                      Scaffold.of(ctx).showSnackBar(transactionDeleted);
                      addToPrefs();
                      Navigator.pop(context);
                    },
                    child: Text("Yes"))
              ]);
        });
  }

  void _addNewTransaction(
      String title, String amount, DateTime pickedDate, BuildContext ctx) {
    Navigator.pop(context);
    setState(() {


      userTransactions.add(Transaction(
          id: "id",
          title: title,
          amount: double.parse(amount),
          date: pickedDate));
    });
    Scaffold.of(ctx).showSnackBar(transactionAdded);
    addToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(




      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Builder(builder: (BuildContext ctx) {
            return RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Clear All",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                clearAll(ctx);
              },
              color: Theme.of(context).primaryColor,
            );
          }),
            Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -50-72- // 50 for button 72 for tab bar
                    mediaQuery.padding.vertical) *
                    (.27),
                child: Chart(recentTransations(
                    userTransactions == null ? [] : userTransactions))),
            Container(
                height: (mediaQuery.size.height -
                    appBar.preferredSize.height -50-72-  // 50 for button 72 for tab bar
                    mediaQuery.padding.vertical) *
                    (.73),
                child: Builder(builder:(BuildContext ctx) {return TransactionList(userTransactions, _deleteTransaction,ctx);}))
          ],
        ),
      ),
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
