// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/registration_controller.dart';
import '../../constants/colors.dart';
import '../../widgets.dart';
import 'individual_details.dart';
import 'select_verification_type.dart';
import 'widgets/current_step.dart';

class VerifyCodeSent extends StatefulWidget {
  const VerifyCodeSent(
      {Key? key,
      required this.userVerificationData,
      this.verificationType,
      required this.userIdentifier})
      : super(key: key);

  final String userVerificationData;
  final VerificationType? verificationType;
  final String userIdentifier;

  @override
  State<VerifyCodeSent> createState() => _VerifyCodeSentState();
}

class _VerifyCodeSentState extends State<VerifyCodeSent> {
  bool isLoading = false;
  final _registrationController = Get.find<RegistrationController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
          child: (isLoading)
              ? const Loading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurrentStep(
                        step: "2", backRoute: const SelectVerificationType()),
                    SizedBox(height: 5.h),
                    Padding(
                        padding: EdgeInsets.only(left: 2.5.w),
                        child: const AutoSizeText(
                          "Provide OTP",
                          style: TextStyle(
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
                          "We sent OTP to ${widget.userVerificationData}. Please check your inbox and enter the OTP received.",
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
                      height: 4.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.5.w),
                      child: SizedBox(
                        width: 60.w,
                        child: const AutoSizeText(
                          "Kindly input the code below. ",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: fagoSecondaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                        child: PinCodeTextField(
                          length: 6,
                          appContext: context,
                          pastedTextStyle: const TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 36,
                            color: inactiveTab,
                          ),
                          keyboardType: TextInputType.number,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            activeFillColor: Colors.white,
                          ),
                          onChanged: (String value) async {
                            if (value.length == 6) {
                              setState(() {
                                isLoading = true;
                              });
                              await validateUserOtp(
                                context,
                                userIdentifier: widget.userIdentifier,
                                code: value,
                              );
                            }
                          },
                        )),
                    SizedBox(
                      height: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "Didn’t receive an OTP?",
                            style: TextStyle(
                              fontFamily: "Work Sans",
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: fagoSecondaryColor,
                            ),
                          ),
                          Row(
                            children: [
                              Transform.rotate(
                                angle: -60 * (math.pi / 180),
                                child: const Icon(
                                  size: 18,
                                  Icons.replay,
                                  textDirection: TextDirection.rtl,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  // ref
                                  //     .read(loginControllerProvider.notifier)
                                  //     .resendCode(identifier)
                                  //     .then((value) {
                                  //   if (value.code != null && value.code != 200) {
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(
                                  //         content: Text(value.error!),
                                  //       ),
                                  //     );
                                  //   } else {
                                  //     registrationData.setId = value.identifier!;
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(
                                  //         content: Text(value.message!),
                                  //       ),
                                  //     );
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //   }
                                  // });
                                },
                                child: const AutoSizeText(
                                  "Resend",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> validateUserOtp(BuildContext context,
      {required String userIdentifier, required String code}) async {
    final response =
        await _registrationController.validateCode(userIdentifier, code);
    if (response.statusCode != 200) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "OTP is Invalid",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // if (!mounted) return;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('OTP is Invalid'),
      //   ),
      // );
      return;
    }

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                IndividualDetails(verificationType: widget.verificationType),
          ),
        );
      });
    });
  }
}
