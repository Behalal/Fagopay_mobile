// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PurseSpending extends StatefulWidget {
  const PurseSpending({
    super.key,
  });

  @override
  State<PurseSpending> createState() => _PurseSpendingState();
}

class _PurseSpendingState extends State<PurseSpending> {
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
                    pageName: "Purse Spending",
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
                              'Food and Drinks',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: stepsColor,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 2.h),
                                height: 30.h,
                                width: Get.width,
                                color: fagoPrimaryColorWithOpacity10,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 0.5.h,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/transfer_icon.svg',
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Transfer to Obasa',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  '14 Mar 2023 | 09:30 am',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const AutoSizeText(
                                              'NGN 500',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/transfer_icon.svg',
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Transfer to Obasa',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  '14 Mar 2023 | 09:30 am',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const AutoSizeText(
                                              'NGN 500',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/transfer_icon.svg',
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Transfer to Obasa',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  '14 Mar 2023 | 09:30 am',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const AutoSizeText(
                                              'NGN 500',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ]),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/transfer_icon.svg',
                                            ),
                                            SizedBox(
                                              width: 2.h,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const AutoSizeText(
                                                  'Transfer to Obasa',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                const AutoSizeText(
                                                  '14 Mar 2023 | 09:30 am',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            const AutoSizeText(
                                              'NGN 500',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ]),
                                    ])),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        )),
                  ),
                ])));
  }
}
