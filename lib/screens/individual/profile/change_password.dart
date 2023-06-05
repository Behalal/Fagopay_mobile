// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/functions/constant.dart';
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

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';

class ForgotPassword extends StatefulWidget {
  final String pinCode;

  const ForgotPassword({Key? key, required this.pinCode,}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _newConfirmPasswordController = TextEditingController();
  final _loginController = Get.find<LoginController>();
  Functions function = Functions();
  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  bool _passRequirementMet = false;
  bool showPassword = false;
  bool _upto8Characters = false;
  bool _numbers = false;
  bool _lowerCase = false;
  bool _upperCase = false;
  bool _symbolSpecial = false;
  @override
  Widget build(BuildContext context) {
    print(_confirmPasswordController.text);
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
                      ///Code to input old passcode
                      // SizedBox(
                      //   height: 3.h,
                      // ),
                      // const AutoSizeText(
                      //   'Old Password',
                      //   style: TextStyle(
                      //     fontFamily: "Work Sans",
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //     color: welcomeText,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // _PasswordInput(
                      //   onTap: (s){},
                      //   controller: _passwordController,
                      // ),
                      // SizedBox(
                      //   height: 1.h,
                      // ),
                      // const Divider(
                      //   color: stepsColor,
                      // ),
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
                      SizedBox(height: 1.h),
                      _PasswordInput(
                        onTap: (value){
                          if (value.length >= 8) {
                            setState(() {
                              _upto8Characters = true;
                            });
                          }else {
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
                          } if (function.checknumbers(value)) {
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
                          if (checkRequirement(value) && value == _newConfirmPasswordController.text) {
                            setState(() {
                              _passRequirementMet = true;
                            });
                          } else {
                            setState(() {
                              _passRequirementMet = false;
                            });
                          }
                     //     print(_upto8Characters);
                        },
                        controller: _confirmPasswordController,
                      ),
                      SizedBox(height: 1.h),
                      const AutoSizeText(
                        'Confirm New Password',
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
                        controller: _newConfirmPasswordController,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Wrap(
                    spacing: 1,
                    runSpacing: 2,
                    children:  [
                      Chip(
                        // backgroundColor: Colors.red,
                        label: const Text(
                          'At least 8 character strong',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        avatar: Icon(
                          Icons.check_circle_outline,
                          size: 12,
                          color: _upto8Characters? requirementMet: requirementNotMet,
                        ),
                      ),
                      Chip(
                        label: const Text(
                          'One lower case character',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        avatar: Icon(
                          Icons.check_circle_outline,
                          size: 12,
                          color: _lowerCase  ? requirementMet:requirementNotMet,
                        ),
                      ),
                      Chip(
                        label: const Text(
                          'One upper case',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        avatar: Icon(
                          Icons.check_circle_outline,
                          size: 12,
                          color:   _upperCase? requirementMet:requirementNotMet,
                        ),
                      ),
                      Chip(
                        label: const Text(
                          'A symbol or special character',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        avatar: Icon(
                          Icons.check_circle_outline,
                          size: 12,
                          color: _symbolSpecial ? requirementMet:requirementNotMet,
                        ),
                      ),
                    ],
                  ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          var data = {
                            "code": _passwordController.text.trim(),
                            "password": _confirmPasswordController.text.trim(),
                            "password_confirmation": _newConfirmPasswordController.text.trim()
                          };
                          var data2 = {
                            "username": "09056193199"
                          };
                          RegistrationController().sendOtp(data2).then((value) {
                            Functions().popUp(context: context,
                                widget: Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 8.w),
                                  decoration: const BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 2.h,),
                                      Text('OTP Code',style: Constant().textStyle(size: 18 , weight: FontWeight.w600)),
                                      SizedBox(height: 2.h,),
                                      Text('Enter the OTP sent to your phone number  "09087877676"',style: Constant().textStyle(size: 15, weight: FontWeight.w400,color: successDescription),textAlign: TextAlign.center),
                                      SizedBox(height: 2.h,),
                                      TextField(
                                        //controller: controller,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(color: fagoSecondaryColor)),
                                          focusColor: fagoSecondaryColor,
                                          hintText: 'Enter OTP',
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
                                      ),
                                      SizedBox(height: 3.h,),
                                      AuthButtons(
                                        form: true,
                                        color: inactiveTab ,
                                        text: "Proceed",
                                      ),
                                      SizedBox(height: 20.h,),

                                    ],
                                  ),
                                ));
                          });
                          // if(_passwordController.text.isEmpty){
                          //   Get.snackbar('Error', 'validation requirement not reached',backgroundColor: fagoSecondaryColor, colorText: white);
                          // }
                          // else if(!_passRequirementMet){
                          //   Get.snackbar('Error', 'validation requirement not reached');
                          // }

                            // RegistrationController().changePassword(data).then((value) {
                            //   print(value);
                            // });
                        },
                        child: Center(
                          child: AuthButtons(
                            form: true,
                            text: "Update",
                          ),
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
  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) && function.checkUpperCase(value) && function.checknumbers(value) && function.specialCharacters(value) && value.length >= 8);

    return met;
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

// class _PasswordVerificationChips extends StatelessWidget {
//   const _PasswordVerificationChips();
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class _PasswordInput extends StatelessWidget {
  final TextEditingController controller;
  final  ValueChanged  onTap;
  const _PasswordInput({
    required this.onTap,
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      obscureText: true,
      onChanged: onTap,
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

class _ConfirmPasswordInput extends StatefulWidget {
  final TextEditingController controller;
  const _ConfirmPasswordInput({required this.controller});

  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(LoginController());
    //final _loginController = Get.find<LoginController>();
    return TextField(
      controller: widget.controller,
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
        suffixIcon: GestureDetector(
          onTap: (){
            // _loginController.getShowPass.
          },
          child: SvgPicture.asset(
            'assets/icons/show-password-icon.svg',
            fit: BoxFit.scaleDown,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}
