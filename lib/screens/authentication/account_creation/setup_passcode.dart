

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import '../../constants/colors.dart';
import '../widgets/auth_buttons.dart';
import 'success_acount_creation.dart';
import 'widgets/current_step.dart';

class SetupPassCode extends StatefulWidget {
  final String id;
  const SetupPassCode({super.key, required this.id});

  @override
  State<SetupPassCode> createState() => _SetupPassCodeState();
}

class _SetupPassCodeState extends State<SetupPassCode> {
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
    print('the id is ${widget.id}');
    print('the passcode is ${_registrationController.passCode.text}');
    print(
        'the Confirmpasscode is ${_registrationController.passCodeConfirm.text}');
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
                  const Text(
                    "Enter passcode",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      color: stepsColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                  const Text(
                    "Confirm passcode",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 12,
                      color: stepsColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                          Get.snackbar("Error","Kindly enter your password");
                        } else if (_registrationController.passCode.text !=
                            _registrationController.passCodeConfirm.text) {
                          Get.snackbar("Error","Passcode does not match");
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
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });

      // SecureStorage.setUserToken(userToken);
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => const SuccessAccountCreation(),
            ),
          );
        });
      });
      if ((!mounted)) return;
      Get.snackbar("Success","Pin successfully set");
    }
    // Fluttertoast.showToast(
    //   msg: "Error setting up Passcode!",
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.TOP,
    //   timeInSecForIosWeb: 2,
    //   backgroundColor: Colors.red,
    //   textColor: Colors.white,
    //   fontSize: 16.0,
    // );

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Error setting up Passcode!'),
    //   ),
    // );
    return;
  }
}
