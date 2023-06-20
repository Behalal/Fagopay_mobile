import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';
import '../constants/colors.dart';

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
    return Scaffold(
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
            top: 300, left: 0, right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 5,
                    ),
                    const Text(
                      'Recover lost Password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: fagoBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Work Sans"
                        // fontFamily: 'Work Sans',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 330,
                      child: TextField(
                        controller:
                        _loginController.forgotPasswordController,
                        decoration: InputDecoration(
                          focusColor: const Color(0XFFe8a5aa),
                          hintText: 'Email address / Phone Number',

                          hintStyle: const TextStyle(
                            fontSize: 14,
                          ),
                          prefixIconColor: const Color(0XFFe8a5aa),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFFe8a5aa),
                              width: 0.5,
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
                      height: 70,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_loginController
                              .forgotPasswordController.text !=
                              "") {
                            await _loginController.forgotPassword(emailOrPassword: _loginController
                                .forgotPasswordController.text, context: context);
                            return;
                          }
                          Get.snackbar("Error","Enter the field properly!");
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
    );
  }
}
