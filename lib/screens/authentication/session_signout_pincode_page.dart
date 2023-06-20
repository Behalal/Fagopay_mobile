import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SessionSignOutPinCodePage extends StatefulWidget {
  const SessionSignOutPinCodePage({super.key});

  @override
  State<SessionSignOutPinCodePage> createState() => _SessionSignOutPinCodePageState();
}

class _SessionSignOutPinCodePageState extends State<SessionSignOutPinCodePage> {
  final passCode = TextEditingController();

  Future<dio.Response<dynamic>?> validatePasscode({required String passcode, required BuildContext context})async{
    progressIndicator(context);
    Get.put<LocalCachedData>(await LocalCachedData.create());
    try{
      var postBody = jsonEncode({
        "passcode": passcode
      });
      final response = await NetworkProvider().call(path: "/v1/user/validate-login-with-passcode", method: RequestMethod.post, body: postBody);
      final token = response?.data["token"];
      Get.back();
      Get.back();
      await LocalCachedData.instance.cacheAuthToken(token: token);
      SecureStorage.setUserToken(token);
      Get.snackbar('Success', response?.data["massage"] ?? 'Passcode validated successfully!');
      return response;
    }on dio.DioError catch (err) {
      if(err.response?.data["data"]["error"] == "Token is Expired"){
        Get.back();
        Get.offAll(()=>const SignIn());
      }else{
        Get.back();
        Get.snackbar('Error', err.response?.data['data']['error']);
      }
      final errorMessage = Future.error(ApiError.fromDio(err));
      throw errorMessage;
    } catch (err) {
      if(err.toString() == "Token is Expired"){
        Get.back();
        Get.offAll(()=>const SignIn());
        Get.snackbar('Something Went Wrong',err.toString());
      }else{
        Get.back();
        Get.snackbar('Something Went Wrong',err.toString());
      }
      throw err.toString();
    }
  }
  final bool _allow = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(_allow);
      },
      child: SafeArea(top: false, bottom: false,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Positioned(
                      top: -100,
                      right: 180.69,
                      width: 415.19,
                      height: 480.92,
                      child: Transform.rotate(
                        angle: 134.28,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: signRectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: signRectangle,
                                  blurRadius: 2,
                                  // offset: Offset(
                                  //   -10.0, // Move to right 10  horizontally
                                  //   20.0, // Move to bottom 10 Vertically
                                  // ),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                topLeft: Radius.circular(100),
                              )),
                        ),
                      )),
                  Positioned(
                    top: 50,
                    left: 3.w,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      width: 371,
                      height: 208,
                      decoration: const BoxDecoration(
                        // image: svgDecorationImage("assets/images/image1.svg")),
                          image: DecorationImage(
                              image: AssetImage("assets/images/image1.png"))),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Positioned(
                            top: 35.66,
                            left: 8,
                            child:
                            SvgPicture.asset("assets/images/Frame.svg"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 41.h,
                    left: 12.w,
                    child: SizedBox(
                      width: 70.w,
                      child: const AutoSizeText(
                        "Security",
                        style: TextStyle(
                          color: signInText,
                          fontFamily: "Work Sans",
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 47.h,
                    left: 12.w,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 70.w,
                          child: const Text(
                            "Enter PassCode",
                            style: TextStyle(
                                color: welcomeText,
                                fontFamily: "Work Sans",
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 2.5.w),
                          child: SizedBox(
                            width: 80.w,
                            child: const AutoSizeText(
                              "Passcode is a tier-2 security level to help verify your identity after leaving the app for a while.",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: inactiveTab,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 55.h,
                    left: 12.w,
                    right: 12.w,
                    child: Padding(
                        padding: EdgeInsets.only(left: 4.w, right: 4.w),
                        child: PinCodeTextField(
                          obscureText: true,
                          controller: passCode,
                          length: 4,
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
                          onChanged: (String value) {
                            if (value != passCode.text) {

                            }
                          },
                        )),
                  ),
                  Positioned(
                    top: 70.h,
                    left: 12.w,
                    right: 12.w,
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                      child: GestureDetector(
                        onTap: () async {
                          if (passCode.text.isEmpty) {
                            Get.snackbar("Error","Kindly enter your password");
                          } else {
                            validatePasscode(passcode: passCode.text, context: context);
                          }
                        },
                        child: AuthButtons(
                          color: fagoSecondaryColor,
                          text: "Continue", form: true,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 91.h,
                    left: 12.w,
                    right: 12.w,
                    child: SizedBox(
                      width: 280,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Token Expired?",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: signInPlaceholder,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const SignIn()));
                            }),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: buttonColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
