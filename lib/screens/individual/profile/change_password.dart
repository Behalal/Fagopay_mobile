// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ForgotPassword extends StatefulWidget {
  final String pinCode;

  const ForgotPassword({
    Key? key,
    required this.pinCode,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _loginController = Get.find<LoginController>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProgressStyle(
              stage: 0,
              pageName: "Edit Profile",
              // backRoute: MakeRequest(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.5.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AutoSizeText(
                        'Create New Password',
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
                      const AutoSizeText(
                        'Provide a strong password to secure your \naccount',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: stepsColorWithOpacity55,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const AutoSizeText(
                        'Old Password',
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
                      _PasswordInput(
                        controller: _passwordController,
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
                        'Enter New Password',
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
                      _PasswordInput(
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const AutoSizeText(
                        'Enter New Password',
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
                      _ConfirmPasswordInput(
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      const _PasswordVerificationChips(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Center(
                        child: AuthButtons(
                          form: false,
                          text: "Update",
                        ),
                      ),
                      // _ContinueButton(
                      //   onPressed: () async {
                      //     if (_passwordController.text != "" &&
                      //         _confirmPasswordController.text != "") {
                      //       if (_confirmPasswordController.text !=
                      //           _passwordController.text) {
                      //         Fluttertoast.showToast(
                      //           msg: "Passwords dont match!",
                      //           toastLength: Toast.LENGTH_LONG,
                      //           gravity: ToastGravity.TOP,
                      //           timeInSecForIosWeb: 2,
                      //           backgroundColor: Colors.red,
                      //           textColor: Colors.white,
                      //           fontSize: 16.0,
                      //         );
                      //         return;
                      //       }
                      //       await createNewPassword(context);
                      //       return;
                      //     }
                      //     Fluttertoast.showToast(
                      //       msg: "Enter the fields correctly",
                      //       toastLength: Toast.LENGTH_LONG,
                      //       gravity: ToastGravity.TOP,
                      //       timeInSecForIosWeb: 2,
                      //       backgroundColor: Colors.red,
                      //       textColor: Colors.white,
                      //       fontSize: 16.0,
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createNewPassword(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _loginController.createNewPassword(widget.pinCode,
        _passwordController.text, _confirmPasswordController.text);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      progress.dismiss();
      Fluttertoast.showToast(
        msg:
            "Password has been reset successfuly. Proceed to login with your new password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const SignIn(),
            ),
            (route) => false);
      });
      return;
    }
    progress.dismiss();
    Fluttertoast.showToast(
      msg: "${jsonBody['data']['error']}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
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

class _PasswordVerificationChips extends StatelessWidget {
  const _PasswordVerificationChips();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 1,
      runSpacing: 2,
      children: [
        Chip(
          label: Text(
            'At least 8 character strong',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'One lower case character',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'One upper case',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
        Chip(
          label: Text(
            'A symbol or special character',
            style: TextStyle(
              fontSize: 10,
            ),
          ),
          avatar: Icon(
            Icons.check_circle_outline,
            size: 12,
          ),
        ),
      ],
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const _PasswordInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: fagoSecondaryColor)),
        focusColor: fagoSecondaryColor,
        hintText: 'Password',
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        prefixIconColor: const Color(0XFFe8a5aa),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: fagoSecondaryColor,
            width: 5.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        prefixIcon: SvgPicture.asset(
          'assets/icons/lock-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  final TextEditingController controller;

  const _ConfirmPasswordInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: fagoSecondaryColor)),
        focusColor: const Color(0XFFe8a5aa),
        hintText: 'Confirm Password',
        hintStyle: const TextStyle(
          fontSize: 14,
        ),
        prefixIconColor: const Color(0XFFe8a5aa),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0XFFe8a5aa),
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        prefixIcon: SvgPicture.asset(
          'assets/icons/lock-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
        suffixIcon: SvgPicture.asset(
          'assets/icons/show-password-icon.svg',
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
