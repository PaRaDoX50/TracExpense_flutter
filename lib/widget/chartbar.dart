import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String amount;
  double fractionOfTotal;
  String weekDay;

  ChartBar(this.amount, this.fractionOfTotal, this.weekDay);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints){return Column(
        children: <Widget>[
          Container(
              height:constraints.maxHeight * .13,
              child: FittedBox(child: Text("₹${amount}",))),
          SizedBox(height: constraints.maxHeight * .03,),
          Container(
            height: constraints.maxHeight*.65,
            width: constraints.maxWidth*(.17),
            child: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10))),
                Container(
                  height: (fractionOfTotal*90),

                        decoration: BoxDecoration(
                            color: Colors.blue,
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10)))
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * .03,),
          Container(child: FittedBox(child: Text(weekDay)),height: constraints.maxHeight * .12,)
        ]
      );}
    );
  }
}
