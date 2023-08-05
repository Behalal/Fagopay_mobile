import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/authentication/account_creation/select_verification_type.dart';
import 'package:fagopay/screens/authentication/account_creation/verify_code.dart';
import 'package:fagopay/screens/authentication/dispute_screen.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/authentication/widgets/email_phone_input.dart';
import 'package:fagopay/screens/authentication/widgets/forgot_pass_text.dart';
import 'package:fagopay/screens/authentication/widgets/password_input.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../constants/colors.dart';

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
  final _companyController = Get.find<CompanyController>();

  void _togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
  bool? biometricStatus;
  checkBiometrics()async{
    biometricStatus = await _loginController.checkBiometric();
    setState(() {
    });
  }


  @override
  void initState() {
    checkBiometrics();
    super.initState();
  }

  @override
  void dispose() {
    _loginController.emailController.clear();
    _loginController.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    // image: svgDecorationImage("assets/images/image1.svg")),
                      image: DecorationImage(
                          image: AssetImage("assets/images/image1.png"))),
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      Positioned(
                        top: 35.66,
                        left: 8,
                        child:
                        SvgPicture.asset("assets/images/Frame.svg"),
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
                child: Column(
                  children: [
                    PasswordInput(
                      controller: _loginController.passwordController,
                      obscure: isHiddenPassword,
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          isHiddenPassword ? Icons.visibility : Icons.visibility_off,
                          color: isHiddenPassword ? Colors.grey.withOpacity(0.5) : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    biometricStatus == true ?
                    GestureDetector(
                        onTap: () async {
                          Get.put<LocalCachedData>(await LocalCachedData.create());
                          final phone = await LocalCachedData.instance.getPhoneNumber();
                          final email = await LocalCachedData.instance.getEmail();
                          final password = await LocalCachedData.instance.getPassword();
                          if(phone != "" || phone != null){
                            if(phone!.startsWith("+234")){
                              final phoneNumber = phone.replaceRange(0, 4, "0");
                              _loginController.passwordController.text =  password ?? "";
                              _loginController.emailController.text = phoneNumber;
                              final LocalAuthentication auth = LocalAuthentication();
                              final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to sign in',
                                  authMessages: const <AuthMessages>[
                                    AndroidAuthMessages(signInTitle: 'Sign In', cancelButton: 'No thanks',),
                                    IOSAuthMessages(cancelButton: 'No thanks',),
                                  ],
                                  options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true, useErrorDialogs: false));
                              if (didAuthenticate) {
                                await loginUser(context);
                              }
                            }else{
                              _loginController.passwordController.text =  password ?? "";
                              _loginController.emailController.text = phone;
                              final LocalAuthentication auth = LocalAuthentication();
                              final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to sign in',
                                  authMessages: const <AuthMessages>[
                                    AndroidAuthMessages(signInTitle: 'Sign In', cancelButton: 'No thanks',),
                                    IOSAuthMessages(cancelButton: 'No thanks',),
                                  ],
                                  options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true, useErrorDialogs: false));
                              if (didAuthenticate) {
                                await loginUser(context);
                              }
                            }
                          }else if(email != "" || email != null){
                            _loginController.passwordController.text =  password ?? "";
                            _loginController.emailController.text = email!;
                            final LocalAuthentication auth = LocalAuthentication();
                            final bool didAuthenticate = await auth.authenticate(localizedReason: 'Please authenticate to sign in',
                                authMessages: const <AuthMessages>[
                                  AndroidAuthMessages(signInTitle: 'Sign In', cancelButton: 'No thanks',),
                                  IOSAuthMessages(cancelButton: 'No thanks',),
                                ],
                                options: const AuthenticationOptions(biometricOnly: true, stickyAuth: true, useErrorDialogs: false));
                            if (didAuthenticate) {
                              await loginUser(context);
                            }
                          }
                        },
                        child: Column(
                          children: [
                            Platform.isAndroid ? const Icon(MdiIcons.fingerprint, color: fagoSecondaryColor, size: 60,) :
                            Image.asset("assets/images/face_Id.png", height: 45, width: 45,),
                            const SizedBox(height: 5,),
                            Text("Sign In with Biometric", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12),)
                          ],
                        ),
                    )
                        : const SizedBox.shrink()
                  ],
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
                      if (_isLoading != true) {
                        if (_loginController.emailController.text.isEmpty ||
                            _loginController.passwordController.text.isEmpty) {
                          Get.snackbar("Error","Kindly insert all fields");
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
                      //route: const DashboardHome(),
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
                              const SelectVerificationType(),
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
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> const DisputeScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 28.0, top: 60),
                  child: Column(mainAxisAlignment:  MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/images/dispute.png", height: 40, width: 40,),
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text("Support", style: Theme.of(context).textTheme.bodySmall?.copyWith(),),
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
  }

  Future<void> loginUser(BuildContext context) async {
    progressIndicator(context);
    try{
      await _loginController.loginUser().then((value) async {
        setState(() {
          _isLoading = true;
        });
        if (value != null && context.mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) =>  VerifyCodeSent(userIdentifier: "", userVerificationData: _loginController.emailController.text, isLogin: true,),
            ),
          );
          // await getUserDetails();
        }else{
          setState(() {
            _isLoading = false;
          });
          Get.back();
        }
      });
    }catch(err){
      Get.back();
      Get.snackbar("Error",err.toString());
    }
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
