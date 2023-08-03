// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;
import 'package:fagopay/models/user_model/user.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:fagopay/screens/authentication/account_creation/setup_password.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/screens/widgets/showDialog.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart' as dio;
import '../../../controllers/registration_controller.dart';
import '../../constants/colors.dart';
import '../../widgets.dart';
import 'select_verification_type.dart';
import 'widgets/current_step.dart';

class VerifyCodeSent extends StatefulWidget {
  const VerifyCodeSent(
      {Key? key,
      required this.userVerificationData,
      this.verificationType,
      required this.userIdentifier, this.isLogin})
      : super(key: key);

  final String userVerificationData;
  final VerificationType? verificationType;
  final String userIdentifier;
  final bool? isLogin;

  @override
  State<VerifyCodeSent> createState() => _VerifyCodeSentState();
}

class _VerifyCodeSentState extends State<VerifyCodeSent> {
  bool isLoading = false;
  final _registrationController = Get.find<RegistrationController>();
  String? otpText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        child: (isLoading)
            ? const Loading()
            : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isLogin == true ?
            const Column(
              children: [
                Text("Otp Verification" ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: fagoSecondaryColor,
                    )),
                Divider(color: fagoSecondaryColor,),
              ],
            ) :
            CurrentStep(
                step: "2", backRoute: const SelectVerificationType()),
            SizedBox(height: 5.h),
            Padding(
                padding: EdgeInsets.only(left: 2.5.w),
                child: const AutoSizeText(
                  "Provide OTP",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                )),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.w),
              child: SizedBox(
                width: 80.w,
                child: AutoSizeText(
                  "We sent OTP to ${widget.userVerificationData}. Please check your inbox and enter the OTP received.",
                  style: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: inactiveTab,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.w),
              child: SizedBox(
                width: 60.w,
                child: const AutoSizeText(
                  "Kindly input the code below. ",
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: fagoSecondaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
                padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                child: PinCodeTextField(
                  length: 6,
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 36,
                    color: inactiveTab,
                  ),
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                  ),
                  onChanged: (String value) async {
                    if (value.length == 6) {
                      otpText = value;
                      setState(() {
                        isLoading = true;
                      });
                      // getUserDetails
                      widget.isLogin == true ? await twoFactorAuthentication(otp: otpText!).then((value) async {
                        await getUserDetails();
                      }) :
                      await validateUserOtp(
                        context,
                        userIdentifier: widget.userIdentifier,
                        code: value,
                      );
                    }
                  },
                )),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AutoSizeText(
                    "Didn’t receive an OTP?",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: fagoSecondaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Transform.rotate(
                        angle: -60 * (math.pi / 180),
                        child: const Icon(
                          size: 18,
                          Icons.replay,
                          textDirection: TextDirection.rtl,
                          color: fagoSecondaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          showExpiredsessionDialog(context, "Do you want to receive another OTP code?", "Resend OTP", () async {
                            Get.back();
                            widget.isLogin == true ? resendTwoFactorAuthOtp(context: context) : setUserAccount(context);
                          });
                        },
                        child: const AutoSizeText(
                          "Resend",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: fagoSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();

  Future<void> getUserDetails() async {
    Get.put<LocalCachedData>(await LocalCachedData.create());
    final response = await _loginController.getUserDetails();
    setState(() {
      isLoading = false;
    });
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
    if (!mounted) return;
    _loginController.emailController.clear();
    _loginController.passwordController.clear();
    await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: true);
    log("The user has loggedin ooooooooooooooo");
    Get.offAll(()=> const Dashboard());
  }

  void setUserAccount(BuildContext context) async {
    progressIndicator(context);
    try {
      final res = await _registrationController.selectAccountType();
      final jsonBody = jsonDecode(res.body);
      if (res.statusCode == 200) {
        Get.back();
        final registeredUserIdentifier = jsonBody['data']['identifier'];
        SecureStorage.setUserIdentifier(registeredUserIdentifier);
        Get.snackbar("Success","${jsonBody['message']}");
        if (!mounted) return;
        Get.back();
        return;
      }
      if (res.statusCode == 422) {
        Get.back();
        if (!mounted) return;
        Get.snackbar("Error","${jsonBody['data']['error']}");
        return;
      }   Get.back();
      Get.snackbar("Error","${jsonBody['data']['error']}");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> validateUserOtp(BuildContext context,
      {required String userIdentifier, required String code}) async {
    final response =
        await _registrationController.validateCode(userIdentifier, code);

    if (response.statusCode == 200) {
      
      if (kDebugMode) {
        print(response.body);
      }
       final jsonBody = jsonDecode(response.body);
      final validateUserIdentifier = jsonBody['data']['identifier'];
      SecureStorage.setUserIdentifier(validateUserIdentifier);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) =>  SetupPassword(identifier: validateUserIdentifier )),
      );
      return;
    }
   
    setState(() {
      isLoading = false;
    });
    Get.snackbar(
        'Error',
        'OTP is Invalid',);
  }


  Future<dio.Response<dynamic>?> twoFactorAuthentication({required String otp})async{
    try{
      var postBody = jsonEncode({
        "otp": otp
      });
      final response = await NetworkProvider().call(path: "/v1/verify/validate-2fa-otp", method: RequestMethod.post, body: postBody);
      return response;
    }on dio.DioError catch (err) {
      setState(() {
        isLoading = false;
      });
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }


  Future<dio.Response<dynamic>?> resendTwoFactorAuthOtp({required BuildContext context})async{
    progressIndicator(context);
    try{
      final response = await NetworkProvider().call(path: "/v1/verify/resend-2fa-otp", method: RequestMethod.get);
      Get.back();
      Get.snackbar('Success', response?.data['message'] ?? "Otp has been sent");
      return response;
    }on dio.DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      Get.back();
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }
}
