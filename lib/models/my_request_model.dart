class MyRequest {
  int? amount;
  String? name;
  DateTime? date;
  MyRequest({this.amount, this.name, this.date});
}

var myRequest = [
  MyRequest(amount: 200, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequest(amount: 300, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequest(amount: 300, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequest(amount: 600, name: "Ibrahim Lukman", date: DateTime.now()),
  MyRequest(amount: 700, name: "Ibrahim Lukman", date: DateTime.now()),
];
