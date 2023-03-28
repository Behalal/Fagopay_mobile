import 'dart:convert';

import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/service/constants/constants.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class LocationService extends BaseAPI {
  Functions function = Functions();
  SecureStorage storage = SecureStorage();

  

  Future<String> getAllCountries() async {
    http.Response response = await http.get(
      Uri.parse(super.locationPath),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> getAllCountryStaes(String countryId) async {
    var token = await storage.tokenRead();

    http.Response response = await http.get(
      Uri.parse("${super.locationPath}$countryId"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": "Bearer $token"
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }

  Future<String> getAllStateCities(int stateId) async {
    http.Response response = await http.get(
      Uri.parse("${super.cityPath}$stateId"),
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
    );

    var responseBody = jsonEncode({
      'status_code': response.statusCode,
      'body': jsonDecode(response.body)
    });

    return responseBody;
  }
}
