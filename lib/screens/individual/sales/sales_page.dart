// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SalesAccount extends StatefulWidget {
  const SalesAccount({
    super.key,
  });

  @override
  State<SalesAccount> createState() => _SalesAccountState();
}

class _SalesAccountState extends State<SalesAccount> {
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Sales Accounts",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.5.w),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                'Obasana Designs ',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: 3.h,
                                      right: 3.h,
                                      top: 3.h,
                                      bottom: 2.h),
                                  height: 27.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      color: fagoPrimaryColorWithOpacity10,
                                      border: Border.all(
                                          color: fagoPrimaryColorWithOpacity)),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          'Obasana Designs | Kano Branch',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: stepsColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        Row(
                                          children: [
                                            const AutoSizeText(
                                              '2038173855 ',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: .3.h,
                                            ),
                                            SvgPicture.asset(
                                                'assets/icons/copy-svgrepo-com 1.svg')
                                          ],
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                        const AutoSizeText(
                                          'Guaranty Trust Bank',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: stepsColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            AutoSizeText(
                                              'Total Inflow',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: stepsColor,
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Total Withdraw',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: stepsColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: .5.h,
                                        ),
                                         Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            AutoSizeText(
                                              '# 900,340.00',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                            AutoSizeText(
                                              '#200,340.00',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        const Divider(
                                          color: stepsColor,
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const AutoSizeText(
                                              'Total Balance',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: stepsColor,
                                              ),
                                            ),
                                            SizedBox(
                                              height: .5.h,
                                            ),
                                            const AutoSizeText(
                                              '# 700,340.00',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ])),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              const AutoSizeText(
                                'Managed by',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              const AutoSizeText(
                                'Quick Actions',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 1.h),
                                height: 6.h,
                                width: Get.width,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/reffered_list_icon.svg',
                                      ),
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                       Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          AutoSizeText(
                                            'Jafar Zubaird',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: stepsColor,
                                            ),
                                          ),
                                          AutoSizeText(
                                            'Complete',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: fagoGreenColor,
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
                              ),
                              const Divider(
                                color: stepsColor,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 1.h),
                                height: 6.h,
                                width: Get.width,
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/reffered_list_icon.svg',
                                      ),
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                       Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          AutoSizeText(
                                            'Jafar Zubaird',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: stepsColor,
                                            ),
                                          ),
                                          AutoSizeText(
                                            'Complete',
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
                              ),
                              const Divider(
                                color: stepsColor,
                              ),
                            ],
                          ),
                        )),
                  ),
                ])));
  }
}
