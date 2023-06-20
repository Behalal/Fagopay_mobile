import 'dart:convert';
import 'package:fagopay/models/user_model/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocalCachedData{
  final SharedPreferences _prefs;
  LocalCachedData._(this._prefs);
  static Future<LocalCachedData> create() async => LocalCachedData._(await SharedPreferences.getInstance());
  static LocalCachedData get instance => Get.find<LocalCachedData>();

  Future<String?> getAuthToken() async {
    String? token = _prefs.getString("token");
    return token;
  }

  Future<void> cacheAuthToken({required String? token}) async {
    _prefs.setString("token", token!);
  }

  Future<void> clearCache() async {
    _prefs.clear();
  }

  Future<bool> getLoginStatus() async {
    bool? loginStatus = _prefs.getBool("isLoggedIn");
    return loginStatus ?? false;
  }

  Future<void> cacheLoginStatus({required bool isLoggedIn}) async {
    _prefs.setBool("isLoggedIn", isLoggedIn);
  }

  Future<void> cacheUserDetails({required UserDetailsResponse userDetailsResponse}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user_details", json.encode(userDetailsResponse.toJson()));
  }

  Future<UserDetailsResponse?> getUserDetails() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? userDetails = sharedPreferences.getString("user_details");
    return userDetails == null ? null : UserDetailsResponse.fromJson(jsonDecode(userDetails));
  }
}