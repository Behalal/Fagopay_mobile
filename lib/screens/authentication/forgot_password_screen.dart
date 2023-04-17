import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controllers/login_controller.dart';
import '../constants/colors.dart';
import 'recover_password_otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _loginController = Get.find<LoginController>();

  // @override
  // void dispose() {
  //   _loginController.emailController.clear();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: const Color(0XFFffffff),
            body: Stack(
              children: [
                Positioned(
                  top: -20,
                  left: -20,
                  child: Image.asset(
                    'assets/images/rectange-design.jpg',
                    height: 350,
                    width: 300,
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 20,
                  child: SvgPicture.asset(
                    'assets/icons/fago-frame.svg',
                  ),
                ),
                Positioned(
                  top: 260,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Forgot Password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: fagoSecondaryColor,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Work Sans',
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Recover lost Password',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: fagoBlackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              // fontFamily: 'Work Sans',
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: 330,
                            child: TextField(
                              controller: _loginController.emailController,
                              decoration: InputDecoration(
                                focusColor: const Color(0XFFe8a5aa),
                                hintText: 'Email address',
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
                                  'assets/icons/dial-icon.svg',
                                  fit: BoxFit.scaleDown,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_loginController.emailController.text !=
                                    "") {
                                  await forgotPassword(context,
                                      _loginController.emailController.text);
                                  return;
                                }
                                Fluttertoast.showToast(
                                  msg: "Enter the field properly!",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                backgroundColor: fagoSecondaryColor,
                                fixedSize: const Size(250, 50),
                              ),
                              child: const Text('Submit'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  text: 'Back to ',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        color: fagoSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _loginController.forgotPassword(email);
    final jsonBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      progress.dismiss();
      Fluttertoast.showToast(
        msg: "Password reset code has been sent to your email",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => RecoverPasswordOTPScreen(
            email: email,
          ),
        ),
      );
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
