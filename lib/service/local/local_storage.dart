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

  Future<String?> getPassword() async {
    String? password = _prefs.getString("password");
    return password;
  }

  Future<void> cachePassword({required String? password}) async {
    _prefs.setString("password", password!);
  }

  Future<bool?> getEnableBiometricStatus() async {
    bool? status = _prefs.getBool("status");
    return status ?? false;
  }

  Future<void> cacheEnableBiometricStatus({required bool? status}) async {
    _prefs.setBool("status", status!);
  }

  Future<String?> getEmail() async {
    String? email = _prefs.getString("email");
    return email;
  }

  Future<void> cacheEmail({required String? email}) async {
    _prefs.setString("email", email!);
  }

  Future<String?> getPhoneNumber() async {
    String? phoneNumber = _prefs.getString("phoneNumber");
    return phoneNumber;
  }

  Future<void> cachePhoneNumber({required String? phoneNumber}) async {
    _prefs.setString("phoneNumber", phoneNumber!);
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