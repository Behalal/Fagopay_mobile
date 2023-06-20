// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/government_identity_verification_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/kyc/business_verification.dart';
import 'package:fagopay/screens/kyc/identity_pass_kyc.dart';
import 'package:fagopay/screens/kyc/identity_verification.dart';
import 'package:fagopay/screens/kyc/kyc2.dart';
import 'package:fagopay/screens/kyc/proof_of_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../authentication/account_creation/widgets/current_step.dart';
import '../constants/colors.dart';

class KycVerfication extends StatefulWidget {
  final String? accountType;

  const KycVerfication({
    Key? key,
    this.accountType,
  }) : super(key: key);

  @override
  State<KycVerfication> createState() => KycVerficationstate();
}

class KycVerficationstate extends State<KycVerfication> {
  final _userUcontroller = Get.find<UserController>();
  final _governmentIdentityController =
      Get.find<GovernmentIdentityVerificationController>();

  @override
  Widget build(BuildContext context) {
    // print(
    //   'Id is ${_userUcontroller.user!.id}',
    // );
    return Scaffold(
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
                pageName: "Personal Verification ",
              ),
              SizedBox(
                height: 2.h,
              ),
              const Text(
                "Enjoy more access to our services when you verify your identity.",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Work Sans",
                  fontWeight: FontWeight.w600,
                  color: stepsColor,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              const AutoSizeText(
                'We ask for your details to confirm who you are and to prevent anyone impersonating you.',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: stepsColor,
                ),
              ),

              // SizedBox(
              //   height: 2.h,
              // ),
              // const Text(
              //   "We ask for your details to confirm you are you and to prevent anyone from pretending they are you.",
              //   textAlign: TextAlign.start,
              //   style: TextStyle(
              //     fontSize: 12,
              //     fontFamily: "Work Sans",
              //     fontWeight: FontWeight.w400,
              //     color: welcomeText,
              //   ),
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              // if (widget.accountType == 'individual')
              //   const Text(
              //     "Secure your Identity",
              //     textAlign: TextAlign.start,
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontFamily: "Work Sans",
              //       fontWeight: FontWeight.w600,
              //       color: fagoSecondaryColor,
              //     ),
              //   ),
              // SizedBox(
              //   height: 2.h,
              // ),

              Column(
                children: [
                  // SizedBox(
                  //   width: Get.width,
                  //   height: 8.h,
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 3.h, vertical: 1.h),
                  //     decoration: const BoxDecoration(
                  //         color: fagoSecondaryColorWithOpacity10,
                  //         borderRadius:
                  //             BorderRadius.all(Radius.circular(5))),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         const Image(
                  //             image: AssetImage(
                  //                 "assets/images/bi_shield-lock.png")),
                  //         SizedBox(
                  //           width: 3.w,
                  //         ),
                  //         const Text(
                  //           "Verify Your BVN",
                  //           textAlign: TextAlign.start,
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //             fontFamily: "Work Sans",
                  //             fontWeight: FontWeight.w500,
                  //             color: black,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 19.w,
                  //         ),
                  //         const Image(
                  //             image: AssetImage(
                  //                 "assets/images/arrow-right.png")),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Row(
                  //   children: [
                  //     Column(
                  //       children: [
                  //         SizedBox(
                  //           width: 25.w,
                  //           height: 3.h,
                  //           child: Container(
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 4.h, vertical: 3),
                  //             decoration: const BoxDecoration(
                  //                 color: fagoSecondaryColorWithOpacity10,
                  //                 borderRadius: BorderRadius.all(
                  //                     Radius.circular(20))),
                  //             child: const Center(
                  //               child: Text(
                  //                 "Individual",
                  //                 textAlign: TextAlign.start,
                  //                 style: TextStyle(
                  //                   fontSize: 9,
                  //                   fontFamily: "Work Sans",
                  //                   fontWeight: FontWeight.w500,
                  //                   color: fagoSecondaryColor,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     SizedBox(
                  //       width: 15.w,
                  //     ),
                  //     const Text(
                  //       "Why we ask for BVN?",
                  //       textAlign: TextAlign.end,
                  //       style: TextStyle(
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 12,
                  //         fontFamily: "Work Sans",
                  //         fontWeight: FontWeight.w400,
                  //         color: black,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Stack(alignment: Alignment.bottomRight, children: [
                    SvgPicture.asset(
                      'assets/icons/Ellipse 278.svg',
                      color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor : fagoSecondaryColor,
                    ),
                    SvgPicture.asset(
                      'assets/icons/Ellipse 279.svg',
                      color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor : fagoSecondaryColor,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) =>
                        //     const IdentityPassPage()));
                        if(_userUcontroller.user?.kycVerified != 1 ){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const BvnVerification()));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        // height: 27.h,
                        width: Get.width,
                        color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor.withOpacity(0.2) : fagoSecondaryColorWithOpacity10,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                //  SvgPicture.asset('assets/icons/tag-2.svg'),
                                 const AutoSizeText(
                                   'BVN is verified',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 0.4.h),
                                  //height: 2.5.h,
                                  width: 14.5.h,
                                  decoration: BoxDecoration(
                                      color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor.withOpacity(0.1) : fagoSecondaryColorWithOpacity10,
                                      borderRadius:
                                          BorderRadius.circular(25),
                                      border: Border.all(
                                          color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor : fagoSecondaryColor)),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    'BVN Verification ',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor: fagoSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                AutoSizeText(
                                  'STEP 1',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor : fagoSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/verify_suxf.svg',
                                  color: _userUcontroller.user?.kycVerified == 1 ? fagoGreenColor : fagoSecondaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Stack(alignment: Alignment.bottomRight, children: [
                    SvgPicture.asset(
                      'assets/icons/Ellipse 278.svg',
                      color: _userUcontroller.user?.kycVerified == 1
                          ? fagoGreenColor
                          : fagoSecondaryColor,
                    ),
                    SvgPicture.asset(
                      'assets/icons/Ellipse 279.svg',
                      color: _userUcontroller.user?.kycVerified == 1
                          ? fagoGreenColor
                          : fagoSecondaryColor,
                    ),
                    InkWell(
                      onTap: () {
                        if (_userUcontroller.user?.hasGovernmentIdentity != 1) {
                          Get.to(() => const IdentificationVerification());
                          return;
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        // height: 27.h,
                        width: Get.width,
                        color: _userUcontroller.user?.kycVerified == 1
                            ? fagoGreenColor.withOpacity(0.2)
                            : fagoSecondaryColorWithOpacity10,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                //  SvgPicture.asset('assets/icons/tag-2.svg'),
                                const AutoSizeText(
                                  'Verify your Identity',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 0.7.h),
                                  //height: 2.5.h,
                                  width: 24.h,
                                  decoration: BoxDecoration(
                                      color: _userUcontroller.user?.kycVerified == 1
                                          ? fagoGreenColor.withOpacity(0.1)
                                          : fagoSecondaryColorWithOpacity10,
                                      borderRadius:
                                          BorderRadius.circular(25),
                                      border: Border.all(
                                          color: _governmentIdentityController
                                                          .governmentIdentityDetailId !=
                                                      null &&
                                                  _governmentIdentityController
                                                          .governmentIdentityDetailId !=
                                                      ""
                                              ? fagoGreenColor
                                              : fagoSecondaryColor)),
                                  alignment: Alignment.center,
                                  child: AutoSizeText(
                                    'Government ID Verification',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: _userUcontroller.user?.kycVerified == 1
                                          ? fagoGreenColor
                                          : fagoSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                AutoSizeText(
                                  'STEP 2',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: _userUcontroller.user?.kycVerified == 1
                                        ? fagoGreenColor
                                        : fagoSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/verify_suxf.svg',
                                  color: _userUcontroller.user?.kycVerified == 1
                                      ? fagoGreenColor
                                      : fagoSecondaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Stack(alignment: Alignment.bottomRight, children: [
                    SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                    SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                    InkWell(
                      onTap: () {
                        Get.to(() => const BusinessVerification());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        // height: 27.h,
                        width: Get.width,
                        color: fagoSecondaryColorWithOpacity10,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                //  SvgPicture.asset('assets/icons/tag-2.svg'),
                                const AutoSizeText(
                                  'Business Identity',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 0.7.h),
                                  //height: 2.5.h,
                                  width: 24.h,
                                  decoration: BoxDecoration(
                                      color:
                                          fagoSecondaryColorWithOpacity10,
                                      borderRadius:
                                          BorderRadius.circular(25),
                                      border: Border.all(
                                          color: fagoSecondaryColor)),
                                  alignment: Alignment.center,
                                  child: const AutoSizeText(
                                    'CAC Documents Verification',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const AutoSizeText(
                                  'STEP 3',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/verify_suxf.svg',
                                  color: fagoSecondaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Stack(alignment: Alignment.bottomRight, children: [
                    SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                    SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ProofOfAddress());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        // height: 27.h,
                        width: Get.width,
                        color: fagoSecondaryColorWithOpacity10,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                //  SvgPicture.asset('assets/icons/tag-2.svg'),
                                const AutoSizeText(
                                  'Proof of Address',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 1.h, vertical: 0.7.h),
                                  //height: 2.5.h,
                                  width: 10.h,
                                  decoration: BoxDecoration(
                                      color:
                                          fagoSecondaryColorWithOpacity10,
                                      borderRadius:
                                          BorderRadius.circular(25),
                                      border: Border.all(
                                          color: fagoSecondaryColor)),
                                  alignment: Alignment.center,
                                  child: const AutoSizeText(
                                    'Utility Bill',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const AutoSizeText(
                                  'STEP 4',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                SvgPicture.asset(
                                  'assets/icons/verify_suxf.svg',
                                  color: fagoSecondaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
