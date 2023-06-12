import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
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

  Functions function = Functions();
  //final _registrationController = Get.find<RegistrationController>();
  // final TextEditingController _pinController = TextEditingController();
  TextEditingController oldPasscodeController = TextEditingController(text: "");
  TextEditingController newPasscodeController = TextEditingController(text: "");
  TextEditingController confirmPasscodeController = TextEditingController(text: "");
  String thisText = "";
  String? otpText;
  int pinLength = 4;
  bool hasError = false;
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    // _registrationController.passCode.clear();
    // _registrationController.passCodeConfirm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:  Scaffold(
     body:  isLoading?const Center(child: LoadingWidget(color: fagoSecondaryColor)):Padding(
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
                    const AutoSizeText(
                      'Enter Old Passcode',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    pinCode(oldPasscodeController),
                    SizedBox(
                      height: 3.h,
                    ),

                    const Divider(
                      color: stepsColor,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      'Enter Passcode',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    pinCode(newPasscodeController),

                    SizedBox(
                      height: 4.h,
                    ),
                    const AutoSizeText(
                      'Confirm Passcode',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: welcomeText,
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
                          Get.snackbar('Error', oldPasscodeController.text.isEmpty?'Old Passcode is required':'Old sPasscode must be 4 letters');
                        }else if(newPasscodeController.text.isEmpty){
                          Get.snackbar('Error', newPasscodeController.text.isEmpty?'New Passcode is required':'New Passcode must be 4 letters');
                        }if(confirmPasscodeController.text.isEmpty){
                          Get.snackbar('Error', confirmPasscodeController.text.isEmpty?'Confirm Passcode is required':'Confirm Passcode must be 4 letters');
                        }  else if(newPasscodeController.text != confirmPasscodeController.text){
                          Get.snackbar('Error', 'New Passcode and confirm passcode does not match');
                        }
                        else{
                          _uploadData();
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
    ),
    );
  }
  Widget pinCode(TextEditingController controller){
    return PinCodeTextField(
      pinBoxOuterPadding:
      EdgeInsets.symmetric(horizontal: 0.3.h),
      pinBoxRadius: 0,
      autofocus: true,
      controller: controller,
      hideCharacter: true,
      highlight: true,
      highlightColor: stepsColor,
      defaultBorderColor: fagoSecondaryColor,
      hasTextBorderColor: stepsColor,
      highlightPinBoxColor: Colors.white,
      maxLength: 4,
      hasError: hasError,
      maskCharacter: '*',
      // onTextChanged: (text) {
      //   setState(() {
      //     hasError = false;
      //   });
      // },
      // onDone: (text) {
      //   otpText = text;
      //   print("DONE $otpText");
      // },
      pinBoxWidth: 6.h,
      pinBoxHeight: 6.h,
      hasUnderline: false,
      pinBoxDecoration:
      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: const TextStyle(fontSize: 15.0),
      pinTextAnimatedSwitcherTransition:
      ProvidedPinBoxTextAnimation.scalingTransition,
      //                    pinBoxColor: Colors.green[100],
      pinTextAnimatedSwitcherDuration:
      const Duration(milliseconds: 300),
      //                    highlightAnimation: true,
      highlightAnimationBeginColor: Colors.black,
      highlightAnimationEndColor: Colors.white12,
      keyboardType: TextInputType.number,
    );
  }
  _uploadData(){
    // final progress = ProgressHUD.of(context);
    // progress!.show();
    setState(() {
      isLoading = true;
    });
    var body = {
      "new_passcode": newPasscodeController.text.trim(),
      "confirm_passcode": confirmPasscodeController.text.trim(),
      "old_passcode": oldPasscodeController.text.trim(),
    };
    LoginController().changePassCode(body).then((value) {
      print(value.body);
      var data = jsonDecode(value.body);
      if(data['data']['code']== 200){
        Get.snackbar('Success', 'Passcode has been reset successfully',backgroundColor: fagoGreenColor,colorText: white);
        Navigator.pop(context);
      }else{
        Get.snackbar('Success', data['data']['error'],backgroundColor: fagoSecondaryColor,colorText: white);
      }
      setState(() {
        isLoading = false;
      });
    //  progress.dismiss();
    });
  }
}
