// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/models/company_model.dart';
import 'package:fagopay/models/supplier_model.dart';

import 'customer_model.dart';

class Expenses {
  String? id;
  String? reason;
  String? expenseDate;
  String? note;
  String? createdBy;
  Supplier? supplier;
  Company? company;
  ExpenseCategory? category;

  Expenses({
    this.id,
    this.reason,
    this.expenseDate,
    this.note,
    this.createdBy,
    this.supplier,
    this.company,
    this.category,
  });

  static Expenses fromJson(json) => Expenses(
        id: json['id'] as String?,
        reason: json['reason'] as String?,
        expenseDate: json['expense_date'] as String?,
        note: json['note'] as String?,
        createdBy: json['created_by'] as String?,
        supplier: Supplier.fromJson(json['supplier']),
        company: Company.fromJson(json['company']),
        category: ExpenseCategory.fromJson(json['category']),
      );

  @override
  String toString() {
    return 'Expenses(id: $id, reason: $reason, expenseDate: $expenseDate, note: $note, createdBy: $createdBy, supplier: $supplier, company: $company, category: $category)';
  }
}

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
