// ignore_for_file: unrelated_type_equality_checks


import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AccountLimit extends StatefulWidget {
  const AccountLimit({
    super.key,
  });

  @override
  State<AccountLimit> createState() => _AccountLimitState();
}

class _AccountLimitState extends State<AccountLimit> {
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
                    pageName: "Account Limit",
                    // backRoute: MakeRequest(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 2.5.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isIndividual = !isIndividual;
                                        });
                                      },
                                      child: const AutoSizeText(
                                        'Individual',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: welcomeText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          isIndividual = !isIndividual;
                                        });
                                      },
                                      child: const AutoSizeText(
                                        'Business',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: welcomeText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 20,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: isIndividual
                                          ? stepsColor.withOpacity(0.2)
                                          : fagoSecondaryColor,
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1,
                                      color: isIndividual
                                          ? fagoSecondaryColor
                                          : stepsColor.withOpacity(0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            isIndividual
                                ? Container(
                                    height: 40.h,
                                    width: Get.width,
                                    color: fagoSecondaryColor,
                                    child: Column(children: const []),
                                  )
                                : Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.h, vertical: 3.h),
                                    height: 43.h,
                                    width: Get.width,
                                    color: fagoPrimaryColorWithOpacity10,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const AutoSizeText(
                                            'Transaction Limit',
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Daily Transfer Limit',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: stepsColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 200,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          const LinearProgressIndicator(
                                              value: 0.7,
                                              minHeight: 3,
                                              color: fagoSecondaryColor,
                                              backgroundColor:
                                                  fagoPrimaryColorWithOpacity10
                                              // valueColor: AlwaysStoppedAnimation<Color>(
                                              //   AppColor().loadingGreen,
                                              // ),
                                              ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Amount Remaining to spend',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 120,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          const Divider(
                                            color: stepsColor,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Account Balance Limit',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: stepsColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 200,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          const LinearProgressIndicator(
                                              value: 0.5,
                                              minHeight: 3,
                                              color: fagoSecondaryColor,
                                              backgroundColor:
                                                  fagoPrimaryColorWithOpacity10
                                              // valueColor: AlwaysStoppedAnimation<Color>(
                                              //   AppColor().loadingGreen,
                                              // ),
                                              ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Amount Remaining to spend',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 120,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          const Divider(
                                            color: stepsColor,
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Daily Deposit Limit',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: stepsColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 200,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          const LinearProgressIndicator(
                                              value: 0.2,
                                              minHeight: 3,
                                              color: fagoSecondaryColor,
                                              backgroundColor:
                                                  fagoPrimaryColorWithOpacity10
                                              // valueColor: AlwaysStoppedAnimation<Color>(
                                              //   AppColor().loadingGreen,
                                              // ),
                                              ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              AutoSizeText(
                                                'Amount Remaining to spend',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                              AutoSizeText(
                                                'NGN 120,000.00',
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: fagoSecondaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.h,
                                          ),
                                        ]))
                          ],
                        )),
                  ),
                ])));
  }
}
