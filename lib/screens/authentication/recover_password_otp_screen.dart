// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/screens/widgets/showDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class RecoverPasswordOTPScreen extends StatefulWidget {
  final String email;

  const RecoverPasswordOTPScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<RecoverPasswordOTPScreen> createState() =>
      _RecoverPasswordOTPScreenState();
}

class _RecoverPasswordOTPScreenState extends State<RecoverPasswordOTPScreen> {
  final authController = Get.put(LoginController());
  final _loginController = Get.find<LoginController>();
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  String? otpText;
  int pinLength = 4;
  bool hasError = false;
  bool isLoading = false;
  String? errorMessage;

  // @override
  // void dispose() {
  //   _pinController.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
          color: fagoBlackColor,
        ),
        title: const Text(
          'Reset Password',
          style: TextStyle(
            color: fagoSecondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Work Sans',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(
              color: fagoSecondaryColor,
              backgroundColor: fagoSecondaryColorWithOpacity,
              minHeight: 1.75,
              value: 0.25,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Step 2 of 4',
                  style: TextStyle(
                    color: fagoBlackColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const SizedBox(height: 35),
            const Text(
              'Provide OTP',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Work Sans',
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'We sent OTP to ${widget.email}. Please check your inbox and enter the OTP received.',
              style: const TextStyle(
                color: fagoBlackColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kindly input the code below',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
                padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                child: PinCodeTextField(
                  length: 6, controller: controller,
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 36,
                    color: inactiveTab,
                  ),
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    activeColor: signInText,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                  ),
                  onChanged: (String value) async {
                    if (value.length == 6) {
                      otpText = controller.text;
                      print(otpText);
                    }
                  },
                )),
            // PinCodeTextField(
            //   controller: _pinController,
            //   appContext: context,
            //   length: 6,
            //   onChanged: (value) {
            //     if (value.length == 6) {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => ResetPasswordScreen(pinCode: value),
            //         ),
            //       );
            //     }
            //   },
            //   keyboardType: TextInputType.number,
            //   pinTheme: PinTheme(
            //     shape: PinCodeFieldShape.box,
            //     fieldHeight: 45,
            //     fieldWidth: 45,
            //     activeFillColor: Colors.white,
            //   ),
            // ),
            // const SizedBox(height: 5),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Didn\'t recieve an otp?',
                    style: TextStyle(
                      color: fagoSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                const Icon(
                  Icons.refresh,
                  size: 15,
                  color: fagoSecondaryColor,
                ),
                TextButton(
                  onPressed: () {
                    showExpiredsessionDialog(context, "Do you want to request that you receive another OTP", "Resend OTP", () async {
                      Get.back();
                      await _loginController.forgotPassword(emailOrPassword: _loginController.forgotPasswordController.text, context: context);
                    });
                  },
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                      color: fagoSecondaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                log(otpText.toString());
                if (otpText == null || otpText == '' || otpText?.length != 6) {
                  Get.snackbar("Alert",
                      "Enter the otp sent to ${authController.emailController.text} to continue!");
                } else {
                  authController.validateForgotResetPassword(otp: otpText! , context: context);
                }
              },
              child: Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(36),
                    color: fagoSecondaryColor,
                  ),
                  child: const Center(
                    child: AutoSizeText(
                      "Continue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w600,
                          color: white),
                    ),
                  )
              ),
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
            //   alignment: Alignment.center,
            //   decoration: const BoxDecoration(
            //       color: buttonColor,
            //       borderRadius: BorderRadius.all(Radius.circular(25))),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: const [
            //       AutoSizeText(
            //         "Continue",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontFamily: "Work Sans",
            //             fontWeight: FontWeight.w600,
            //             color: white),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final double? size;
  const LoadingWidget({Key? key, this.color = Colors.white, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 20,
      height: size ?? 20,
      child: Center(
          heightFactor: 1,
          widthFactor: 1,
          child:
          //Platform.isIOS ?
        CupertinoActivityIndicator(
                  color: color,
                )
              // : CircularProgressIndicator(
              //     color: color,
              //   )
      ),
    );
  }
}
