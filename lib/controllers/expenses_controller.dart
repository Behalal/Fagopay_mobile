import 'dart:convert';
import 'dart:developer';

import '../models/expenses_model.dart';
import 'package:flutter/material.dart';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  final Rx<List<Expenses>> _expenses = Rx([]);

  List<Expenses> get expenses {
    return [..._expenses.value];
  }

  set expenses(List<Expenses> expenses) {
    _expenses(expenses);
  }

  void filterExpenses(String value) {
    expenses
        .where((expense) => expense.category!.categoryName == value)
        .toList();
    update();
  }

  Expenses findExpenseById(String id) {
    return expenses.firstWhere((expense) => expense.id == id);
  }

  // TextEditingController expenseAmountController = TextEditingController();
  TextEditingController expenseReasonController = TextEditingController();
  TextEditingController expenseDescriptionController = TextEditingController();

  Future<dynamic> getBusinessExpenses(String companyId) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.businessExpensesPath}/$companyId",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> createBusinessExpense(
      {required String companyId,
      required String supplierId,
      required String reason,
      required String expenseCategory,
      required String expenseDate,
      required String note}) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "company_id": companyId,
      "supplier_id": supplierId,
      "reason": reason,
      "expense_category": expenseCategory,
      "expense_date": expenseDate,
      "note": note,
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.businessExpensesPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: requestBody,
      );
      return response;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> getBusinessExpenseCategories() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.businessExpensesCategoryPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
    }
  }
}
