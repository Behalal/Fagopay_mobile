import '../../models/kyc_model.dart';
import '../authentication/account_creation/widgets/current_step.dart';
import 'business_verify.dart';
import 'kyc2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class Kyc_verfication extends StatefulWidget {
  const Kyc_verfication({super.key});

  @override
  State<Kyc_verfication> createState() => Kyc_verficationstate();
}

class Kyc_verficationstate extends State<Kyc_verfication> {
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
                if (KycDetailsValue.getAccountType == 2)
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
                  height: 1.h,
                ),
                if (KycDetailsValue.getAccountType == 2)
                  Padding(
                    padding: EdgeInsets.only(left: 0.5.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BvnVerification()));
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
                                          "assets/images/bi_shield-lock.png")),
                                  SizedBox(
                                    width: 1.w,
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
                                          color: fagoSecondaryColorWithOpacity10,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: const Text(
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
                  ),
                SizedBox(
                  height: 8.h,
                ),
                if (KycDetailsValue.getAccountType == 1)
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
                if (KycDetailsValue.getAccountType == 1)
                  SizedBox(
                    height: 2.h,
                  ),
                if (KycDetailsValue.getAccountType == 1)
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
                                          color: fagoSecondaryColorWithOpacity10,
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
