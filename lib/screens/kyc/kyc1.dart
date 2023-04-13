// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../authentication/account_creation/widgets/current_step.dart';
import '../constants/colors.dart';
import 'business_verify.dart';
import 'kyc2.dart';

class KycVerfication extends StatefulWidget {
  final String accountType;

  const KycVerfication({
    Key? key,
    required this.accountType,
  }) : super(key: key);

  @override
  State<KycVerfication> createState() => KycVerficationstate();
}

class KycVerficationstate extends State<KycVerfication> {
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
                CurrentStep(
                  step: "1",
                  // backRoute: const DashboardHome(),
                  pageName: "KYC Verification",
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  "Enjoy more access to our services when you verify your identity.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w600,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                const Text(
                  "We ask for your details to confirm you are you and to prevent anyone from pretending they are you.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Work Sans",
                    fontWeight: FontWeight.w400,
                    color: welcomeText,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                if (widget.accountType == 'individual')
                  const Text(
                    "Secure your Identity",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w600,
                      color: fagoSecondaryColor,
                    ),
                  ),
                SizedBox(
                  height: 2.h,
                ),
                if (widget.accountType == 'individual')
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const IdentityPassPage()));
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: 8.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 1.h),
                            decoration: const BoxDecoration(
                                color: fagoSecondaryColorWithOpacity10,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Image(
                                    image: AssetImage(
                                        "assets/images/bi_shield-lock.png")),
                                SizedBox(
                                  width: 3.w,
                                ),
                                const Text(
                                  "Verify Your BVN",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                  ),
                                ),
                                SizedBox(
                                  width: 19.w,
                                ),
                                const Image(
                                    image: AssetImage(
                                        "assets/images/arrow-right.png")),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: 25.w,
                                  height: 3.h,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.h, vertical: 3),
                                    decoration: const BoxDecoration(
                                        color: fagoSecondaryColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: const Center(
                                      child: Text(
                                        "Individual",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w500,
                                          color: fagoSecondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            const Text(
                              "Why we ask for BVN?",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12,
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 8.h,
                ),
                if (widget.accountType == 'business')
                  const Text(
                    "Secure your Business",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Work Sans",
                      fontWeight: FontWeight.w600,
                      color: fagoSecondaryColor,
                    ),
                  ),
                if (widget.accountType == 'business')
                  SizedBox(
                    height: 2.h,
                  ),
                if (widget.accountType == 'business')
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BusinessVerify()));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: 85.w,
                            height: 8.h,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.h, vertical: 3),
                              decoration: const BoxDecoration(
                                  color: fagoSecondaryColorWithOpacity10,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Image(
                                      image: AssetImage(
                                          "assets/images/Exclude.png")),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  const Text(
                                    "Verify Your Business",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w500,
                                      color: black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  const Image(
                                      image: AssetImage(
                                          "assets/images/arrow-right.png")),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 33.w,
                                    height: 3.h,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.h, vertical: 3),
                                      decoration: const BoxDecoration(
                                          color:
                                              fagoSecondaryColorWithOpacity10,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Text(
                                        "Business",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 9,
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w500,
                                          color: fagoSecondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
