// ignore_for_file: public_member_api_docs, sort_constructors_first
class Expenses {}

class ExpenseCategory {
  String? id;
  String? categoryName;
  String? categoryDescription;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  ExpenseCategory({
    this.id,
    this.categoryName,
    this.categoryDescription,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  static ExpenseCategory fromJson(json) => ExpenseCategory(
        id: json['id'] as String?,
        categoryName: json['category_name'] as String?,
        categoryDescription: json['category_description'] as String?,
        createdBy: json['created_by'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  @override
  String toString() {
    return 'ExpenseCategory(id: $id, categoryName: $categoryName, categoryDescription: $categoryDescription, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
