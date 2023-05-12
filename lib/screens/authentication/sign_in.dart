// import 'dart:ui';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/authentication/account_creation/select_type.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/authentication/widgets/email_phone_input.dart';
import 'package:fagopay/screens/authentication/widgets/forgot_pass_text.dart';
import 'package:fagopay/screens/authentication/widgets/password_input.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:fagopay/service/secure_storage/secure_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/colors.dart';
import '../functions.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _MyAppState();
}

class _MyAppState extends State<SignIn> with InputValidatorMixin {
  bool isHiddenPassword = true;
  bool? isChecked = false;
  bool _isLoading = false;

  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  @override
  void dispose() {
    _loginController.emailController.clear();
    _loginController.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                        decoration:  const BoxDecoration(
                            // image: svgDecorationImage("assets/images/image1.svg")),
                          image: DecorationImage(image: AssetImage("assets/images/image1.png"))
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.centerStart,
                          children: [
                            Positioned(
                              top: 35.66,
                              left: 8,
                              child: SvgPicture.asset("assets/images/Frame.svg"),
                            ),
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
                            fontWeight: FontWeight.w600,
                          ),
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
                        controller: _loginController.emailController,
                      ),
                    ),
                    Positioned(
                      top: 64.h,
                      left: 12.w,
                      right: 12.w,
                      child: PasswordInput(
                        controller: _loginController.passwordController,
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
                        top: 72.8.h,
                        right: 10.w,
                        child: const ForgotPassText()),
                    Positioned(
                      top: 85.h,
                      left: 12.w,
                      right: 12.w,
                      child: SizedBox(
                        width: 280,
                        height: 55,
                        child: GestureDetector(
                          onTap: () async {
                            final progress = ProgressHUD.of(context);
                            progress!.show();
                            if (_isLoading != true) {
                              if (_loginController
                                      .emailController.text.isEmpty ||
                                  _loginController
                                      .passwordController.text.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Kindly insert all fields",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text(
                                //       'Kindly insert all fields',
                                //       style: TextStyle(
                                //         fontFamily: "Work Sans",
                                //         fontSize: 10,
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //     ),
                                //   ),
                                // );
                                progress.dismiss();
                                return;
                              }
                              await loginUser(context);
                            }
                          },
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
                      top: 91.h,
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
          ),
        );
      }),
    );
  }


  Future<void> loginUser(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    final response = await _loginController.loginUser();
    setState(() {
      _isLoading = true;
    });
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (kDebugMode) {
        print('User response is $jsonBody');
      }
      final userToken = jsonBody['token'];
      SecureStorage.setUserToken(userToken);
      Fluttertoast.showToast(
        msg: "Login Successfull",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text(
      //       'Login Successfull',
      //       style: TextStyle(
      //         fontFamily: "Work Sans",
      //         fontSize: 10,
      //         fontWeight: FontWeight.w400,
      //       ),
      //     ),
      //   ),
      // );
      if (!mounted) return;
      await getUserDetails(context);
      return;
    }
    setState(() {
      _isLoading = false;
    });
    progress?.dismiss();
    final jsonBody = jsonDecode(response.body);
    // if (!mounted) return;
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
    //   SnackBar(
    //     content: Text(
    //       '${jsonBody['data']['error']}',
    //       style: const TextStyle(
    //         fontFamily: "Work Sans",
    //         fontSize: 10,
    //         fontWeight: FontWeight.w400,
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> getUserDetails(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    final response = await _loginController.getUserDetails();
    setState(() {
      _isLoading = false;
    });
    progress?.dismiss();
    final userjsonBodyData = response['data']['userdetail'];
    if (kDebugMode) {
      print('User details response is $userjsonBodyData');
    }
    final userAccountjsonBodyData = response['data']['accountdetail'];
    final userDetails = User.fromJson(userjsonBodyData);
    _userController.setUser = userDetails;
    final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
    _userController.setUserAccountDetails = userAccountDetails;
    // Future.delayed(const Duration(seconds: 1), () {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (
          // BuildContext context) =>  const BookKeeping(),
          BuildContext context) => const Dashboard(),

        //  DashboardHome(
        //   userDetails: userDetails,
        //   accountDetails: userAccountDetails,
        // ),
      ),
    );
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(
    //     builder: (BuildContext context) => BusinessHome(
    //       userDetails: userDetails,
    //       accountDetails: userAccountDetails,
    //     ),
    //   ),
    // );
    // });
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
