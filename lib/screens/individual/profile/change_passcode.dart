import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sizer/sizer.dart';

import '../../../functions/functions.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../widgets/head_style_extra_pages.dart';

class ChangePassCode extends StatefulWidget {
  const ChangePassCode({super.key});

  @override
  State<ChangePassCode> createState() => _ChangePassCodeState();
}

class _ChangePassCodeState extends State<ChangePassCode> {
  final bool _passvisibility = false;
  final bool _confirmpassvisibility = false;
  final bool _requirementMet = false;
  final bool _isLoading = false;
  Functions function = Functions();
  //final _registrationController = Get.find<RegistrationController>();
  // final TextEditingController _pinController = TextEditingController();
  TextEditingController oldPasscodeController = TextEditingController(text: "");
  TextEditingController newPasscodeController = TextEditingController(text: "");
  TextEditingController confirmPasscodeController =
      TextEditingController(text: "");
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      PinCodeTextField(
                        pinBoxOuterPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        pinBoxRadius: 0,
                        autofocus: true,
                        controller: oldPasscodeController,
                        hideCharacter: true,

                        highlight: true,
                        highlightColor: stepsColor,
                        defaultBorderColor: fagoSecondaryColor,
                        hasTextBorderColor: stepsColor,
                        highlightPinBoxColor: Colors.white,
                        maxLength: 6,
                        hasError: hasError,
                        maskCharacter: '*',
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          otpText = text;
                          print("DONE $otpText");
                        },
                        pinBoxWidth: 52,
                        pinBoxHeight: 52,
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
                      ),
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
                      PinCodeTextField(
                        pinBoxOuterPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        pinBoxRadius: 0,
                        autofocus: true,
                        controller: newPasscodeController,
                        hideCharacter: true,
                        highlight: true,
                        highlightColor: stepsColor,
                        defaultBorderColor: fagoSecondaryColor,
                        hasTextBorderColor: stepsColor,
                        highlightPinBoxColor: Colors.white,
                        maxLength: 6,
                        hasError: hasError,
                        maskCharacter: '*',
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          otpText = text;
                          print("DONE $otpText");
                        },
                        pinBoxWidth: 52,
                        pinBoxHeight: 52,
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
                      ),
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
                      PinCodeTextField(
                        pinBoxOuterPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        pinBoxRadius: 0,
                        autofocus: true,
                        controller: confirmPasscodeController,
                        hideCharacter: true,
                        highlight: true,
                        highlightColor: stepsColor,
                        defaultBorderColor: fagoSecondaryColor,
                        hasTextBorderColor: stepsColor,
                        highlightPinBoxColor: Colors.white,
                        maxLength: 6,
                        hasError: hasError,
                        maskCharacter: '*',
                        onTextChanged: (text) {
                          setState(() {
                            hasError = false;
                          });
                        },
                        onDone: (text) {
                          otpText = text;
                          print("DONE $otpText");
                        },
                        pinBoxWidth: 52,
                        pinBoxHeight: 52,
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
                      ),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                      //     child: PinCodeTextField(
                      //       obscureText: true,
                      //       controller: _registrationController.passCode,
                      //       length: 4,
                      //       appContext: context,
                      //       pastedTextStyle: const TextStyle(
                      //         fontFamily: "Work Sans",
                      //         fontSize: 36,
                      //         color: inactiveTab,
                      //       ),
                      //       keyboardType: TextInputType.number,
                      //       pinTheme: PinTheme(
                      //         shape: PinCodeFieldShape.box,
                      //         borderRadius: BorderRadius.circular(5),
                      //         fieldHeight: 50,
                      //         fieldWidth: 50,
                      //         activeFillColor: Colors.white,
                      //       ),
                      //       onChanged: (String value) {
                      //         if (value !=
                      //             _registrationController
                      //                 .passCodeConfirm.text) {
                      //           setState(() {
                      //             _requirementMet = false;
                      //           });
                      //         } else {
                      //           setState(() {
                      //             _requirementMet = true;
                      //           });
                      //         }
                      //       },
                      //     )),
                      // SizedBox(
                      //   height: 3.h,
                      // ),
                      // Padding(
                      //     padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                      //     child: PinCodeTextField(
                      //       controller: _registrationController.passCodeConfirm,
                      //       obscureText: true,
                      //       length: 4,
                      //       appContext: context,
                      //       pastedTextStyle: const TextStyle(
                      //         fontFamily: "Work Sans",
                      //         fontSize: 36,
                      //         color: inactiveTab,
                      //       ),
                      //       keyboardType: TextInputType.number,
                      //       pinTheme: PinTheme(
                      //         shape: PinCodeFieldShape.box,
                      //         borderRadius: BorderRadius.circular(5),
                      //         fieldHeight: 50,
                      //         fieldWidth: 50,
                      //         activeFillColor: Colors.white,
                      //       ),
                      //       onChanged: (String value) {
                      //         if (value !=
                      //             _registrationController.passCode.text) {
                      //           setState(() {
                      //             _requirementMet = false;
                      //           });
                      //         } else {
                      //           setState(() {
                      //             _requirementMet = true;
                      //           });
                      //         }
                      //       },
                      //     )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: AuthButtons(
                          form: false,
                          text: "Update",
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10.w, vertical: 3.h),
                      //   child: GestureDetector(
                      //     onTap: () async {
                      //       if (_registrationController.passCode.text.isEmpty ||
                      //           _registrationController
                      //               .passCodeConfirm.text.isEmpty) {
                      //         // SweetAlertV2.show(context,
                      //         //     title: "Kindly enter your password",
                      //         //     style: SweetAlertV2Style.error,
                      //         //     titleStyle: const TextStyle(
                      //         //       fontFamily: "Work Sans",
                      //         //       fontSize: 10,
                      //         //       fontWeight: FontWeight.w400,
                      //         //     ));
                      //         // ScaffoldMessenger.of(context).showSnackBar(
                      //         //   const SnackBar(
                      //         //     content: Text('Kindly enter your password'),
                      //         //   ),
                      //         // );
                      //         Fluttertoast.showToast(
                      //           msg: "Kindly enter your password",
                      //           toastLength: Toast.LENGTH_LONG,
                      //           gravity: ToastGravity.TOP,
                      //           timeInSecForIosWeb: 2,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0,
                      //         );
                      //       } else if (_registrationController.passCode.text !=
                      //           _registrationController.passCodeConfirm.text) {
                      //         // ScaffoldMessenger.of(context).showSnackBar(
                      //         //   const SnackBar(
                      //         //     content: Text('Passcode does not match'),
                      //         //   ),
                      //         // );
                      //         Fluttertoast.showToast(
                      //           msg: "Passcode does not match",
                      //           toastLength: Toast.LENGTH_LONG,
                      //           gravity: ToastGravity.TOP,
                      //           timeInSecForIosWeb: 2,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0,
                      //         );
                      //       } else {
                      //         setState(() {
                      //           _isLoading = true;
                      //         });
                      //         await setPassCode(context);
                      //       }
                      //     },
                      //     child: AuthButtons(
                      //       hasImage: (_isLoading)
                      //           ? "assets/images/loader.gif"
                      //           : null,
                      //       color: (_isLoading || !_requirementMet)
                      //           ? signInPlaceholder
                      //           : null,
                      //       imageWidth: (_isLoading) ? 50 : null,
                      //       imageheight: (_isLoading) ? 30 : null,
                      //       form: true,
                      //       text: (_isLoading) ? "" : "Continue",
                      //     ),
                      //   ),
                      // )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> setPassCode(BuildContext context) async {
  //   final response = await _registrationController.setPassCode();

  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     Fluttertoast.showToast(
  //       msg: "Error setting up Passcode!",
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.TOP,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );

  // ScaffoldMessenger.of(context).showSnackBar(
  //   const SnackBar(
  //     content: Text('Error setting up Passcode!'),
  //   ),
  // );
//       return;
//     }
//     Fluttertoast.showToast(
//       msg: "Pin successfully set",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.TOP,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//     // ScaffoldMessenger.of(context).showSnackBar(
//     //   const SnackBar(
//     //     content: Text('Pin successfully set'),
//     //   ),
//     // );
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {});
//     });
//   }
}
