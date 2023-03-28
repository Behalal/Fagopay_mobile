// import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/repository/controllers/login_controller_provider.dart';
import 'package:fagopay/screens/authentication/account_creation/select_type.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/authentication/widgets/email_phone_input.dart';
import 'package:fagopay/screens/authentication/widgets/forgot_pass_text.dart';
import 'package:fagopay/screens/authentication/widgets/password_input.dart';
import 'package:fagopay/screens/dashboard/business/home/home.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';
import '../dashboard/home/dashboard_home.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  ConsumerState<SignIn> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<SignIn> with InputValidatorMixin {
  bool isHiddenPassword = true;
  bool? isChecked = false;

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  late bool _isLoading;
  SecureStorage storage = SecureStorage();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    _isLoading = false;
    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Positioned(
                      top: -100,
                      right: 180.69,
                      width: 415.19,
                      height: 480.92,
                      child: Transform.rotate(
                        angle: 134.28,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: signRectangle,
                              boxShadow: [
                                BoxShadow(
                                  color: signRectangle,
                                  blurRadius: 2,
                                  // offset: Offset(
                                  //   -10.0, // Move to right 10  horizontally
                                  //   20.0, // Move to bottom 10 Vertically
                                  // ),
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(100),
                                topLeft: Radius.circular(100),
                              )),
                        ),
                      )),
                  Positioned(
                    top: 50,
                    left: 3.w,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                      width: 371,
                      height: 208,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/image 1.png"))),
                      child: Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Positioned(
                            top: 35.66,
                            width: 71.92,
                            height: 60.09,
                            left: 15.26,
                            child: Image.asset(
                                "assets/images/sign_in_vector 1.png"),
                          ),
                          Positioned(
                            top: 63.48,
                            width: 67.35,
                            height: 95.12,
                            left: 18.29,
                            child: Image.asset(
                                "assets/images/sign_in_vector 2.png"),
                          ),
                          Positioned(
                              top: 51.26,
                              right: 54.38,
                              bottom: -6.81,
                              left: -189,
                              child: Image.asset(
                                  "assets/images/sign_in_vector 3.png")),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 41.h,
                    left: 12.w,
                    child: SizedBox(
                      width: 70.w,
                      child: const AutoSizeText(
                        "Sign In",
                        style: TextStyle(
                            color: signInText,
                            fontFamily: "Work Sans",
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 47.h,
                    left: 12.w,
                    child: SizedBox(
                      width: 70.w,
                      child: const Text(
                        "Welcome back!",
                        style: TextStyle(
                            color: welcomeText,
                            fontFamily: "Work Sans",
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55.h,
                    left: 12.w,
                    right: 12.w,
                    child: EmailPhone(
                      controller: emailController,
                    ),
                  ),
                  Positioned(
                    top: 64.h,
                    left: 12.w,
                    right: 12.w,
                    child: PasswordInput(
                      controller: passwordController,
                      obscure: isHiddenPassword,
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          isHiddenPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: isHiddenPassword
                              ? Colors.grey.withOpacity(0.5)
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 72.8.h, right: 10.w, child: const ForgotPassText()),
                  Positioned(
                    top: 86.h,
                    left: 12.w,
                    right: 12.w,
                    child: SizedBox(
                      width: 280,
                      height: 50,
                      child: GestureDetector(
                        onTap: (() {
                          final progress = ProgressHUD.of(context);
                          progress!.show();
                          if (_isLoading != true) {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Kindly insert all fields',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              );
                              progress.dismiss();
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              ref
                                  .read(loginControllerProvider.notifier)
                                  .login(emailController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value.code != 200) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  progress.dismiss();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        value.error!,
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  storage.tokenSave(value.token);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Login Successfully',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  );

                                  ref
                                      .read(loginControllerProvider.notifier)
                                      .getUserDetails()
                                      .then((value) {
                                    Future.delayed(
                                        const Duration(milliseconds: 1000), () {
                                      progress.dismiss();
                                      setState(() {
                                        userFullDetails = value;
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BusinessHome(
                                              userDetails: userFullDetails,
                                            ),
                                          ),
                                        );
                                      });
                                    });
                                  });
                                }
                              });
                            }
                          }
                        }),
                        child: AuthButtons(
                          color: (_isLoading) ? signInPlaceholder : null,
                          imageWidth: (_isLoading) ? 50 : null,
                          imageheight: (_isLoading) ? 50 : null,
                          form: true,
                          text: "Login",
                          // route: const DashboardHome(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 92.h,
                    left: 12.w,
                    right: 12.w,
                    child: SizedBox(
                      width: 280,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 12,
                              color: signInPlaceholder,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const SelectType(),
                                ),
                              );
                            }),
                            child: const Text(
                              "Create Account",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                color: buttonColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

mixin InputValidatorMixin {
  bool validateEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );
    return emailRegExp.hasMatch(email);
  }

  bool validatePassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    return passwordRegExp.hasMatch(password);
  }
}
