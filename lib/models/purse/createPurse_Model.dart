// To parse this JSON data, do
//
//     final createPurseModel = createPurseModelFromJson(jsonString);

import 'dart:convert';

CreatePurseModel createPurseModelFromJson(String str) =>
    CreatePurseModel.fromJson(json.decode(str));

String createPurseModelToJson(CreatePurseModel data) =>
    json.encode(data.toJson());

class CreatePurseModel {
  List<CategoryList>? categories;
  String? name;
  String amount;
  String duration;

  CreatePurseModel({
    this.categories,
    this.name,
    required this.amount,
    required this.duration,
  });

  factory CreatePurseModel.fromJson(Map<String, dynamic> json) =>
      CreatePurseModel(
        categories: List<CategoryList>.from(
            json["categories"].map((x) => CategoryList.fromJson(x))),
        name: json["name"],
        amount: json["amount"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "name": name,
        "amount": amount,
        "duration": duration,
      };
}

class CategoryList {
  String categoryId;
  String amount;

  CategoryList({
    required this.categoryId,
    required this.amount,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        categoryId: json["category_id"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "amount": amount,
      };
}
