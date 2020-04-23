import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  double amountBorrowed;
  double amountGave;

  StatsScreen({this.amountBorrowed, this.amountGave});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: Container(height: 300,

          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Amount Borrowed",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text(amountBorrowed.toString(),style: TextStyle(color: Colors.red,fontSize: 30),),
              Text("Amount Gave",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              Text(amountGave.toString(),style: TextStyle(color: Colors.green,fontSize: 30),),
              Text((amountBorrowed >= amountGave
                  ? "You need to pay"
                  : "You will get"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              Text((amountBorrowed >= amountGave
                  ? (amountBorrowed - amountGave).toString()
                  : (-amountBorrowed + amountGave).toString()),style: TextStyle(color: amountBorrowed >= amountGave ? Colors.red : Colors.green ,fontSize: 30),)
            ],
          ),
        ),
      ),
    );
  }
}
