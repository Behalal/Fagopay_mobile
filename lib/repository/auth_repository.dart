import 'package:fagopay/models/auth_model/auth.dart';
import 'package:fagopay/models/register_request/register_response.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/models/user_model/user_response.dart';
import 'package:fagopay/service/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final AuthService _authService;
  AuthRepository(this._authService);

  Future<Auth> login(String email, String password) async {
    String response = await _authService.login(email, password);
    Auth authResponse = Auth.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<Auth> selectAccountType(
      String accountType, String verification) async {
    String response =
        await _authService.selectAccountType(accountType, verification);
    Auth authResponse = Auth.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<Auth> resendCode(String id) async {
    String response = await _authService.resendCode(id);
    Auth authResponse = Auth.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<Auth> validateCode(String id, String code) async {
    String response = await _authService.validateCode(id, code);
    Auth authResponse = Auth.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<RegisterResponse> registerDetails(
      String id,
      String firstname,
      String lastname,
      String email,
      String password,
      String confirmPassword,
      String referral) async {
    String response = await _authService.registerDetails(
        id, firstname, lastname, email, password, confirmPassword, referral);
    RegisterResponse authResponse = RegisterResponse.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<UserResponse> setPassCode(String code) async {
    String response = await _authService.setPassCode(code);
    UserResponse authResponse = UserResponse.fromReqBody(response);
    authResponse.printAttributes();
    return authResponse;
  }

  Future<User> getUserDetails() async {
    String response = await _authService.getUserDetails();
    User userDetails = User.fromReqBody(response);
    userDetails.printAttributes();
    return userDetails;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.read(authServiceProvider));
});
