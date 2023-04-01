import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/repository/controllers/login_controller_provider.dart';
import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:fagopay/screens/authentication/account_creation/success_acount_creation.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class SetupPassCode extends StatefulWidget {
  const SetupPassCode({super.key});

  @override
  State<SetupPassCode> createState() => _SetupPassCodeState();
}

class _SetupPassCodeState extends State<SetupPassCode> {
  late bool passvisibility;
  late bool confirmpassvisibility;
  late bool requirementMet;
  late bool _isLoading;

  final TextEditingController passCode = TextEditingController();
  final TextEditingController passCodeConfirm = TextEditingController();

  Functions function = Functions();
  SecureStorage storage = SecureStorage();

  @override
  void initState() {
    passvisibility = false;
    confirmpassvisibility = false;
    requirementMet = false;
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
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
                CurrentStep(step: "4", backRoute: const SelectVerificationType()),
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
                        if (value != passCodeConfirm.text) {
                          setState(() {
                            requirementMet = false;
                          });
                        } else {
                          setState(() {
                            requirementMet = true;
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
                      controller: passCodeConfirm,
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
                          setState(() {
                            requirementMet = false;
                          });
                        } else {
                          setState(() {
                            requirementMet = true;
                          });
                        }
                      },
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: GestureDetector(
                    onTap: () {
                      // if (passCode.text.isEmpty || passCodeConfirm.text.isEmpty) {
                      //   // SweetAlertV2.show(context,
                      //   //     title: "Kindly enter your password",
                      //   //     style: SweetAlertV2Style.error,
                      //   //     titleStyle: const TextStyle(
                      //   //       fontFamily: "Work Sans",
                      //   //       fontSize: 10,
                      //   //       fontWeight: FontWeight.w400,
                      //   //     ));
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Kindly enter your password'),
                      //     ),
                      //   );
                      // } else if (passCode.text != passCodeConfirm.text) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Passcode does not match'),
                      //     ),
                      //   );
                      // } else {
                      //   setState(() {
                      //     _isLoading = true;
                      //   });
                      //   ref
                      //       .read(loginControllerProvider.notifier)
                      //       .setPassCode(passCode.text)
                      //       .then((value) {
                      //     if (value.code != null && value.code != 200) {
                      //       setState(() {
                      //         _isLoading = false;
                      //       });
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text(value.error!),
                      //         ),
                      //       );
                      //     } else {
                      //       // registrationData.setId = value.identifier!;
    
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text('Pin successfully set'),
                      //         ),
                      //       );
                      //       Future.delayed(const Duration(seconds: 3), () {
                      //         setState(() {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SuccessAccountCreation()));
                      //         });
                      //       });
                      //     }
                      //   });
                      // }
                    },
                    child: AuthButtons(
                        hasImage:
                            (_isLoading) ? "assets/images/loader.gif" : null,
                        color: (_isLoading || !requirementMet)
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
      )),
    );
  }
}
