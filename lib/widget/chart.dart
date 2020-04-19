import 'package:expensebuilder/model/transaction.dart';
import 'package:expensebuilder/widget/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransactions;


  Chart(this.recentTransactions);

  double totalSum(List<Transaction> recentTransactions){
    var total = 0.0;
    for(int i = 0; i < recentTransactions.length;i++){
      total = total + recentTransactions.elementAt(i).amount;

    }
    return total;
  }


  List<Map<Object, double>> sumOfEveryDay() {
    List<Map<Object, double>> x = [];
    for (int i = 0; i < 7; i++) {
      final weekDay = DateTime.now().subtract(Duration(days: i));
      double sum = 0;
      for (int j = 0; j < recentTransactions.length; j++) {
        if (weekDay.weekday == recentTransactions.elementAt(j).date.weekday) {
          sum = sum + recentTransactions.elementAt(j).amount;

        }
      }
      x.add({DateFormat.E().format(weekDay): sum});
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
//    print(sumOfEveryDay());
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(constraints.maxHeight*.05),
            child: Card(elevation: 5,

                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(height:constraints.maxHeight*.1,child: Text("Stats for last 7 days",style: TextStyle(color: Colors.black54),)),
                    Container(height: constraints.maxHeight*.7,
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: sumOfEveryDay().reversed.map((element) {
//            print(totalSum(recentTransactions));
                          return Flexible(fit: FlexFit.tight,
                            child: ChartBar(
                                element.values.toList()[0].toStringAsFixed(0),
                                totalSum(recentTransactions) == 0 ? 0 : element.values
                                    .toList()[0] / totalSum(recentTransactions),
                                element.keys.toList()[0].toString()),);
                        }).toList(),
                      ),
                    ),
                  ],
                )),
          )
      );
    });
  }
}
