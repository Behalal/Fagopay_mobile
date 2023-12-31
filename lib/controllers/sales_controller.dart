import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart'as dio;
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/sales_model.dart';
import '../models/sales_response_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';

class SalesController extends GetxController {
  // final Rx<List<Sales>> _sales = Rx([]);
  //
  // List<Sales> get sales {
  //   return [..._sales.value];
  // }
  //
  // set sales(List<Sales> sales) {
  //   _sales(sales);
  // }
  //
  // Sales findSaleById(String id) {
  //   return sales.firstWhere((sale) => sale.id == id);
  // }

  TextEditingController salesAmountController = TextEditingController();
  TextEditingController amountPaidController = TextEditingController();
  TextEditingController salesDescriptionController = TextEditingController();

  Future<dynamic> createBusinessSales(
      {required String companyId,
      required String customerId,
      required String salesAmount,
      required String amountPaid,
      required String paymentStatus,
      required String salesDate,
      required String salesDescription}) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "company_id": companyId,
      "customer_id": customerId,
      "sales_amount": salesAmount,
      "amount_paid": amountPaid,
      "payment_status": paymentStatus,
      "sales_date": salesDate,
      "sales_description": salesDescription,
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.businessSalesPath,
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
}
