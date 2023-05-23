// ignore_for_file: unrelated_type_equality_checks

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/individual/refer_and_win/reward_center.dart';
import 'package:fagopay/screens/widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:clipboard/clipboard.dart';

import '../../constants/colors.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({
    super.key,
  });

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  final _userUcontroller = Get.find<UserController>();
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
                    pageName: "Refer & Earn",
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: Image.asset('assets/images/new-year 2.png')),
                                  Expanded(child: Image.asset('assets/images/gift 1.png')),
                                  Expanded(child: Image.asset('assets/images/new-year 1.png')),
                                ],
                              ),
                              SizedBox(
                                height: 4.5.h,
                              ),
                              const AutoSizeText(
                                'Share FagoPay with your network and you both get \npaid.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: stepsColor),
                                    children: [
                                      TextSpan(text: 'Earn upto '),
                                      TextSpan(
                                          text: '#200 ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text:
                                              'Earn upto  for every new user that joins using your referral code and transact over'),
                                      TextSpan(
                                          text: ' #20,000',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(
                                          text: ' in their first 2 months'),
                                    ]),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 6.5.h,
                                width: 38.5.h,
                                decoration: BoxDecoration(
                                    color: fagoSecondaryColorWithOpacity10,
                                    borderRadius: BorderRadius.circular(36),
                                    border:
                                        Border.all(color: fagoSecondaryColor)),
                                //alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    const AutoSizeText(
                                      'Referral Code',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      height: Get.height,
                                      width: 20.5.h,
                                      decoration: const BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(36),
                                              bottomRight:
                                                  Radius.circular(36))),
                                      child: InkWell(
                                         onTap: () {
                                              if (_userUcontroller
                                                      .user!.referralCode ==
                                                  "") {
                                                print('enter text');
                                              } else {
                                                print(_userUcontroller
                                                    .user!.referralCode);
                                                FlutterClipboard.copy(
                                                    _userUcontroller
                                                        .user!.referralCode!);
                                                Get.snackbar(
                                                    'Referral Code Copied',
                                                    '${_userUcontroller.user!.referralCode}',
                                                    snackPosition:
                                                        SnackPosition.BOTTOM,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 3.h,
                                                      vertical: 2.h,
                                                    ));
                                                FlutterClipboard.copy(
                                                        _userUcontroller
                                                            .user!.referralCode
                                                            .toString())
                                                    .then((value) =>
                                                        print('copied'));
                                              }
                                            },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              _userUcontroller
                                                      .user!.referralCode ??
                                                  'No referral Code',
                                              style: const TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                                'assets/icons/copy-svgrepo-com 1.svg')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              const AutoSizeText(
                                'Tap to copy',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 6.5.h,
                                width: 35.5.h,
                                decoration: BoxDecoration(
                                    color: fagoSecondaryColor,
                                    borderRadius: BorderRadius.circular(36),
                                    border:
                                        Border.all(color: fagoSecondaryColor)),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                              SizedBox(
                                height: 3.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ReferCenter());
                                },
                                child: Container(
                                  height: 6.5.h,
                                  width: 35.5.h,
                                  decoration: BoxDecoration(
                                      color: fagoSecondaryColorWithOpacity10,
                                      borderRadius: BorderRadius.circular(36),
                                      border: Border.all(
                                          color:
                                              fagoSecondaryColorWithOpacity10)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const AutoSizeText(
                                        'My Referral Earnings',
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: stepsColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.h,
                                      ),
                                      SvgPicture.asset(
                                          'assets/icons/earning_icon.svg'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ])));
  }
}
