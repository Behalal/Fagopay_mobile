import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  // final Rx<List<Invoice>> _invoices = Rx([]);
  //
  // List<Invoice> get invoices {
  //   return [..._invoices.value];
  // }
  //
  // set invoices(List<Invoice> invoices) {
  //   _invoices(invoices);
  // }


  Future<dio.Response<dynamic>?> markInvoiceAsPaid({required String invoiceId,required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/mark-as-paid/$invoiceId", method: RequestMethod.get);
      Get.back();
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Invoice marked as paid", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> logPayment({required String invoiceId, required amountPaid, required BuildContext context})async{
    progressIndicator(context);
    try{
      var body = jsonEncode({
        "invoice_id": invoiceId,
        "amount": amountPaid
      });
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/log-payment", method: RequestMethod.post, body: body);
      Get.back();
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Request Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }


  Future<dio.Response<dynamic>?> deleteInvoice({required String invoiceId, required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/log-payment", method: RequestMethod.delete,);
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Request Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }



  Future<dio.Response<dynamic>?> deleteInvoiceDetails({required String id, required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/businessinvoice/detail-delete/$id", method: RequestMethod.delete,);
      Get.back();
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Request Successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
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
    required List invoiceItemDetails,
    required String companyId,
    required String customerId,
    required String discountRate,
    required String taxRate,
  }) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "invoicedetail": invoiceItemDetails,
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
