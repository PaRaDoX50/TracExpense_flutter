


class LBTransaction {
  String id;
  String title;
  double amount;
  DateTime date;
  int lendBorrow; // 1 means Borrowed 2 means Gave


  LBTransaction({this.id, this.amount, this.date, this.title, this.lendBorrow});

  Map toJson() => {'id': id, 'title': title,'amount': amount,'date': date.toIso8601String(), 'lendBorrow': lendBorrow};


  factory LBTransaction.fromJson(dynamic parsedJson){
    return LBTransaction(
        id: parsedJson['id'],
        title : parsedJson['title'],
        amount : parsedJson ['amount'],
        date : DateTime.parse(parsedJson ['date'] ) as DateTime,
        lendBorrow: parsedJson['lendBorrow']

    );
  }
}