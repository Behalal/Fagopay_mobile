import 'package:auto_size_text/auto_size_text.dart';
import 'individual_details.dart';
import 'select_verification_type.dart';
import 'widgets/current_step.dart';
import '../../constants/colors.dart';
import '../../widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

class VerifyCodeSent extends StatefulWidget {
  const VerifyCodeSent(
      {super.key,
      required this.userVerificationData,
      required this.userIdentifier});

  final String userVerificationData;
  final String userIdentifier;

  @override
  State<VerifyCodeSent> createState() => _VerifyCodeSentState();
}

class _VerifyCodeSentState extends State<VerifyCodeSent> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

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
                          onChanged: (String value) {
                            // if (value.length == 6) {
                            //   setState(() {
                            //     isLoading = true;
                            //   });
                            //   ref
                            //       .read(loginControllerProvider.notifier)
                            //       .validateCode(identifier, value)
                            //       .then((response) {
                            //     if (response.code != null &&
                            //         response.code != 200) {
                            //       setState(() {
                            //         isLoading = false;
                            //       });
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //         SnackBar(
                            //           content: Text(response.error!),
                            //         ),
                            //       );
                            //     } else {
                            //       Future.delayed(const Duration(seconds: 3), () {
                            //         setState(() {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const IndividualDetails(),
                              ),
                            );
                            //         });
                            //       });
                            //     }
                            //   });
                            // }
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
}
