import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import '../../constants/colors.dart';
import '../widgets/auth_buttons.dart';
import 'setup_passcode.dart';
import 'widgets/current_step.dart';

class SetupPassword extends StatefulWidget {
  final String identifier;
  const SetupPassword({
    super.key,
    required this.identifier,
  });

  @override
  State<SetupPassword> createState() => _SetupPasswordState();
}

class _SetupPasswordState extends State<SetupPassword> {
  bool _passvisibility = false;
  bool _confirmpassvisibility = false;
  bool _passRequirementMet = false;
  bool _upto8Characters = false;
  bool _numbers = false;
  bool _lowerCase = false;
  bool _upperCase = false;
  bool _symbolSpecial = false;
  Functions function = Functions();
  final _registrationController = Get.find<RegistrationController>();
  final _loginController = Get.find<LoginController>();

  @override
  void dispose() {
    _registrationController.lastname.clear();
    _registrationController.email.clear();
    _registrationController.phone.clear();
    _registrationController.referral.clear();
    _registrationController.password.clear();
    _registrationController.confirmPassword.clear();
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
                      "Setup Password",
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
                      "Provide a strong password to secure your account",
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
                  height: 3.h,
                ),
                SizedBox(
                  height: 56,
                  width: 341,
                  child: TextFormField(
                    controller: _registrationController.password,
                    onChanged: ((value) {
                      if (value.length >= 8) {
                        setState(() {
                          _upto8Characters = true;
                        });
                      } else {
                        setState(() {
                          _upto8Characters = false;
                        });
                      }

                      if (function.checkLoweCase(value)) {
                        setState(() {
                          _lowerCase = true;
                        });
                      } else {
                        setState(() {
                          _lowerCase = false;
                        });
                      }

                      if (function.checknumbers(value)) {
                        setState(() {
                          _numbers = true;
                        });
                      } else {
                        setState(() {
                          _numbers = false;
                        });
                      }

                      if (function.checkUpperCase(value)) {
                        setState(() {
                          _upperCase = true;
                        });
                      } else {
                        setState(() {
                          _upperCase = false;
                        });
                      }

                      if (function.specialCharacters(value)) {
                        setState(() {
                          _symbolSpecial = true;
                        });
                      } else {
                        setState(() {
                          _symbolSpecial = false;
                        });
                      }
                      if (checkRequirement(value) && value == _registrationController.confirmPassword.text) {
                        setState(() {
                          _passRequirementMet = true;
                        });
                      } else {
                        setState(() {
                          _passRequirementMet = false;
                        });
                      }
                    }),
                    obscureText: !_passvisibility,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: const Image(
                            image:
                                AssetImage("assets/images/password_icon.png")),
                        suffixIcon: IconButton(
                          icon: (_passvisibility)
                              ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                          onPressed: () {
                            setState(() {
                              _passvisibility = !_passvisibility;
                            });
                          },
                        )),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 56,
                  width: 341,
                  child: TextFormField(
                    controller: _registrationController.confirmPassword,
                    onChanged: (value) {
                      if (value != _registrationController.password.text &&
                          !checkRequirement(
                              _registrationController.password.text)) {
                        setState(() {
                          _passRequirementMet = false;
                        });
                      } else {
                        setState(() {
                          _passRequirementMet = true;
                        });
                      }
                    },
                    obscureText: !_confirmpassvisibility,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                        prefixIcon: const Image(
                            image:
                                AssetImage("assets/images/password_icon.png")),
                        suffixIcon: IconButton(
                          icon: (_confirmpassvisibility)
                              ? const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  size: 20,
                                ),
                          onPressed: () {
                            setState(() {
                              _confirmpassvisibility = !_confirmpassvisibility;
                            });
                          },
                        )),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 45.w,
                        height: 4.h,
                        decoration: const BoxDecoration(
                            color: passGuideBg,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 0.4.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check_circle_outline_sharp,
                                color: (_upto8Characters)
                                    ? requirementMet
                                    : requirementNotMet,
                                size: 15,
                              ),
                              SizedBox(
                                width: 40.w,
                                child: const AutoSizeText(
                                  "At least 8 characters strong",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(width: 0.7.w),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          color: passGuideBg,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 0.4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.check_circle_outline_sharp,
                              color: (_lowerCase)
                                  ? requirementMet
                                  : requirementNotMet,
                              size: 15,
                            ),
                            SizedBox(
                              width: 35.w,
                              child: const AutoSizeText(
                                "One lower case character",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 25.w,
                        height: 4.h,
                        decoration: const BoxDecoration(
                            color: passGuideBg,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 0.4.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.check_circle_outline_sharp,
                                color: (_upperCase)
                                    ? requirementMet
                                    : requirementNotMet,
                                size: 15,
                              ),
                              SizedBox(
                                width: 20.w,
                                child: const AutoSizeText(
                                  "One upper case ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 1.w,
                    ),
                    Container(
                      width: 25.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          color: passGuideBg,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 0.4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.check_circle_outline_sharp,
                              color: (_numbers)
                                  ? requirementMet
                                  : requirementNotMet,
                              size: 15,
                            ),
                            SizedBox(
                              width: 20.w,
                              child: const AutoSizeText(
                                "One number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    width: 50.w,
                    height: 4.h,
                    decoration: const BoxDecoration(
                        color: passGuideBg,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.check_circle_outline_sharp,
                          color: (_symbolSpecial)
                              ? requirementMet
                              : requirementNotMet,
                          size: 15,
                        ),
                        SizedBox(
                          width: 45.w,
                          child: const AutoSizeText(
                            "A symbol or special character",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Nunito",
                                color: black,
                                fontSize: 7,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: GestureDetector(
                    onTap: () async {
                      if (_registrationController.password.text.isEmpty ||
                          _registrationController
                              .confirmPassword.text.isEmpty) {
                        Get.snackbar("Error","Kindly enter your password");
                      } else if (_registrationController.password.text !=
                          _registrationController.confirmPassword.text) {
                        Get.snackbar("Error","Password does not match");
                      } else {
                        print('code is ${_registrationController.password.text.trim()}');
                        print(widget.identifier);
                        await _loginController.setUpPassword(identifier: widget.identifier,
                          password: _registrationController.confirmPassword.text,
                          confirmedPassword: _registrationController.confirmPassword.text, context: context
                        );
                      }
                    },
                    child: AuthButtons(
                        hasImage:
                            (_loginController.isSetUpPasswordLoading) ? "assets/images/loader.gif" : null,
                        color: (_loginController.isSetUpPasswordLoading || !_passRequirementMet)
                            ? signInPlaceholder
                            : null,
                        imageWidth: (_loginController.isSetUpPasswordLoading) ? 50 : null,
                        imageheight: (_loginController.isSetUpPasswordLoading) ? 30 : null,
                        form: true,
                        text: (_loginController.isSetUpPasswordLoading) ? "" : "Continue",
                        route: SetupPassCode(
                          id: widget.identifier,
                        )),
                  ),
                )
              ]),
        ),
      )),
    );
  }

  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) && function.checkUpperCase(value) && function.checknumbers(value) && function.specialCharacters(value) && value.length >= 8);

    return met;
  }
}
