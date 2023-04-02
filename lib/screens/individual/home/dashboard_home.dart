// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/kyc_model.dart';
import 'package:fagopay/screens/kyc/kyc1.dart';
import 'package:fagopay/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/individual/home/models/payments_model.dart';
import 'package:fagopay/screens/individual/home/models/service_model.dart';
import 'package:fagopay/screens/individual/home/widgets/dashboard_details.dart';
import 'package:fagopay/screens/individual/widgets/navigation_bar.dart';

import '../../../models/user_model/user.dart';

class DashboardHome extends StatefulWidget {
  final User userDetails;
  final AccountDetail accountDetails;

  const DashboardHome({
    Key? key,
    required this.userDetails,
    required this.accountDetails,
  }) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)
          ? const Loading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 300,
                  child: DashBoardDetails(
                    firstname: widget.userDetails.firstName,
                    accountType: widget.accountDetails.accountType,
                    accountDetails: widget.accountDetails,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: const AutoSizeText(
                          "Payments",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: fagoSecondaryColor),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i < paymentContents.length;
                                  i++) ...[
                                GestureDetector(
                                  onTap: () {
                                    if (paymentContents[i].route != null) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              paymentContents[i].route!,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 12.h,
                                    width: 20.w,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 1.5.h,
                                      horizontal: 1.5.w,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: fagoSecondaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    // child: Column(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   crossAxisAlignment: CrossAxisAlignment.center,
                                    //   children: [
                                    //     paymentContents[i].image,
                                    //     SizedBox(
                                    //       height: 1.h,
                                    //     ),

                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        paymentContents[i].image,
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        AutoSizeText(
                                          paymentContents[i].description,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 4,
                                            color: inactiveTab,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // ),
                                // ),
                                // if (i != (paymentContents.length - 1))
                                //   SizedBox(
                                //     width: 2.5.w,
                                //   )
                              ]
                            ],
                          )),
                      SizedBox(
                        height: 1.h,
                      ),
                      if ((widget.userDetails.kycVerified == null)
                          ? widget.userDetails.kycVerified == 0
                          : widget.userDetails.kycVerified! < 1)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: GestureDetector(onTap: () {
                            KycDetailsValue.setAccountType =
                                widget.accountDetails.accountType!;
                            log(KycDetailsValue.getAccountType.toString());
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Kyc_verfication(),
                              ),
                            );
                          }),
                          // SizedBox(
                          //   height: 0.h,
                          // ),
                        ),
                      SizedBox(
                        height: 0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        child: const AutoSizeText(
                          "Services",
                          style: TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: fagoSecondaryColor),
                        ),
                      ),
                      SizedBox(
                          child: Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                        child: GridView(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 12.0,
                                  crossAxisSpacing: 9.0),
                          shrinkWrap: true,
                          // runAlignment: WrapAlignment.start,
                          // runSpacing: 3.h,
                          // direction: Axis.horizontal,
                          // crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            for (int i = 0; i < serviceContent.length; i++) ...[
                              GestureDetector(
                                onTap: (() {
                                  if (serviceContent[i].route != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            serviceContent[i].route!,
                                      ),
                                    );
                                  }
                                }),
                                child: Container(
                                  height: 13.h,
                                  width: 26.w,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 1.h, horizontal: 1.5.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: fagoSecondaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      serviceContent[i].image,
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      if (serviceContent[i].description != null)
                                        SizedBox(
                                          width: 20.w,
                                          child: AutoSizeText(
                                            serviceContent[i].description!,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 9,
                                                color: inactiveTab),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              // if (i != (serviceContent.length - 1))
                              //   SizedBox(
                              //     width: 1.w,
                              //   )
                            ]
                          ],
                        ),

                        // Padding(
                        //     padding:
                        //         EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                        //     child: const Image(
                        //       image: AssetImage("assets/images/Frame 256.png"),
                        //     ))
                      )),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                        child: Container(
                          height: 80,
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: fagoPrimaryColor,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
      bottomNavigationBar: const FagoNavigationBar(),
    );
  }
}
