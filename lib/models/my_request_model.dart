class MyRequestStatic {
  int? amount;
  String? name;
  DateTime? date;
  MyRequestStatic({this.amount, this.name, this.date});
}

var myRequestStatic = [
  MyRequestStatic(amount: 200, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequestStatic(amount: 300, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequestStatic(amount: 300, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequestStatic(amount: 600, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequestStatic(amount: 700, name: "Ibrahim Lukman", date: DateTime.now()),
];
