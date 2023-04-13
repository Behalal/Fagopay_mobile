// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  const SizedBox(height: 35),
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
                  _PasswordInput(
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 10),
                  _ConfirmPasswordInput(
                    controller: _confirmPasswordController,
                  ),
                  const SizedBox(height: 15),
                  const _PasswordVerificationChips(),
                  const SizedBox(height: 25),
                  _ContinueButton(
                    onPressed: () async {
                      if (_passwordController.text != "" &&
                          _confirmPasswordController.text != "") {
                        if (_confirmPasswordController.text !=
                            _passwordController.text) {
                          Fluttertoast.showToast(
                            msg: "Passwords dont match!",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                          return;
                        }
                        await createNewPassword(context);
                        return;
                      }
                      Fluttertoast.showToast(
                        msg: "Enter the fields correctly",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
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
        gravity: ToastGravity.CENTER,
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
      gravity: ToastGravity.CENTER,
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
    return Wrap(
      spacing: 1,
      runSpacing: 2,
      children: const [
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
        focusColor: const Color(0XFFe8a5aa),
        hintText: 'Password',
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
