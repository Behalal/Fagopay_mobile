import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import '../models/supplier_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierController extends GetxController {
  bool isLoading = false;
  final Rx<List<Supplier>> _suppliers = Rx([]);

  List<Supplier> get suppliers {
    return [..._suppliers.value];
  }

  set suppliers(List<Supplier> suppliers) {
    _suppliers(suppliers);
  }

  Supplier findSupplierById(String id) {
    return suppliers.firstWhere((supplier) => supplier.id == id);
  }

  bool? isLoadingSuppliers;
  bool? isLoadingSuppliersHasError;

  Future<dio.Response<dynamic>?> getSuppliers({required String companyId})async{
    isLoadingSuppliers = true;
    isLoadingSuppliersHasError = false;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/supplier/list/$companyId", method: RequestMethod.get);
      final resBody = response?.data['data']['suppliers_list'];
      final returnedSuppliers = resBody.map<Supplier>((supplier) => Supplier.fromJson(supplier)).toList();
      suppliers = returnedSuppliers;
      isLoadingSuppliers = false;
      isLoadingSuppliersHasError = false;
      update();
      return response;
    }on dio.DioError catch (err) {
      isLoadingSuppliers = false;
      isLoadingSuppliersHasError = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      isLoadingSuppliers = false;
      isLoadingSuppliersHasError = true;
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  final accountNumberController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();



  // Future<dynamic> getSuppliers(String companyId) async {
  //   final token = await SecureStorage.readUserToken();
  //   try {
  //     final responseData = await NetworkHelper.getRequest(
  //       url: "${BaseAPI.suppliersPath}/list/$companyId",
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

  Future<dio.Response<dynamic>?> createNewSupplier(
      {required String bankCode,
      required String accountNumber,
      required String accountName,
      required String email,
      required String phone,
      required String address,
      required String countryId,
      required String stateId,
      required String cityId,
      required String companyId,
      required BuildContext context,
      }) async {
    progressIndicator(context);
    var requestBody = jsonEncode({
      "company_id": companyId,
      "bank_code": bankCode,
      "account_number": accountNumber,
      "account_name": accountName,
      "name": accountName,
      "email": email,
      "phone": phone,
      "address": address,
      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId
    });

    try {
      final response = await NetworkProvider().call(path: "/v1/supplier", method: RequestMethod.post, body: requestBody);
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }
}
