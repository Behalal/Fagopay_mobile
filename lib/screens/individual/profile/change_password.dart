import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/edit_controller/profile_controller.dart';
import 'package:fagopay/controllers/login_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/service/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import '../../../functions/functions.dart';

class ForgotPassword extends StatefulWidget {
  final String pinCode;

  const ForgotPassword({Key? key, required this.pinCode,}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _ctrl = Get.put(ProfileController());
  Functions function = Functions();
  String? otpText;
  @override
  void dispose() {
    _otpController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
  bool _passRequirementMet = false;
  bool _passvisibility = false;
  bool _confirmpassvisibility = false;
  bool showPassword = false;
  bool _upto8Characters = false;
  bool _numbers = false;
  bool _lowerCase = false;
  bool _upperCase = false;
  bool _symbolSpecial = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller){
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
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
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
                            SizedBox(height: 2.h),
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
                            SizedBox(
                              height: 56,
                              width: 341,
                              child: TextFormField(
                                controller: _newPasswordController,
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
                                  if (checkRequirement(value) && value == _newPasswordController.text) {
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
                              height: 3.h,
                            ),
                            const AutoSizeText(
                              'Confirm New Password',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: welcomeText,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              height: 56,
                              width: 341,
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                onChanged: (value) {
                                  if (value != _confirmPasswordController.text &&
                                      !checkRequirement(_confirmPasswordController.text)) {
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
                                      const SizedBox(width: 2,),
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
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                                child: GestureDetector(
                                    onTap: () async {
                                      if (_newPasswordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
                                        Get.snackbar("Error", "Kindly enter your password", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                      } else if (_newPasswordController.text != _confirmPasswordController.text) {
                                        Get.snackbar("Error","Password does not match", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                      } else {
                                        controller.password = _confirmPasswordController.text;
                                        await controller.changePassword(context: context).then((value){
                                          if(value.data != null){
                                            otpBottomSheet(
                                              onTap: () async {
                                                Get.put<LocalCachedData>(await LocalCachedData.create());
                                                final userDetails = await LocalCachedData.instance.getUserDetails();
                                                var emailOrPassword = userDetails?.data?.userdetail?.phoneNumber ?? userDetails?.data?.userdetail?.email ?? "";
                                                if (otpText == null || otpText == '' || otpText?.length != 6) {
                                                  Get.snackbar("Alert", "Enter the otp sent to $emailOrPassword to continue!", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
                                                } else {
                                                  Get.back();
                                                  await _ctrl.validateForgotResetPassword(otp: otpText!, password: _ctrl.password!, context: context);
                                                }
                                              },
                                            );
                                          }
                                        });
                                      }
                                    },
                                    child: AuthButtons(
                                      color: (controller.isSetUpPasswordLoading) ? signInPlaceholder : null,
                                      imageWidth: (controller.isSetUpPasswordLoading) ? 50 : null,
                                      imageheight: (controller.isSetUpPasswordLoading) ? 50 : null,
                                      form: true,
                                      text: "Update",
                                      //route: const DashboardHome(),
                                    )
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void otpBottomSheet({required void Function()? onTap}){
    Get.bottomSheet(
      StatefulBuilder(builder: (context, update){
        TextEditingController controller = TextEditingController();
        return Container(decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          constraints: BoxConstraints(maxHeight: Get.height/2.5,), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(alignment: Alignment.centerLeft,
                          child: Text("Enter OTP", style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: signInText, fontSize: 18, fontWeight: FontWeight.w600),)),
                      const SizedBox(height: 5,),
                      Align(alignment: Alignment.centerLeft,
                        child: Text("An Otp was sent to your account. \nCheck your email or password", textAlign: TextAlign.left,
                          style: Theme.of(Get.context!).textTheme.bodySmall!.copyWith(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w300,),),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 35, width: 35, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black26),
                      child: const Center(
                        child: Icon(
                          Icons.clear, color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Padding(
                  padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                  child: PinCodeTextField(
                    length: 6, controller: controller,
                    appContext: Get.context!,
                    pastedTextStyle: const TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 36,
                      color: inactiveTab,
                    ),
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      activeColor: signInText,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 45,
                      fieldWidth: 45,
                      activeFillColor: Colors.white,
                    ),
                    onChanged: (String value) async {
                      if (value.length == 6) {
                        otpText = controller.text;
                      }
                    },
                  )),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Didn\'t recieve an otp?',
                      style: TextStyle(
                        color: fagoSecondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.refresh,
                    size: 15,
                    color: fagoSecondaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Resend',
                      style: TextStyle(
                        color: fagoSecondaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      color: fagoSecondaryColor,
                    ),
                    child: const Center(
                      child: AutoSizeText(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w600,
                            color: white),
                      ),
                    )
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        );
      }), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),),
      isScrollControlled: true, isDismissible: false,
    );
  }

  bool checkRequirement(String value) {
    bool met = (function.checkLoweCase(value) && function.checkUpperCase(value) && function.checknumbers(value) && function.specialCharacters(value) && value.length >= 8);

    return met;
  }
}

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
