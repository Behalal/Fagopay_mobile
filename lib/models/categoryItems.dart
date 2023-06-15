class CategoryItems {
  String categoryId;
  int amount;

  CategoryItems({
    required this.categoryId,
    required this.amount,
  });

  factory CategoryItems.fromJson(Map<String, dynamic> json) => CategoryItems(
    categoryId: json["category_id"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "amount": amount,
  };
}