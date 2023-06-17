// To parse this JSON data, do
//
//     final purseListModel = purseListModelFromJson(jsonString);

import 'dart:convert';

PurseListModel purseListModelFromJson(String str) => PurseListModel.fromJson(json.decode(str));

String purseListModelToJson(PurseListModel data) => json.encode(data.toJson());

class PurseListModel {
  PurseListData data;
  String message;

  PurseListModel({
    required this.data,
    required this.message,
  });

  factory PurseListModel.fromJson(Map<String, dynamic> json) => PurseListModel(
    data: PurseListData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
  };
}

class PurseListData {
  List<PulseList> pulseList;

  PurseListData({
    required this.pulseList,
  });

  factory PurseListData.fromJson(Map<String, dynamic> json) => PurseListData(
    pulseList: List<PulseList>.from(json["pulse_list"].map((x) => PulseList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pulse_list": List<dynamic>.from(pulseList.map((x) => x.toJson())),
  };
}

class PulseList {
  String id;
  String amount;
  String name;
  String duration;
  dynamic description;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<PulseCategory> pulseCategories;

  PulseList({
    required this.id,
    required this.amount,
    required this.name,
    required this.duration,
    this.description,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.pulseCategories,
  });

  factory PulseList.fromJson(Map<String, dynamic> json) => PulseList(
    id: json["id"],
    amount: json["amount"],
    name: json["name"],
    duration: json["duration"],
    description: json["description"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pulseCategories: List<PulseCategory>.from(json["pulse_categories"].map((x) => PulseCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "name": name,
    "duration": duration,
    "description": description,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pulse_categories": List<dynamic>.from(pulseCategories.map((x) => x.toJson())),
  };
}

class PulseCategory {
  String id;
  String userId;
  String pulseId;
  String pulseCategoryId;
  String budgetedAmount;
  String categoryName;
  int amountSpend;
  int amountLeftToSpend;

  PulseCategory({
    required this.id,
    required this.userId,
    required this.pulseId,
    required this.pulseCategoryId,
    required this.budgetedAmount,
    required this.categoryName,
    required this.amountSpend,
    required this.amountLeftToSpend,
  });

  factory PulseCategory.fromJson(Map<String, dynamic> json) => PulseCategory(
    id: json["id"],
    userId: json["user_id"],
    pulseId: json["pulse_id"],
    pulseCategoryId: json["pulse_category_id"],
    budgetedAmount: json["budgeted_amount"],
    categoryName: json["category_name"],
    amountSpend: json["amount_spend"],
    amountLeftToSpend: json["amount_left_to_spend"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "pulse_id": pulseId,
    "pulse_category_id": pulseCategoryId,
    "budgeted_amount": budgetedAmount,
    "category_name": categoryName,
    "amount_spend": amountSpend,
    "amount_left_to_spend": amountLeftToSpend,
  };
}
