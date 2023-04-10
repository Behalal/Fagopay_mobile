import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'models/payments_model.dart';
import 'models/service_model.dart';
import '../../kyc/kyc1.dart';
import '../../widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import 'widgets/dashboard_details.dart';
import '../widgets/navigation_bar.dart';

import '../../../models/user_model/user.dart';

class DashboardHome extends StatefulWidget {
  final User userDetails;
  final AccountDetail? accountDetails;

  const DashboardHome({
    Key? key,
    required this.userDetails,
    this.accountDetails,
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
                    user: widget.userDetails,
                    accountType: "Individual",
                    accountDetails: widget.accountDetails!,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // SizedBox(
                        //   height: 3.h,
                        // ),
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
                              color: fagoSecondaryColor,
                            ),
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
                                    height: 10.h,
                                    width: 21.w,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.h, horizontal: 1.5.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: fagoSecondaryColor,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5))),
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
                                        SizedBox(
                                          width: 20.w,
                                          child: AutoSizeText(
                                            paymentContents[i].description,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9,
                                              color: inactiveTab,
                                            ),
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
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        widget.userDetails.kycVerified == 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 2.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const KycVerfication(
                                          accountType: 'individual',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 15),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: fagoPrimaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: const Color(0xFFC61F2A),
                                            height: 35,
                                            width: 35,
                                            child: SvgPicture.asset(
                                              'assets/icons/bi_shield-lock.svg',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                'Attention ${widget.userDetails.firstName}!',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 2.5.h,
                                              ),
                                              Text(
                                                'Complete your KYC requirements to access our banking services. It will help secure & protect your account from impersonation.',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                ),
                                                softWrap: true,
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Row(
                                                children: [
                                                  LinearPercentIndicator(
                                                    padding: EdgeInsets.zero,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.51,
                                                    lineHeight: 8.0,
                                                    percent: 0.8,
                                                    backgroundColor:
                                                        Colors.white,
                                                    progressColor:
                                                        const Color(0xFFC61F2A),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    '80%',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SvgPicture.asset(
                                            'assets/icons/arrow-right.svg'),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 0.h,
                                // ),
                              )
                            : SizedBox(
                                height: 2.5.h,
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
                            padding: EdgeInsets.only(
                                left: 5.w, right: 5.w, top: 1.h),
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
                                for (int i = 0;
                                    i < serviceContent.length;
                                    i++) ...[
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          serviceContent[i].image,
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          if (serviceContent[i].description !=
                                              null)
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
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                        //   child: Container(
                        //     height: 80,
                        //     width: Get.width,
                        //     decoration: BoxDecoration(
                        //       color: fagoPrimaryColor,
                        //       borderRadius: BorderRadius.circular(8),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.w,
                            right: 5.w,
                            top: 2.h,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: "This is Center Short Toast",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                            child: Image.asset(
                              'assets/images/refer-earn.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: const FagoNavigationBar(),
    );
  }
}
