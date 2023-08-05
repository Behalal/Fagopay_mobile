import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/models/auth_model/forgot_password_response.dart';
import 'package:fagopay/models/auth_model/login_response.dart';
import 'package:fagopay/models/auth_model/reset_passcode_response_model.dart';
import 'package:fagopay/models/auth_model/reset_password_response.dart';
import 'package:fagopay/models/auth_model/verify_reset_password_otp_response.dart';
import 'package:fagopay/models/dispute_reason_response.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/authentication/account_creation/setup_passcode.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';

import '../screens/authentication/reset_password_screen.dart';
import '../service/constants/constants.dart';
import '../service/networking/network_helper.dart';
import '../service/secure_storage/secure_storage.dart';
import 'company_controller.dart';

enum OtpForgotVerifyStatus {
  empty,
  loading,
  error,
  success,
}
enum ChangePasswordPassword {
  yes,
  no,
}

enum GetUserStatus {
  empty,
  loading,
  error,
  success,
  available,
}

//owin.abir@findours.com
//Bigdaddy@123
class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgotPasswordController = TextEditingController();

  final _otpForgotVerifyStatus = OtpForgotVerifyStatus.empty.obs;
  static final isgetKyc = false.obs;

   final _showChangePassword = ChangePasswordPassword.no.obs;
  ChangePasswordPassword get getShowPass => _showChangePassword.value;

  final _getUserStatus = GetUserStatus.empty.obs;
  GetUserStatus get getUserStatus => _getUserStatus.value;

  OtpForgotVerifyStatus get otpForgotVerifyStatus => _otpForgotVerifyStatus.value;

  String? fcmToken;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fmcToken;
  getToken() async {
    fmcToken = await messaging.getToken();
    return fmcToken;
  }
  bool isLoading = false;
  Future<LoginResponse?> loginUser()async{
    await getToken();
    try{
      var postBody = jsonEncode({
        'username': emailController.text,
        'password': passwordController.text
      });
      final response = await NetworkProvider().call(path: "/v1/user/login", method: RequestMethod.post, body: postBody);
      final payload = LoginResponse.fromJson(response!.data);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      LocalCachedData.instance.cacheAuthToken(token: payload.token);
      LocalCachedData.instance.cachePassword(password: passwordController.text);
      SecureStorage.setUserToken(payload.token);
      await postFcmToken();
      return payload;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString(),colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }

  Future<dio.Response<dynamic>?> postFcmToken()async{
    try{
      var fcmBody = jsonEncode( {
        "token": fmcToken
      });
      final fcmResponse = await NetworkProvider().call(path: "/v1/user/add-user-fcm-token", method: RequestMethod.post, body: fcmBody);
      return fcmResponse;
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

  Future<dio.Response<dynamic>?> getUserDetails()async{
    _getUserStatus(GetUserStatus.loading);
    try{
      final response = await NetworkProvider().call(path: "/v1/user/dashboard", method: RequestMethod.get);
      Get.put<LocalCachedData>(await LocalCachedData.create());
      final userDetails = UserDetailsResponse.fromJson(response?.data);
      await LocalCachedData.instance.cacheUserDetails(userDetailsResponse: userDetails);
      // await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
      return response;
    }on dio.DioError catch (err) {
      _getUserStatus(GetUserStatus.error);
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
        _getUserStatus(GetUserStatus.error);
        Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
        throw err.toString();
    }
  }

  Future<void> loadUserDetails() async {
    final _userController = Get.put(UserController());
    final _companyController = Get.find<CompanyController>();
    final response = await getUserDetails();
    final userNextOfKinBodyData = response?.data['data']['userdetail']['nextofkin'];
    if (kDebugMode) {
      print('User NoK details response is $userNextOfKinBodyData');
    }
    final userjsonBodyData = response?.data['data']['userdetail'];
    if (kDebugMode) {
      print('User details response is $userjsonBodyData');
    }
    final userAccountjsonBodyData = response?.data['data']['userdetail']['accountdetail'];
    final userDetails = UserDetail.fromJson(userjsonBodyData);
    if (kDebugMode) {
      print(
          '-----------User userAccountDetails response is $userAccountjsonBodyData');
    }
    _userController.setUser = userDetails;
    final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
    _userController.setUserAccountDetails = userAccountDetails;

    final userBusinessDetailsjsonBodyData =
    response?.data['data']['business_detail']['profile'];

    if (userBusinessDetailsjsonBodyData.length != 0) {
      final returnedCompanies = userBusinessDetailsjsonBodyData
          .map<Profile>((profile) => Profile.fromJson(profile))
          .toList();
      final companyDetails =
      Profile.fromJson(userBusinessDetailsjsonBodyData[0]);
      _companyController.companies = returnedCompanies;
      _companyController.setCompany = companyDetails;
    }
  }


  Future<void> forgotPassword({required String emailOrPassword,required BuildContext context})async{
    progressIndicator(context);
    try{
      var postBody = jsonEncode({
        'username': emailOrPassword,
      });
      final response = await NetworkProvider().call(path: "/v1/user/forgot-password", method: RequestMethod.post, body: postBody);
      final responseMessage = ForgotPasswordResponse.fromJson(response!.data);
      Get.back();
      Get.to(()=>RecoverPasswordOTPScreen(
        email: emailOrPassword,
      ));
      Get.snackbar('Successful', responseMessage.data?.message ?? "Password reset code has been sent to your email" , colorText: Colors.white, backgroundColor: fagoGreenColor);
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


  Future<void> createNewPassword({required String id, required String password,required String confirmedPassword, required BuildContext context})async{
    progressIndicator(context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      var postBody = jsonEncode({
        'code': id,
        'password': password,
        'password_confirmation': confirmedPassword,
      });
      final response = await NetworkProvider().call(path: "/v1/user/create-new-password", method: RequestMethod.post, body: postBody);
      final payload = ResetPasswordResponse.fromJson(response?.data);
      await LocalCachedData.instance.cachePassword(password: confirmedPassword);
      Get.back();
      Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => const SignIn(),
          ), (route) => false);
      Get.snackbar('Successful', payload.data?.message ?? "Password reset successful", colorText: Colors.white, backgroundColor: fagoGreenColor);
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

  bool isSetUpPasswordLoading = false;

  Future<void> setUpPassword({required String identifier, required String password,required String confirmedPassword, required BuildContext context})async{
    isSetUpPasswordLoading = true;
    progressIndicator(context);
    update();
    try{
      var postBody = jsonEncode({
        'identifier': identifier,
        'password': password,
        'password_confirmation': confirmedPassword,
      });
      final response = await NetworkProvider().call(path: "/v1/user/new-user-password", method: RequestMethod.post, body: postBody);
      final payload = ResetPasswordResponse.fromJson(response?.data);
      isSetUpPasswordLoading = false;
      Get.back();
      update();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SetupPassCode(
              id: identifier,
            ),
          ),
        );
      });
      Get.snackbar('Successful', payload.data?.message ?? "Password reset code has been sent to your email", colorText: Colors.white, backgroundColor: fagoGreenColor);
    }on dio.DioError catch (err) {
      Get.back();
      isSetUpPasswordLoading = false;
      update();
      final errorMessage = Future.error(ApiError.fromDio(err));
      update();
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      isSetUpPasswordLoading = false;
      update();
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      update();
      throw err.toString();
    }
  }

  Future<void> resetPasscodeFromProfile({required String oldPassCode, required String newPassCode, required confirmPassCode, required BuildContext context})async{
    progressIndicator(context);
    try{
      var postBody = jsonEncode({
        "new_passcode": newPassCode,
        "confirm_passcode": confirmPassCode,
        "old_passcode": oldPassCode,
      });
      final response = await NetworkProvider().call(path: "/v1/user/reset-passcode", method: RequestMethod.post, body: postBody);
      final payload = ResetPasscodeResponse.fromJson(response!.data);
      Get.back();
      Get.back();
      Get.snackbar('Success', payload.data?.message ?? 'Passcode has been reset successfully', colorText: Colors.white, backgroundColor: fagoGreenColor);
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

  Future<void> validateForgotResetPassword({required String otp, required BuildContext context})async{
    progressIndicator(context);
    _otpForgotVerifyStatus(OtpForgotVerifyStatus.loading);
    try{
      var postBody = jsonEncode({
        'code': otp,
      });
      final response = await NetworkProvider().call(path: "/v1/verify/password-reset-code", method: RequestMethod.post, body: postBody);
      final payload = VerifyResetPasswordResponse.fromJson(response?.data);
      Get.back();
      _otpForgotVerifyStatus(OtpForgotVerifyStatus.success);
      Get.offAll(() => ResetPasswordScreen(
        pinCode: payload.data!.code!,
      ));
      Get.snackbar('Success', payload.message ?? 'Password reset validated successfully!');
    }on dio.DioError catch (err) {
      Get.back();
      _otpForgotVerifyStatus(OtpForgotVerifyStatus.error);
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw errorMessage;
    } catch (err) {
      Get.back();
      _otpForgotVerifyStatus(OtpForgotVerifyStatus.error);
      Get.snackbar('Something Went Wrong',err.toString(), colorText: Colors.white, backgroundColor: fagoSecondaryColor);
      throw err.toString();
    }
  }


  bool? onGetDisputeReasonLoadingState;
  bool? onGetDisputeResponseErrorState;
  DisputeReasonResponse? disputeReasonResponse;
  Future<void> getDisputeReason()async{
    onGetDisputeReasonLoadingState = true;
    onGetDisputeResponseErrorState = false;
    disputeReasonResponse = null;
    update();
    try{
      final response = await NetworkProvider().call(path: "/v1/disputereason", method: RequestMethod.get);
      disputeReasonResponse = DisputeReasonResponse.fromJson(response!.data);
      onGetDisputeReasonLoadingState = false;
      onGetDisputeResponseErrorState = false;
      update();
    }on dio.DioError catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      onGetDisputeReasonLoadingState = false;
      onGetDisputeResponseErrorState = true;
      update();
      throw errorMessage;
    } catch (err) {
      onGetDisputeReasonLoadingState = false;
      onGetDisputeResponseErrorState = true;
      update();
      throw err.toString();
    }
  }


  Future<void> createDispute({required String reasonId, required String email, required String description, String? referenceCode, required String documentUrl, required BuildContext context})async{
    progressIndicator(context);
    try{
      var postBody = jsonEncode({
        "reason_id": reasonId,
        "email": email,
        "reference_code": referenceCode ?? "",
        "description": description,
        "document_url": documentUrl
      });
      final response = await NetworkProvider().call(path: "/v1/dispute", method: RequestMethod.post, body: postBody);
      Get.back();
      Get.snackbar('Success', response?.data["message"] ?? 'Dispute created successful', colorText: Colors.white, backgroundColor: fagoGreenColor);
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

  Future<bool> checkBiometric() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    final String? password = await LocalCachedData.instance.getPassword();
    final  status = await LocalCachedData.instance.getEnableBiometricStatus();
    log("This is the status $status");
    log("This can authenticate $canAuthenticate");
    log("This is password $password");
    final biometricStatus = canAuthenticate && status!  && password != null;
    update();
    return biometricStatus;
  }



  @override
  void onInit() {
    // getDisputeReason();
    super.onInit();
  }
}
