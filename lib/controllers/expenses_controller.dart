import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  // final Rx<List<Sales>> _sales = Rx([]);

  // List<Sales> get sales {
  //   return [..._sales.value];
  // }

  // set sales(List<Sales> sales) {
  //   _sales(sales);
  // }

  // Sales findExpenseById(String id) {
  //   return sales.firstWhere((sale) => sale.id == id);
  // }

  // TextEditingController expenseAmountController = TextEditingController();
  TextEditingController expenseReasonController = TextEditingController();
  TextEditingController expenseDescriptionController = TextEditingController();

  // Future<dynamic> getBusinessExpenses(String companyId) async {
  //   final token = await SecureStorage.readUserToken();
  //   try {
  //     final responseData = await NetworkHelper.getRequest(
  //       url: "${BaseAPI.businessSalesPath}/$companyId",
  //       headers: {
  //         "Content-Type": "application/json; charset=UTF-8",
  //         "Authorization": "Bearer $token",
  //       },
  //     );
  //     return responseData;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

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
