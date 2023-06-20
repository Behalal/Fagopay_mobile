
class GetPurseExpensesResponse {
  Data? data;
  String? message;

  GetPurseExpensesResponse({
    this.data,
    this.message,
  });

  factory GetPurseExpensesResponse.fromJson(Map<String, dynamic> json) => GetPurseExpensesResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<CategoryExpense>? categoryExpenses;

  Data({
    this.categoryExpenses,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    categoryExpenses: json["category_expenses"] == null ? [] : List<CategoryExpense>.from(json["category_expenses"]!.map((x) => CategoryExpense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_expenses": categoryExpenses == null ? [] : List<dynamic>.from(categoryExpenses!.map((x) => x.toJson())),
  };
}

class CategoryExpense {
  String? id;
  String? pulseId;
  String? userId;
  String? pulseCategoryId;
  String? amountSpend;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? caltegoryName;

  CategoryExpense({
    this.id,
    this.pulseId,
    this.userId,
    this.pulseCategoryId,
    this.amountSpend,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.caltegoryName,
  });

  factory CategoryExpense.fromJson(Map<String, dynamic> json) => CategoryExpense(
    id: json["id"],
    pulseId: json["pulse_id"],
    userId: json["user_id"],
    pulseCategoryId: json["pulse_category_id"],
    amountSpend: json["amount_spend"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    caltegoryName: json["caltegory_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pulse_id": pulseId,
    "user_id": userId,
    "pulse_category_id": pulseCategoryId,
    "amount_spend": amountSpend,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "caltegory_name": caltegoryName,
  };
}
