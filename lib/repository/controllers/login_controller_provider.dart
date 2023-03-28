import 'package:fagopay/models/auth_model/auth.dart';
import 'package:fagopay/models/user_model/user_response.dart';
import 'package:fagopay/repository/auth_repository.dart';
import 'package:fagopay/repository/login_states/login_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/register_request/register_response.dart';
import '../../models/user_model/user.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  Future<Auth> login(String email, String password) async {
    state = const LoginStateLaoding();

    Auth response =
        await ref.read(authRepositoryProvider).login(email, password);
    state = const LoginStateSuccess();
    // response.printAttributes();
    return response;
  }

  Future<Auth> selectAccountType(
      String accountType, String verification) async {
    state = const LoginStateLaoding();

    Auth response = await ref
        .read(authRepositoryProvider)
        .selectAccountType(accountType, verification);
    state = const LoginStateSuccess();
    // response.printAttributes();
    return response;
  }

  Future<Auth> resendCode(String id) async {
    state = const LoginStateLaoding();

    Auth response = await ref.read(authRepositoryProvider).resendCode(id);
    state = const LoginStateSuccess();
    // response.printAttributes();
    return response;
  }

  Future<Auth> validateCode(String id, String code) async {
    state = const LoginStateLaoding();

    Auth response =
        await ref.read(authRepositoryProvider).validateCode(id, code);
    state = const LoginStateSuccess();
    // response.printAttributes();
    return response;
  }

  Future<RegisterResponse> registerDetails(
      String id,
      String firstname,
      String lastname,
      String email,
      String password,
      String confirmPassword,
      String referral) async {
    state = const LoginStateLaoding();

    RegisterResponse response = await ref
        .read(authRepositoryProvider)
        .registerDetails(id, firstname, lastname, email, password,
            confirmPassword, referral);
    state = const LoginStateSuccess();
    response.printAttributes();
    return response;
  }

  Future<UserResponse> setPassCode(String code) async {
    state = const LoginStateLaoding();

    UserResponse response =
        await ref.read(authRepositoryProvider).setPassCode(code);
    state = const LoginStateSuccess();
    response.printAttributes();
    return response;
  }

  Future<User> getUserDetails() async {
    // state = const LoginStateLaoding();

    User response = await ref.read(authRepositoryProvider).getUserDetails();
    state = const LoginStateSuccess();
    response.printAttributes();
    return response;
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
