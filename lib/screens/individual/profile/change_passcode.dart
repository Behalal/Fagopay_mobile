import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/login_controller.dart';
import '../../../functions/functions.dart';
import '../../authentication/recover_password_otp_screen.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';

class ChangePassCode extends StatefulWidget {
  const ChangePassCode({super.key});

  @override
  State<ChangePassCode> createState() => _ChangePassCodeState();
}

class _ChangePassCodeState extends State<ChangePassCode> {
  TextEditingController oldPasscodeController = TextEditingController();
  TextEditingController newPasscodeController = TextEditingController();
  TextEditingController confirmPasscodeController = TextEditingController();
  String thisText = "";
  String? otpText;
  int pinLength = 4;
  bool hasError = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    oldPasscodeController.dispose();
    newPasscodeController.dispose();
    confirmPasscodeController.dispose();
    super.dispose();
  }

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
        child: Column(
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "Edit Profile",
              // backRoute: MakeRequest(),
            ),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 5.h),
                      const AutoSizeText(
                        "Create New Passcode",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 4.h,
                      ),
                      const Align(alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Enter Old Passcode',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: welcomeText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      pinCode(oldPasscodeController),
                      const Divider(
                        color: stepsColor,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const Align(alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Enter Passcode',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: welcomeText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      pinCode(newPasscodeController),

                      SizedBox(
                        height: 1.h,
                      ),
                      const Align(alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          'Confirm Passcode',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: welcomeText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      pinCode(confirmPasscodeController),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(oldPasscodeController.text.isEmpty  || oldPasscodeController.text.length <4 ){
                            Get.snackbar('Error', oldPasscodeController.text.isEmpty?'Old Passcode is required':'Old sPasscode must be 4 letters', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                          }else if(newPasscodeController.text.isEmpty){
                            Get.snackbar('Error', newPasscodeController.text.isEmpty?'New Passcode is required':'New Passcode must be 4 letters', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                          }if(confirmPasscodeController.text.isEmpty){
                            Get.snackbar('Error', confirmPasscodeController.text.isEmpty?'Confirm Passcode is required':'Confirm Passcode must be 4 letters', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                          }  else if(newPasscodeController.text != confirmPasscodeController.text){
                            Get.snackbar('Error', 'New Passcode and confirm passcode does not match', colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                          } else{
                            loginController.resetPasscodeFromProfile(oldPassCode: oldPasscodeController.text,
                                newPassCode: newPasscodeController.text, confirmPassCode: confirmPasscodeController.text, context: context);
                          }
                        },
                        child: Center(
                          child: AuthButtons(
                            form: true,
                            text: "Update",
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget pinCode(TextEditingController controller){
    return Padding(
        padding: EdgeInsets.only(left: 2.w, right: 5.w),
        child: PinCodeTextField(
          obscureText: true,
          controller: controller,
          length: 4,
          autoDisposeControllers: false,
          appContext: context,
          pastedTextStyle: const TextStyle(
            fontFamily: "Work Sans",
            fontSize: 36,
            color: inactiveTab,
          ),
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(2),
            fieldHeight: 50,
            fieldWidth: 50,
            activeFillColor: Colors.white,
          ),
          onChanged: (String value) {
          },
        ));
  }
}
