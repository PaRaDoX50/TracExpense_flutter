class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  Transaction({this.id, this.amount, this.date, this.title});

  Map toJson() => {'id': id, 'title': title,'amount': amount,'date': date.toIso8601String()};


  factory Transaction.fromJson(dynamic parsedJson){
    return Transaction(
        id: parsedJson['id'],
        title : parsedJson['title'],
        amount : parsedJson ['amount'],
        date : DateTime.parse(parsedJson ['date'] ) as DateTime

    );
  }
}
