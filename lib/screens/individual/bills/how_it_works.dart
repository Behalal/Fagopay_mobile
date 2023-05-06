// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/individual/requests/payme_page.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HowItWorks extends StatefulWidget {
  final String? network;
  final String? number;
  final String? amount;
  const HowItWorks({
    super.key,
    this.network,
    this.number,
    this.amount,
  });

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
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
                    pageName: "Swap Airtime",
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "How it works?",
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
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Kindly transfer ',
                                style: const TextStyle(
                                  color: stepsColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: '$widget.network'.toUpperCase(),
                                    style: const TextStyle(
                                      color: fagoSecondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' Airtime of',
                                    style: TextStyle(
                                      color: stepsColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$widget.amount',
                                    style: const TextStyle(
                                      color: fagoSecondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' to',
                                    style: TextStyle(
                                      color: stepsColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.h),
                              height: 8.h,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                color: fagoSecondaryColorWithOpacity10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Image(
                                      image:
                                          AssetImage("assets/images/mtn.png")),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  AutoSizeText(
                                    '$widget.number',
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const AutoSizeText(
                              "and check your wallet in 5 minutes",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: stepsColor,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              padding: EdgeInsets.all(2.h),
                              //  height: 8.h,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                color: fagoSecondaryColorWithOpacity10,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "How to make MTN Transfer",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                  const Divider(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      AutoSizeText(
                                        "Format:",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: stepsColor,
                                        ),
                                      ),
                                      AutoSizeText(
                                        "*600*08102837593*1000*pin#",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: stepsColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      AutoSizeText(
                                        "Click the link below",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: stepsColor,
                                        ),
                                      ),
                                      AutoSizeText(
                                        "*600*08102837593*1000*pin#",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: fagoSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: const TextSpan(
                                      text: 'Default PIN: ',
                                      style: TextStyle(
                                        color: stepsColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' 0000',
                                          style: TextStyle(
                                            color: fagoSecondaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' (Note: default pin must be changed)',
                                          style: TextStyle(
                                            color: stepsColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: const TextSpan(
                                      text: 'Default PIN: ',
                                      style: TextStyle(
                                        color: stepsColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: ' 0000',
                                          style: TextStyle(
                                            color: fagoSecondaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              ' (Note: default pin must be changed)',
                                          style: TextStyle(
                                            color: stepsColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Dashboard()),
                                        (Route<dynamic> route) => false),
                                child: const AutoSizeText(
                                  "Go to Dashboard",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Work Sans",
                                      fontWeight: FontWeight.w400,
                                      color: buttonColor,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}
