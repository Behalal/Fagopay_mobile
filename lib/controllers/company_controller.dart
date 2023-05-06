import 'dart:developer';

import '../models/company_model.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  final Rx<Company?> _company = Rx(null);

  Company? get company => _company.value;

  set setCompany(Company company) {
    _company(company);
  }

    Future<dynamic> getCompany() async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.companyPath,
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
