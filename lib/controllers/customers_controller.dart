import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/models/customer_details.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import '../models/customer_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  // final Rx<Customer?> _customer = Rx(null);
  final Rx<List<Customer>> _customers = Rx([]);

  List<Customer> get customers {
    return [..._customers.value];
  }

  set customers(List<Customer> customers) {
    _customers(customers);
  }

  Customer findCustomerById(String id) {
    return customers.firstWhere((customer) => customer.id == id);
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool? isLoadingCustomers;
  bool? isLoadingCustomersHasError;
  Future<dio.Response<dynamic>?> getCustomers({required String companyId})async{
    isLoadingCustomers = true;
    isLoadingCustomersHasError = false;
    log(isLoadingCustomers.toString());
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/customer/company/$companyId", method: RequestMethod.get);
      final customerResponse = response?.data['data']['customers'];
      final returnedCustomers = customerResponse.map<Customer>((customer) => Customer.fromJson(customer)).toList();
      customers = returnedCustomers;
      isLoadingCustomers = false;
      log(isLoadingCustomers.toString());
      isLoadingCustomersHasError = false;
      update();
      return response;
    }on dio.DioError catch (err) {
      isLoadingCustomers = false;
      isLoadingCustomersHasError = true;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      isLoadingCustomers = false;
      isLoadingCustomersHasError = true;
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dynamic> registerNewCustomer(
      {required String name,
      required String phoneNumber,
      required String email,
      required String address,
      required String countryId,
      required String stateId,
      required String companyId,
      required String cityId}) async {
    final token = await SecureStorage.readUserToken();

    var requestBody = jsonEncode({
      "fullname": name,
      "phone_number": phoneNumber,
      "email": email,
      "address": address,
      "country_id": countryId,
      "state_id": stateId,
      "city_id": cityId,
      "company_id": companyId
    });

    try {
      final response = await NetworkHelper.postRequest(
        url: BaseAPI.customersPath,
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "Authorization": "Bearer $token",
        },
        body: requestBody,
      );
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      addressController.clear();
      countryController.clear();
      stateController.clear();
      cityController.clear();
      return response;
    } catch (e) {
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      addressController.clear();
      countryController.clear();
      stateController.clear();
      cityController.clear();
      update();
    }
  }
}
