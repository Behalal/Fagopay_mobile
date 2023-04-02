import 'package:auto_size_text/auto_size_text.dart';
import '../authentication/account_creation/widgets/current_step.dart';
import 'kyc2.dart';
import 'kyc_details.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../constants/colors.dart';

class BvnOTP extends StatefulWidget {
  const BvnOTP({super.key});

  @override
  State<BvnOTP> createState() => BvnOTPstate();
}

class BvnOTPstate extends State<BvnOTP> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentStep(step: "3", backRoute: const BvnVerification()),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  "Provide OTP",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  "We sent OTP to your registered number for BVN. Please check your message and enter the OTP received.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                const Text(
                  "Kindly input the code sent to you. ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w500,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 2.5.w, right: 4.w),
                    child: PinCodeTextField(
                      length: 4,
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
                        if (value.length == 4) {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const KycDetailsScreen()));
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
                              const AutoSizeText(
                                "Resend",
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ])),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Cannot receive OTP?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BvnVerification()));
                      },
                      child: const Text(
                        "Use another method",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      )),
    );
  }
}
