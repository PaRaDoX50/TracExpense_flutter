
import 'package:expensebuilder/screens/main_screen.dart';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
        title: 'Expense Tracker',
        home: MainScreen(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.amberAccent,
            fontFamily: 'OpenSans'));
  }
}


