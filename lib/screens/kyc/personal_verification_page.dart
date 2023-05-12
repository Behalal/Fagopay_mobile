// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileKycPage extends StatefulWidget {
  const ProfileKycPage({
    super.key,
  });

  @override
  State<ProfileKycPage> createState() => _ProfileKycPageState();
}

class _ProfileKycPageState extends State<ProfileKycPage> {
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "KYC Verification ",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.5.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const AutoSizeText(
                                'Enjoy more access to our services when you verify your identity.',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Stack(alignment: Alignment.bottomRight, children: [
                                SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                                SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.h, vertical: 3.h),
                                  // height: 27.h,
                                  width: Get.width,
                                  color: fagoSecondaryColorWithOpacity10,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AutoSizeText(
                                        'Verify your BVN',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Container(
                                        height: 2.5.h,
                                        width: 12.5.h,
                                        decoration: BoxDecoration(
                                            color:
                                                fagoSecondaryColorWithOpacity10,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: fagoSecondaryColor)),
                                        alignment: Alignment.center,
                                        child: const AutoSizeText(
                                          'BVN Verification',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: fagoSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: signInPlaceholder,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to((const IdentityPassPage()));
                                        },
                                        child: Container(
                                          height: 5.h,
                                          width: 20.5.h,
                                          decoration: BoxDecoration(
                                              color: fagoSecondaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  color: fagoSecondaryColor)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/icons/verify_pre.svg'),
                                              const AutoSizeText(
                                                'Continue',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: white,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                  'assets/icons/verify_suxf.svg')
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 3.h,
                              ),
                              Stack(alignment: Alignment.bottomRight, children: [
                                SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                                SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.h, vertical: 3.h),
                                  // height: 27.h,
                                  width: Get.width,
                                  color: fagoSecondaryColorWithOpacity10,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const AutoSizeText(
                                        'Upgrade your Limit',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Container(
                                        height: 3.h,
                                        width: 20.5.h,
                                        decoration: BoxDecoration(
                                            color:
                                                fagoSecondaryColorWithOpacity10,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: fagoSecondaryColor)),
                                        alignment: Alignment.center,
                                        child: const AutoSizeText(
                                          'Governement ID Verification',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: fagoSecondaryColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        'Enjoy more of our services when you verify your ID to upgrade your account.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: signInPlaceholder,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Container(
                                        height: 5.h,
                                        width: 20.5.h,
                                        decoration: BoxDecoration(
                                            color: fagoSecondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: fagoSecondaryColor)),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/verify_pre.svg'),
                                            const AutoSizeText(
                                              'Continue',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: white,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                'assets/icons/verify_suxf.svg')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        )),
                  ),
                ])));
  }
}
