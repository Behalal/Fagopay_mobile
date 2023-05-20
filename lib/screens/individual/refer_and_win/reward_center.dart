// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ReferCenter extends StatefulWidget {
  const ReferCenter({
    super.key,
  });

  @override
  State<ReferCenter> createState() => _ReferCenterState();
}

class _ReferCenterState extends State<ReferCenter> {
  final _userUcontroller = Get.find<UserController>();
  int? myRequestType;
  var number = "";
  int? transactionType;

  @override
  Widget build(BuildContext context) {
    _userUcontroller.showReferalEarning();
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const ProgressStyle(
                    stage: 0,
                    pageName: "Reward Centre",
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.h, vertical: 3.h),
                                  //height: 27.h,
                                  width: Get.width,
                                  color: fagoPrimaryColorWithOpacity10,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const AutoSizeText(
                                          'Your Earnings',
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
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  'Reward Balance',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  'Total Earned',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                    color: stepsColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                AutoSizeText(
                                                  '$currencySymbol ${_userUcontroller.userReferalEarning?.rewardbalance.toString()}' ??
                                                      '0',
                                                  style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: fagoSecondaryColor,
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  '$currencySymbol ${_userUcontroller.userReferalEarning?.totalEarned.toString()}' ??
                                                      '0',
                                                  style: const TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: fagoSecondaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              'Referrer Joined',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: stepsColor,
                                              ),
                                            ),
                                            AutoSizeText(
                                              'Completed Referrer',
                                              style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w300,
                                                color: stepsColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              _userUcontroller
                                                      .userReferalEarning
                                                      ?.referalJoin
                                                      .toString() ??
                                                  '0',
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: stepsColor,
                                              ),
                                            ),
                                            AutoSizeText(
                                              _userUcontroller
                                                      .userReferalEarning
                                                      ?.completedReferal
                                                      .toString() ??
                                                  '0',
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: stepsColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => const ReferCenter());
                                          },
                                          child: Container(
                                            height: 4.5.h,
                                            width: 15.5.h,
                                            decoration: BoxDecoration(
                                                color:
                                                    fagoSecondaryColorWithOpacity10,
                                                borderRadius:
                                                    BorderRadius.circular(36),
                                                border: Border.all(
                                                    color: fagoSecondaryColor)),
                                            alignment: Alignment.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const AutoSizeText(
                                                  'Withdraw',
                                                  style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: fagoSecondaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1.5.h,
                                                ),
                                                SvgPicture.asset(
                                                    'assets/icons/Group 87.svg'),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ])),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              const AutoSizeText(
                                'Note: Withdrawals are only due after a 30 days earning circle',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              const AutoSizeText(
                                'Active Invites',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.h, vertical: 2.h),
                                //height: 27.h,
                                width: Get.width,
                                color: fagoSecondaryColorWithOpacity10,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset('assets/icons/tag-2.svg'),
                                    const AutoSizeText(
                                      'No referrals yet',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    const AutoSizeText(
                                      'Copy and share your referral code or link with your friends to start earning without stress.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: stepsColor,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Container(
                                      height: 6.5.h,
                                      width: 35.5.h,
                                      decoration: BoxDecoration(
                                          color: fagoSecondaryColor,
                                          borderRadius:
                                              BorderRadius.circular(36),
                                          border: Border.all(
                                              color: fagoSecondaryColor)),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const AutoSizeText(
                                            'Invite your friends',
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 2.h,
                                          ),
                                          SvgPicture.asset(
                                              'assets/icons/invite_friends.svg'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 1.h),
                              //   height: 6.h,
                              //   width: Get.width,
                              //   child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         SvgPicture.asset(
                              //           'assets/icons/reffered_list_icon.svg',
                              //         ),
                              //         SizedBox(
                              //           width: 2.h,
                              //         ),
                              //         const Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             AutoSizeText(
                              //               'Jafar Zubaird',
                              //               style: TextStyle(
                              //                 fontFamily: "Work Sans",
                              //                 fontSize: 14,
                              //                 fontWeight: FontWeight.w600,
                              //                 color: stepsColor,
                              //               ),
                              //             ),
                              //             AutoSizeText(
                              //               'Complete',
                              //               style: TextStyle(
                              //                 fontFamily: "Work Sans",
                              //                 fontSize: 12,
                              //                 fontWeight: FontWeight.w400,
                              //                 color: fagoGreenColor,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         const Spacer(),
                              //         const AutoSizeText(
                              //           'NGN 500',
                              //           style: TextStyle(
                              //             fontFamily: "Work Sans",
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w700,
                              //             color: fagoSecondaryColor,
                              //           ),
                              //         ),
                              //       ]),
                              // ),
                              // const Divider(
                              //   color: stepsColor,
                              // ),
                              // Container(
                              //   padding: EdgeInsets.symmetric(horizontal: 1.h),
                              //   height: 6.h,
                              //   width: Get.width,
                              //   child: Row(
                              //       crossAxisAlignment:
                              //           CrossAxisAlignment.center,
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         SvgPicture.asset(
                              //           'assets/icons/reffered_list_icon.svg',
                              //         ),
                              //         SizedBox(
                              //           width: 2.h,
                              //         ),
                              //         const Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.spaceEvenly,
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             AutoSizeText(
                              //               'Jafar Zubaird',
                              //               style: TextStyle(
                              //                 fontFamily: "Work Sans",
                              //                 fontSize: 14,
                              //                 fontWeight: FontWeight.w600,
                              //                 color: stepsColor,
                              //               ),
                              //             ),
                              //             AutoSizeText(
                              //               'Complete',
                              //               style: TextStyle(
                              //                 fontFamily: "Work Sans",
                              //                 fontSize: 12,
                              //                 fontWeight: FontWeight.w400,
                              //                 color: stepsColor,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //         const Spacer(),
                              //         const AutoSizeText(
                              //           'NGN 500',
                              //           style: TextStyle(
                              //             fontFamily: "Work Sans",
                              //             fontSize: 12,
                              //             fontWeight: FontWeight.w700,
                              //             color: fagoSecondaryColor,
                              //           ),
                              //         ),
                              //       ]),
                              // ),
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
