import 'package:expensebuilder/screens/lend_borrow_screen.dart';
import 'package:expensebuilder/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: <Widget>[TransactionsScreen(),LendBorrowScreen()],
          ),
          appBar: AppBar(
            title: Text("TracExpense"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Expenses",

                ),
                Tab(

                  text: "Lend/Borrow",
                )
              ],
            ),
          ),
        ));
  }
}
