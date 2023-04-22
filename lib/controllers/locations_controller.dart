import 'dart:developer';

import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/networking/network_helper.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:get/get.dart';

class LocationsController extends GetxController {
  Future<dynamic> getCountries() async {
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.countriesPath,
        headers: BaseAPI.headers,
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }

  Future<dynamic> getStates(String countryId) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.countriesPath + countryId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }

    Future<dynamic> getCities(String stateId) async {
    final token = await SecureStorage.readUserToken();
    try {
      final responseData = await NetworkHelper.getRequest(
        url: BaseAPI.citiesPath + stateId,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      return responseData;
    } catch (e) {
      log(e.toString());
      throw Exception('Failed');
    }
  }
}
