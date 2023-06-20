
class PurseExpensesResponse {
  Data? data;
  String? message;

  PurseExpensesResponse({
    this.data,
    this.message,
  });

  factory PurseExpensesResponse.fromJson(Map<String, dynamic> json) => PurseExpensesResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<ExpensesCategory>? expensesCategory;
  String? budgetedAmount;
  String? duration;

  Data({
    this.expensesCategory,
    this.budgetedAmount,
    this.duration,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    expensesCategory: json["expenses_category"] == null ? [] : List<ExpensesCategory>.from(json["expenses_category"]!.map((x) => ExpensesCategory.fromJson(x))),
    budgetedAmount: json["budgeted_amount"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "expenses_category": expensesCategory == null ? [] : List<dynamic>.from(expensesCategory!.map((x) => x.toJson())),
    "budgeted_amount": budgetedAmount,
    "duration": duration,
  };
}

class ExpensesCategory {
  String? pulseCategoryId;
  String? caltegoryName;
  String? budgetedAmount;
  String? totalAmount;

  ExpensesCategory({
    this.pulseCategoryId,
    this.caltegoryName,
    this.budgetedAmount,
    this.totalAmount,
  });

  factory ExpensesCategory.fromJson(Map<String, dynamic> json) => ExpensesCategory(
    pulseCategoryId: json["pulse_category_id"],
    caltegoryName: json["caltegory_name"],
    budgetedAmount: json["budgeted_amount"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "pulse_category_id": pulseCategoryId,
    "caltegory_name": caltegoryName,
    "budgeted_amount": budgetedAmount,
    "total_amount": totalAmount,
  };
}
