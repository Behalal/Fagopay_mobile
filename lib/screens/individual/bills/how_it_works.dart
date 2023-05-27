// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/requests/payme_page.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SharePaymentLink extends StatefulWidget {
  const SharePaymentLink({
    super.key,
  });

  @override
  State<SharePaymentLink> createState() => _SharePaymentLinkState();
}

class _SharePaymentLinkState extends State<SharePaymentLink> {
  bool isIndividual = false;
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
                    pageName: "Payment Link",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 22.w,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: buttonColor),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: .7.h),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        AutoSizeText(
                                          "Edit Link",
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            const AutoSizeText(
                              "Get paid from anyone",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: fagoSecondaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            const AutoSizeText(
                              "Copy and share your payment link with anyone and start receiving money.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: inactiveTab,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              height: 25.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 2,
                                    offset:
                                        const Offset(2, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/icons/Group 95.svg'),
                                  const AutoSizeText(
                                    "Ibrahim Lukman",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: stepsColor,
                                    ),
                                  ),
                                  Container(
                                    // padding: const EdgeInsets.only(left: 20),
                                    height: 6.h,
                                    width: 35.5.h,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(36),
                                        border: Border.all(
                                            color: fagoSecondaryColor)),
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const AutoSizeText(
                                          'https://fagopay.link/ibrahim',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: fagoSecondaryColor,
                                          ),
                                        ),
                                        // const Spacer(),
                                        SvgPicture.asset(
                                            'assets/icons/copy-svgrepo-com 1.svg')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            AuthButtons(
                                form: false,
                                text: "Share Payment Link",
                                route: const PleasePayMePage()),
                          ],
                        )),
                  ),
                ])));
  }
}
