import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import 'select_type.dart';
import 'verify_code.dart';
import 'widgets/current_step.dart';
import '../widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SelectVerificationType extends StatefulWidget {
  const SelectVerificationType({super.key});

  @override
  State<SelectVerificationType> createState() => _SelectVerificationTypeState();
}

class _SelectVerificationTypeState extends State<SelectVerificationType> {
  final int currentIndex = 0;
  bool usePhone = true;
  bool useEmail = false;
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();
  Functions function = Functions();

  RegistrationController registrationController =
      Get.put(RegistrationController());

  @override
  void dispose() {
    registrationController.userAuthDataController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentStep(step: "2", backRoute: const SelectType()),
                  SizedBox(height: 5.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              usePhone = true;
                              useEmail = false;
                            });
                          },
                          child: Container(
                            width: 38.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: (usePhone) ? fagoSecondaryColor : white,
                                border: Border.all(
                                  color: (usePhone)
                                      ? fagoSecondaryColor
                                      : fagoSecondaryColorWithOpacity,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Center(
                                child: AutoSizeText(
                                  "Use Phone Number",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: (usePhone) ? white : inactiveTab,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        GestureDetector(
                          onTap: (() {
                            setState(() {
                              usePhone = false;
                              useEmail = true;
                            });
                          }),
                          child: Container(
                            width: 38.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: (useEmail) ? fagoSecondaryColor : white,
                                border: Border.all(
                                  color: (useEmail)
                                      ? fagoSecondaryColor
                                      : fagoSecondaryColorWithOpacity,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Center(
                                child: AutoSizeText(
                                  "Use Email Address",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: (useEmail) ? white : inactiveTab,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 2.5.w),
                      child: AutoSizeText(
                        (usePhone) ? "Enter Phone Number" : "Enter your Email",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: SizedBox(
                      width: 80.w,
                      child: AutoSizeText(
                        (usePhone)
                            ? "Within some few step, your account will be all set and ready for use. Kindly input your phone number for verification:"
                            : "Within some few step, your account will be all set and ready for use. Kindly input your email address for verification",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: inactiveTab,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: SizedBox(
                        width: 80.w,
                        child: TextFormField(
                          controller:
                              registrationController.userAuthDataController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            hintText: (usePhone)
                                ? "Enter your phone number"
                                : "Enter your email",
                            hintStyle: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder,
                            ),
                            prefixIcon: Stack(
                              alignment: AlignmentDirectional.center,
                              children: const [
                                Image(
                                    image:
                                        AssetImage("assets/images/shield.png")),
                                Image(
                                    image: AssetImage("assets/images/key.png")),
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 2.5.w),
                    child: SizedBox(
                      width: 80.w,
                      child: AutoSizeText(
                        (!usePhone)
                            ? "A verification code would be sent to your  email address."
                            : "A verification code would be sent to your  number.",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: verificationCodeText,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 10.w, left: 8.w, bottom: 3.h),
                    child: GestureDetector(
                      onTap: () {
                        if (_isLoading != true) {
                          if (registrationController
                              .userAuthDataController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kindly Insert all fields'),
                              ),
                            );
                            return;
                          }

                          if (usePhone &&
                              !function.validatePhone(registrationController
                                  .userAuthDataController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Kindly Insert a valid phone number'),
                              ),
                            );
                            return;
                          }

                          if (useEmail &&
                              !function.validateEmail(registrationController
                                  .userAuthDataController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Kindly Insert a valid email address'),
                              ),
                            );
                            return;
                          }
                          setUserAccount(context);
                        }
                      },
                      child: AuthButtons(
                        hasImage:
                            (_isLoading) ? "assets/images/loader.gif" : null,
                        color: (_isLoading) ? signInPlaceholder : null,
                        imageWidth: (_isLoading) ? 50 : null,
                        imageheight: (_isLoading) ? 30 : null,
                        form: true,
                        text: (_isLoading) ? "" : "Verify",
                      ),
                    ),
                  ),
                ])),
      )),
    );
  }

  void setUserAccount(BuildContext context) async {
    final res = await registrationController.selectAccountType();
    setState(() {
      _isLoading = true;
    });
    if (res.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      final jsonBody = jsonDecode(res.body);
      final registeredUserIdentifier = jsonBody['data']['identifier'];
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${jsonBody['message']}'),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => VerifyCodeSent(
              userIdentifier: registeredUserIdentifier,
              userVerificationData:
                  registrationController.userAuthDataController.text),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      final jsonBody = jsonDecode(res.body);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${jsonBody['message']}'),
        ),
      );
    }
  }
}
