import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../../functions/functions.dart';
import '../../../service/secure_storage/secure_storage.dart';
import '../../constants/colors.dart';
import '../widgets/auth_buttons.dart';
import 'verify_code.dart';
import 'widgets/current_step.dart';

class SelectVerificationType extends StatefulWidget {
  const SelectVerificationType({super.key});

  @override
  State<SelectVerificationType> createState() => _SelectVerificationTypeState();
}

class _SelectVerificationTypeState extends State<SelectVerificationType> {
  var number = "";
  final int currentIndex = 0;
  bool usePhone = true;
  bool useEmail = false;
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();
  Functions function = Functions();

  final RegistrationController _registrationController =
      Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
              body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CurrentStep(step: "2", backRoute: const Onboarding()),
                      SizedBox(height: 5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                usePhone = true;
                                useEmail = false;
                              });
                            },
                            child: Container(
                              width: 42.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  color:
                                      (usePhone) ? fagoSecondaryColor : white,
                                  border: Border.all(
                                    color: (usePhone)
                                        ? fagoSecondaryColor
                                        : fagoSecondaryColorWithOpacity,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
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
                              width: 42.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                  color:
                                      (useEmail) ? fagoSecondaryColor : white,
                                  border: Border.all(
                                    color: (useEmail)
                                        ? fagoSecondaryColor
                                        : fagoSecondaryColorWithOpacity,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5))),
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
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      AutoSizeText(
                        (usePhone) ? "Enter Phone Number" : "Enter your Email",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      AutoSizeText(
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
                      SizedBox(
                        height: 5.h,
                      ),
                      (usePhone)
                          ? TextFormField(
                              controller: _registrationController.phone,
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
                                prefixIcon: const Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/shield.png")),
                                    Image(
                                        image: AssetImage(
                                            "assets/images/key.png")),
                                  ],
                                ),
                              ))
                          // ? IntlPhoneField(
                          //     disableLengthCheck: true,
                          //     keyboardType: Platform.isIOS
                          //         ? const TextInputType.numberWithOptions(
                          //             signed: true, decimal: false)
                          //         : TextInputType.phone,
                          //     flagsButtonMargin: const EdgeInsets.only(left: 8),
                          //     style: GoogleFonts.roboto(
                          //       color: stepsColor,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w400,
                          //     ),
                          //     decoration: InputDecoration(
                          //       fillColor: white,
                          //       contentPadding: const EdgeInsets.symmetric(
                          //           vertical: 20, horizontal: 15),
                          //       filled: true,
                          //       focusedBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //             color: fagoSecondaryColorWithOpacity,
                          //             width: 1,
                          //           ),
                          //           borderRadius: BorderRadius.circular(10)),
                          //       enabledBorder: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: fagoSecondaryColorWithOpacity,
                          //               width: 1),
                          //           borderRadius: BorderRadius.circular(10)),
                          //       border: OutlineInputBorder(
                          //           borderSide: const BorderSide(
                          //               color: fagoSecondaryColorWithOpacity,
                          //               width: 1),
                          //           borderRadius: BorderRadius.circular(10)),
                          //       hintText: 'Phone Number',
                          //       hintStyle: GoogleFonts.roboto(
                          //         color: stepsColor,
                          //         fontSize: 13,
                          //         fontStyle: FontStyle.normal,
                          //         fontWeight: FontWeight.w400,
                          //       ),
                          //     ),
                          //     controller: _registrationController.phone,
                          //     initialCountryCode: "NG",
                          //     validator: (data) {
                          //       number = data!.number;
                          //       if (number.length < 10 || number.length > 10) {
                          //         return "Invalid phone number";
                          //       } else if (!RegExp(r'^[0-9]+$')
                          //           .hasMatch(number)) {
                          //         return "Please enter only digits";
                          //       }
                          //       return null;
                          //     },
                          //     onChanged: (data) {
                          //       number = data.countryCode;
                          //     })
                          : TextFormField(
                              controller: _registrationController.email,
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
                                prefixIcon: const Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Image(
                                        image: AssetImage(
                                            "assets/images/shield.png")),
                                    Image(
                                        image: AssetImage(
                                            "assets/images/key.png")),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 80.w,
                        child: AutoSizeText(
                          (!usePhone)
                              ? "A verification code would be sent to your email address."
                              : "A verification code would be sent to your number.",
                          style: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: verificationCodeText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Divider(
                        color: stepsColor.withOpacity(0.3),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      const AutoSizeText(
                        "Do you have a referral code?",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: verificationCodeText,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        // controller: _registrationController.email,
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
                          hintText: "Referral Code",
                          hintStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: signInPlaceholder,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10.w, left: 8.w, bottom: 3.h),
                        child: GestureDetector(
                          onTap: () {
                            print(number + _registrationController.phone.text);
                            if (_isLoading != true) {
                              if (!usePhone &&
                                      _registrationController
                                          .email.text.isEmpty ||
                                  usePhone &&
                                      _registrationController
                                          .phone.text.isEmpty) {
                                Get.snackbar(
                                    'Error', 'Kindly Insert all fields');
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text('Kindly Insert all fields'),
                                //   ),
                                // );
                                // Fluttertoast.showToast(
                                //   msg: "Kindly Insert all fields",
                                //   toastLength: Toast.LENGTH_LONG,
                                //   gravity: ToastGravity.TOP,
                                //   timeInSecForIosWeb: 2,
                                //   backgroundColor: Colors.red,
                                //   textColor: Colors.white,
                                //   fontSize: 16.0,
                                // );
                                return;
                              }

                              if (usePhone &&
                                  !function.validatePhone(number +
                                      _registrationController.phone.text)) {
                                Get.snackbar('Error',
                                    'Kindly Insert a valid phone number');
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content:
                                //         Text('Kindly Insert a valid phone number'),
                                //   ),
                                // );
                                // Fluttertoast.showToast(
                                //   msg: "Kindly Insert a valid phone number",
                                //   toastLength: Toast.LENGTH_LONG,
                                //   gravity: ToastGravity.TOP,
                                //   timeInSecForIosWeb: 2,
                                //   backgroundColor: Colors.red,
                                //   textColor: Colors.white,
                                //   fontSize: 16.0,
                                // );
                                return;
                              }

                              if (useEmail &&
                                  !function.validateEmail(
                                      _registrationController.email.text)) {
                                // Fluttertoast.showToast(
                                //   msg: "Kindly Insert a valid email address",
                                //   toastLength: Toast.LENGTH_LONG,
                                //   gravity: ToastGravity.TOP,
                                //   timeInSecForIosWeb: 2,
                                //   backgroundColor: Colors.red,
                                //   textColor: Colors.white,
                                //   fontSize: 16.0,
                                // );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Kindly Insert a valid email address'),
                                  ),
                                );
                                return;
                              }
                              setUserAccount(context);
                            }
                          },
                          child: AuthButtons(
                            hasImage: (_isLoading)
                                ? "assets/images/loader.gif"
                                : null,
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
        ),
      ),
    );
  }

  void setUserAccount(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    try {
      final res = await _registrationController.selectAccountType();
      final jsonBody = jsonDecode(res.body);
      print(res.body);
      setState(() {
        _isLoading = true;
      });
      if (res.statusCode == 200) {
        progress.dismiss();
        setState(() {
          _isLoading = false;
        });
        final registeredUserIdentifier = jsonBody['data']['identifier'];
        SecureStorage.setUserIdentifier(registeredUserIdentifier);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('${jsonBody['message']}'),
        //   ),
        // );
        Fluttertoast.showToast(
          msg: "${jsonBody['message']}",
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
            builder: (BuildContext context) => VerifyCodeSent(
              verificationType:
                  !usePhone ? VerificationType.email : VerificationType.phone,
              userIdentifier: registeredUserIdentifier,
              userVerificationData: !usePhone
                  ? _registrationController.email.text
                  : number + _registrationController.phone.text,
            ),
          ),
        );
        return;
      }
      if (res.statusCode == 422) {
        progress.dismiss();
        setState(() {
          _isLoading = false;
        });
        if (!mounted) return;
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => const IndividualDetails(),
        //   ),
        // );
        Fluttertoast.showToast(
          msg: "${jsonBody['data']['error']}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return;
      }
      progress.dismiss();
      setState(() {
        _isLoading = false;
      });
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
      //     content: Text('${jsonBody['message']}'),
      //   ),
      // );
    } catch (e) {
      print(e);
    }
  }
}

enum VerificationType { email, phone }
