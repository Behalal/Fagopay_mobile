import 'dart:convert';
import 'dart:developer';

import '../models/invoice_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  final Rx<List<Invoice>> _invoices = Rx([]);

  List<Invoice> get invoices {
    return [..._invoices.value];
  }

  set invoices(List<Invoice> invoices) {
    _invoices(invoices);
  }

  Invoice findInvoiceById(String id) {
    return invoices.firstWhere((invoice) => invoice.id == id);
  }

  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountRateController = TextEditingController();
  TextEditingController taxRateController = TextEditingController();

  Future<dynamic> getInvoices(String companyId) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: "${BaseAPI.businessInvoicePath}/$companyId",
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

  Future<dynamic> createBusinessInvoice({
    required List invoiceDetails,
    required String companyId,
    required String customerId,
    required String discountRate,
    required String taxRate,
  }) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "invoicedetail": [],
      "company_id": companyId,
      "customer_id": customerId,
      "discount_rate": discountRate,
      "tax_rate": taxRate,
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.businessInvoicePath,
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
