import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import '../../../service/secure_storage/secure_storage.dart';
import '../../constants/colors.dart';
import '../widgets/auth_buttons.dart';
import 'select_verification_type.dart';
import 'setup_passcode.dart';
import 'widgets/current_step.dart';

class SetupPassword extends StatefulWidget {
  final String id;
  const SetupPassword({
    super.key,
    required this.id,
  });

  @override
  State<SetupPassword> createState() => _SetupPasswordState();
}

class _SetupPasswordState extends State<SetupPassword> {
  bool _passvisibility = false;
  bool _confirmpassvisibility = false;
  bool _isLoading = false;
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

                      if (checkRequirement(value) &&
                          value ==
                              _registrationController.confirmPassword.text) {
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
                      } else if (_registrationController.password.text !=
                          _registrationController.confirmPassword.text) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Password does not match'),
                        //   ),
                        // );
                        Fluttertoast.showToast(
                          msg: "Password does not match",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        print(
                            ' code is ${_registrationController.password.text.trim()}');
                        print(widget.id);

                        await registerUserDetails(context,
                            confirmedPassword:
                                _registrationController.confirmPassword.text,
                            id: widget.id,
                            password:
                                _registrationController.confirmPassword.text);
                      }
                    },
                    child: AuthButtons(
                        hasImage:
                            (_isLoading) ? "assets/images/loader.gif" : null,
                        color: (_isLoading || !_passRequirementMet)
                            ? signInPlaceholder
                            : null,
                        imageWidth: (_isLoading) ? 50 : null,
                        imageheight: (_isLoading) ? 30 : null,
                        form: true,
                        text: (_isLoading) ? "" : "Continue",
                        route: SetupPassCode(
                          id: widget.id,
                        )),
                  ),
                )
              ]),
        ),
      )),
    );
  }

  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) &&
        function.checkUpperCase(value) &&
        function.checknumbers(value) &&
        function.specialCharacters(value) &&
        value.length >= 8);

    return met;
  }

  Future<void> registerUserDetails(BuildContext context,
      {required String id,
      required String password,
      required String confirmedPassword}) async {
    setState(() {
      _isLoading = true;
    });
    final response = await _loginController.createNewPassword(
        id, password, confirmedPassword);
    print(response.body);
    final jsonBody = jsonDecode(response.body);

    print(' code is ${jsonBody}');
    final userToken = jsonBody['token'];
    if (response.statusCode == 200) {
      // final validateUserIdentifier = jsonBody['data']['identifier'];
      // SecureStorage.setUserIdentifier(validateUserIdentifier);
      setState(() {
        _isLoading = false;
      });

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SetupPassCode(
              id: widget.id,
            ),
          ),
        );
      });
      // SecureStorage.setUserToken(userToken);
      // if ((!mounted)) return;
      Fluttertoast.showToast(
        msg: "Registration successful",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // if (!mounted) return;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('${jsonBody['data']['error']}'),
      //   ),
      // );
      return;
    }

    Fluttertoast.showToast(
      msg: "${jsonBody['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Registration successful'),
    //   ),
    // );
  }
}
