// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SwapAirtimeDescPage extends StatefulWidget {
  String? network;
  String? amount;
  String? number;
  String? image;

  SwapAirtimeDescPage({
    super.key,
    this.network,
    this.amount,
    this.number,
    this.image,
  });

  @override
  State<SwapAirtimeDescPage> createState() => _SwapAirtimeDescPageState();
}

class _SwapAirtimeDescPageState extends State<SwapAirtimeDescPage> {
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
                              height: 2.h,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Kindly transfer ',
                                style: const TextStyle(
                                  fontFamily: "Work Sans",
                                  color: inactiveTab,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.network!.toUpperCase(),
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      color: fagoSecondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' Airtime of ',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      color: inactiveTab,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '$currencySymbol ${widget.amount}',
                                    style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      color: fagoSecondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' to',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      color: inactiveTab,
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 2.h),
                              // height: 7.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: fagoSecondaryColorWithOpacity10,
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (widget.network! == 'mtn')
                                        ? const Image(
                                            image: AssetImage(
                                                "assets/images/mtn.png"),
                                            height: 50,
                                            width: 50,
                                          )
                                        : (widget.network! == 'glo')
                                            ? const Image(
                                                image: AssetImage(
                                                    "assets/images/glo.png"),
                                                height: 50,
                                                width: 50,
                                              )
                                            : (widget.network! == 'airtel')
                                                ? const Image(
                                                    image: AssetImage(
                                                        "assets/images/airtel.png"),
                                                    height: 50,
                                                    width: 50,
                                                  )
                                                : (widget.network! ==
                                                        'etisalat')
                                                    ? const Image(
                                                        image: AssetImage(
                                                            "assets/images/etisalat.png"),
                                                        height: 50,
                                                        width: 50,
                                                      )
                                                    : Container(),
                                    SizedBox(
                                      width: 2.h,
                                    ),
                                    AutoSizeText(
                                      widget.number!,
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: fagoSecondaryColor,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            const AutoSizeText(
                              "and check your wallet in 5 minutes",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: inactiveTab,
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 3.h),
                              // height: 25.h,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: fagoSecondaryColorWithOpacity10,
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.3),
                                //     blurRadius: 2,
                                //     offset:
                                //         const Offset(2, 3), // Shadow position
                                //   ),
                                // ],
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
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const AutoSizeText(
                                        "Format:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: inactiveTab,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "*600*08102837593*1000*pin#",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: inactiveTab,
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
                                    children: [
                                      const AutoSizeText(
                                        "Format:",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: inactiveTab,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      const AutoSizeText(
                                        "*600*08102837593*1000*pin#",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: fagoSecondaryColor,
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
                                    children: const[
                                      AutoSizeText(
                                        "Default PIN: 0000 (Note: default pin must be changed)",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: inactiveTab,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 8.h,
                            // ),
                            // Center(
                            //   child: AuthButtons(
                            //       form: false,
                            //       text: "Share Payment Link",
                            //       route: const PleasePayMePage()),
                            // ),
                          ],
                        )),
                  ),
                ])));
  }
}
