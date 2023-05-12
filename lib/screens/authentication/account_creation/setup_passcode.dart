import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import '../../constants/colors.dart';
import '../widgets/auth_buttons.dart';
import 'select_verification_type.dart';
import 'success_acount_creation.dart';
import 'widgets/current_step.dart';

class SetupPassCode extends StatefulWidget {
  final String id;
  const SetupPassCode({super.key, required this.id});

  @override
  State<SetupPassCode> createState() => _SetupPassCodeState();
}

class _SetupPassCodeState extends State<SetupPassCode> {
  final bool _passvisibility = false;
  final bool _confirmpassvisibility = false;
  bool _requirementMet = false;
  bool _isLoading = false;
  Functions function = Functions();
  final _registrationController = Get.find<RegistrationController>();

  @override
  void dispose() {
    _registrationController.passCode.clear();
    _registrationController.passCodeConfirm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentStep(
                    step: "4",
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                      padding: EdgeInsets.only(left: 2.5.w),
                      child: const AutoSizeText(
                        "Setup PassCode",
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
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                      child: PinCodeTextField(
                        obscureText: true,
                        controller: _registrationController.passCode,
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
                          if (value !=
                              _registrationController.passCodeConfirm.text) {
                            setState(() {
                              _requirementMet = false;
                            });
                          } else {
                            setState(() {
                              _requirementMet = true;
                            });
                          }
                        },
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                      child: PinCodeTextField(
                        controller: _registrationController.passCodeConfirm,
                        obscureText: true,
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
                          if (value != _registrationController.passCode.text) {
                            setState(() {
                              _requirementMet = false;
                            });
                          } else {
                            setState(() {
                              _requirementMet = true;
                            });
                          }
                        },
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                    child: GestureDetector(
                      onTap: () async {
                        if (_registrationController.passCode.text.isEmpty ||
                            _registrationController
                                .passCodeConfirm.text.isEmpty) {
                          // SweetAlertV2.show(context,
                          //     title: "Kindly enter your password",
                          //     style: SweetAlertV2Style.error,
                          //     titleStyle: const TextStyle(
                          //       fontFamily: "Work Sans",
                          //       fontSize: 10,
                          //       fontWeight: FontWeight.w400,
                          //     ));
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Kindly enter your password'),
                          //   ),
                          // );
                          Fluttertoast.showToast(
                            msg: "Kindly enter your password",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else if (_registrationController.passCode.text !=
                            _registrationController.passCodeConfirm.text) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Passcode does not match'),
                          //   ),
                          // );
                          Fluttertoast.showToast(
                            msg: "Passcode does not match",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          setState(() {
                            _isLoading = true;
                          });
                          await setPassCode(
                            context,
                            confirmedPasscode:
                                _registrationController.passCodeConfirm.text,
                            id: widget.id,
                            passcode: _registrationController.passCode.text,
                          );
                        }
                      },
                      child: AuthButtons(
                          hasImage:
                              (_isLoading) ? "assets/images/loader.gif" : null,
                          color: (_isLoading || !_requirementMet)
                              ? signInPlaceholder
                              : null,
                          imageWidth: (_isLoading) ? 50 : null,
                          imageheight: (_isLoading) ? 30 : null,
                          form: true,
                          text: (_isLoading) ? "" : "Continue",
                          route: const SuccessAccountCreation()),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> setPassCode(BuildContext context,
      {required String id,
      required String passcode,
      required String confirmedPasscode}) async {
    final response = await _registrationController.setPassCode(
        id, passcode, confirmedPasscode);
    print(response.body);
    final jsonBody = jsonDecode(response.body);
    final userToken = jsonBody['token'];
    if (response.statusCode != 200) {
      setState(() {
        _isLoading = false;
      });

      SecureStorage.setUserToken(userToken);
      if ((!mounted)) return;
      Fluttertoast.showToast(
        msg: "Pin successfully set",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Pin successfully set'),
      //   ),
      // );
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const SuccessAccountCreation(),
            ),
          );
        });
      });
    }
    Fluttertoast.showToast(
      msg: "Error setting up Passcode!",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Error setting up Passcode!'),
    //   ),
    // );
    return;
  }
}
