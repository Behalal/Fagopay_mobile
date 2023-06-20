import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/colors.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String pinCode;

  const ResetPasswordScreen({
    Key? key,
    required this.pinCode,
  }) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _loginController = Get.find<LoginController>();
  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) && function.checkUpperCase(value) && function.checknumbers(value) && function.specialCharacters(value) && value.length >= 8);

    return met;
  }
  bool _upto8Characters = false;
  bool _numbers = false;
  bool _lowerCase = false;
  bool _upperCase = false;
  bool _symbolSpecial = false;
  bool _passvisibility = false;
  bool _confirmpassvisibility = false;
  bool _passRequirementMet = false;
  Functions function = Functions();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(
              color: fagoSecondaryColor,
              backgroundColor: fagoSecondaryColorWithOpacity,
              minHeight: 1.75,
              value: 0.5,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Step 4 of 4',
                  style: TextStyle(
                    color: fagoBlackColor,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            const Text(
              'Setup Password',
              style: TextStyle(
                color: fagoSecondaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Work Sans',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Provide a strong password to \nsecure your account',
              style: TextStyle(
                color: fagoBlackColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 56,
              width: 341,
              child: TextFormField(
                controller: _passwordController,
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
                  if (checkRequirement(value) && value == _confirmPasswordController.text) {
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
              height: 2.h,
            ),
            SizedBox(
              height: 56,
              width: 341,
              child: TextFormField(
                controller: _confirmPasswordController,
                onChanged: (value) {
                  if (value != _passwordController.text &&
                      !checkRequirement(
                          _passwordController.text)) {
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
            const SizedBox(height: 15),
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
            Padding(
              padding: const EdgeInsets.only(right: 80.0),
              child: Container(
                  width: 50.w,
                  height: 4.h,
                  decoration: const BoxDecoration(
                      color: passGuideBg,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
            ),
            const SizedBox(height: 25),
            _ContinueButton(
              onPressed: () async {
                if (_passwordController.text != "" &&
                    _confirmPasswordController.text != "") {
                  if (_confirmPasswordController.text !=
                      _passwordController.text) {
                    Get.snackbar("Error","Passwords don't match!");
                    return;
                  }
                  await _loginController.createNewPassword(id: widget.pinCode,
                    password: _passwordController.text,
                    confirmedPassword: _confirmPasswordController.text, context: context,);
                  return;
                }
                Get.snackbar("Error","Enter the fields correctly");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _ContinueButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: fagoSecondaryColor,
          fixedSize: const Size(200, 50),
        ),
        child: const Text('Continue'),
      ),
    );
  }
}

