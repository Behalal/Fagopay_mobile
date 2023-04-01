import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/functions.dart';
import 'package:fagopay/models/register_request/register.model.dart';
import 'package:fagopay/repository/controllers/login_controller_provider.dart';
import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:fagopay/screens/authentication/account_creation/setup_passcode.dart';
import 'package:fagopay/screens/authentication/account_creation/widgets/current_step.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../service/secure_storage/secure_storage.dart';

class SetupPassword extends StatefulWidget {
  const SetupPassword({super.key});

  @override
  State<SetupPassword> createState() => _SetupPasswordState();
}

class _SetupPasswordState extends State<SetupPassword> {
  late bool passvisibility;
  late bool confirmpassvisibility;

  late bool _isLoading;
  late bool passRequirementMet;

  late bool upto8Characters;
  late bool numbers;
  late bool lowerCase;
  late bool upperCase;
  late bool symbolSpecial;

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final String id = registrationData.getId;
  final String firstname = registrationData.getFirstname;
  final String lastname = registrationData.getlastname;
  final String email = registrationData.getEmail;
  final String referral = registrationData.getReferral;
  Functions function = Functions();
  SecureStorage storage = SecureStorage();

  @override
  void initState() {
    passvisibility = false;
    confirmpassvisibility = false;
    passRequirementMet = false;

    _isLoading = false;

    upto8Characters = false;
    numbers = false;
    lowerCase = false;
    upperCase = false;
    symbolSpecial = false;
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
                    controller: password,
                    onChanged: ((value) {
                      if (value.length >= 8) {
                        setState(() {
                          upto8Characters = true;
                        });
                      } else {
                        setState(() {
                          upto8Characters = false;
                        });
                      }
    
                      if (function.checkLoweCase(value)) {
                        setState(() {
                          lowerCase = true;
                        });
                      } else {
                        setState(() {
                          lowerCase = false;
                        });
                      }
    
                      if (function.checknumbers(value)) {
                        setState(() {
                          numbers = true;
                        });
                      } else {
                        setState(() {
                          numbers = false;
                        });
                      }
    
                      if (function.checkUpperCase(value)) {
                        setState(() {
                          upperCase = true;
                        });
                      } else {
                        setState(() {
                          upperCase = false;
                        });
                      }
    
                      if (function.specialCharacters(value)) {
                        setState(() {
                          symbolSpecial = true;
                        });
                      } else {
                        setState(() {
                          symbolSpecial = false;
                        });
                      }
    
                      if (checkRequirement(value) &&
                          value == confirmPassword.text) {
                        setState(() {
                          passRequirementMet = true;
                        });
                      } else {
                        setState(() {
                          passRequirementMet = false;
                        });
                      }
                    }),
                    obscureText: !passvisibility,
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
                            image: AssetImage("assets/images/password_icon.png")),
                        suffixIcon: IconButton(
                          icon: (passvisibility)
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
                              passvisibility = !passvisibility;
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
                    controller: confirmPassword,
                    onChanged: (value) {
                      if (value != password.text &&
                          !checkRequirement(password.text)) {
                        setState(() {
                          passRequirementMet = false;
                        });
                      } else {
                        setState(() {
                          passRequirementMet = true;
                        });
                      }
                    },
                    obscureText: !confirmpassvisibility,
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
                            image: AssetImage("assets/images/password_icon.png")),
                        suffixIcon: IconButton(
                          icon: (confirmpassvisibility)
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
                              confirmpassvisibility = !confirmpassvisibility;
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
                                color: (upto8Characters)
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
                                color: (lowerCase)
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
                        ))
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
                                color: (upperCase)
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
                                color: (numbers)
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
                        )),
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
                          color: (symbolSpecial)
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
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  child: GestureDetector(
                    onTap: () {
                      // if (password.text.isEmpty || confirmPassword.text.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Kindly enter your password'),
                      //     ),
                      //   );
                      // } else if (password.text != confirmPassword.text) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Password does not match'),
                      //     ),
                      //   );
                      // } else {
                      //   setState(() {
                      //     _isLoading = true;
                      //   });
                      //   ref
                      //       .read(loginControllerProvider.notifier)
                      //       .registerDetails(id, firstname, lastname, email,
                      //           password.text, confirmPassword.text, referral)
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
                      //       storage.tokenSave(value.token);
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         const SnackBar(
                      //           content: Text('Registration successful'),
                      //         ),
                      //       );
                      //       Future.delayed(const Duration(seconds: 3), () {
                      //         setState(() {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const SetupPassCode()));
                              // });
                      //       });
                      //     }
                      //   });
                      // }
                    },
                    child: AuthButtons(
                        hasImage:
                            (_isLoading) ? "assets/images/loader.gif" : null,
                        color: (_isLoading || !passRequirementMet)
                            ? signInPlaceholder
                            : null,
                        imageWidth: (_isLoading) ? 50 : null,
                        imageheight: (_isLoading) ? 30 : null,
                        form: true,
                        text: (_isLoading) ? "" : "Continue",
                        route: const SetupPassCode()),
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
}
