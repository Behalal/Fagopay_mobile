import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/individual/home/widgets/services_widget.dart';
import 'package:fagopay/screens/individual/refer_and_win/refer_page.dart';
import 'package:fagopay/screens/individual/requests/requests.dart';
import 'package:fagopay/screens/individual/transactions/fago_to_bank.dart';
import 'package:fagopay/screens/individual/transactions/fago_to_fago.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/user_controller.dart';
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
import '../../widgets/navigation_bar.dart';

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
  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();

  @override
  void didChangeDependencies() async {
    await getUserDetails();
    super.didChangeDependencies();
  }

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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const AutoSizeText(
                                    '3',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  const AutoSizeText(
                                    ' Accounts',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color: stepsColor,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 5.h,
                                width: 23.5.h,
                                decoration: BoxDecoration(
                                    color: fagoSecondaryColor,
                                    borderRadius: BorderRadius.circular(25),
                                    border:
                                        Border.all(color: fagoSecondaryColor)),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const AutoSizeText(
                                      'Manage Accounts',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: white,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                        'assets/icons/arrow-right.svg')
                                  ],
                                ),
                              ),
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
                                    height: 10.2.h,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.h, vertical: 2.h),
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: fagoPrimaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Container(
                                              padding: const EdgeInsets.all(8),
                                              color: white,
                                              height: 35,
                                              width: 35,
                                              child: SvgPicture.asset(
                                                'assets/icons/bi_shield-lock.svg',
                                                color: fagoSecondaryColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  'Attention ${widget.userDetails.firstName}!',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: .5.h,
                                                ),
                                                const Text(
                                                  'Complete your KYC requirements to access our banking services. It will help secure & protect your account from impersonation.',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.white,
                                                  ),
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              'assets/icons/arrow-right.svg'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 0.h,
                                // ),
                              )
                            : SizedBox(
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
                              fontSize: 16,
                              color: stepsColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.h, vertical: 2.h),
                            height: 10.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: fagoSecondaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => FagoToBank(
                                        userDetails: _userController.user!,
                                        accountDetails:
                                            _userController.userAccountDetails!,
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/new_tansfer_icon.svg',
                                        height: 2.5.h,
                                        width: 2.5.w,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Transfer",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const FagoToFago());
                                  },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/new_fagotofago_icon.svg',
                                        height: 2.5.h,
                                        width: 2.5.w,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Fago2Fago",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/new_scanToPay_icon.svg',
                                      height: 2.5.h,
                                      width: 2.5.w,
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    const AutoSizeText(
                                      "Scan to Pay",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: black,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const RequestHome());
                                  },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/new_requestMoney_icon.svg',
                                        height: 2.5.h,
                                        width: 2.5.w,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Request Money",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
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
                                fontSize: 16,
                                color: stepsColor),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 1.h, vertical: 2.h),
                            height: 20.h,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: fagoSecondaryColor.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(8)),
                            alignment: Alignment.center,
                            child: GridView.count(
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 4.0,
                                children:
                                    List.generate(services.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      if (services[index].route != null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                services[index].route!,
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            services[index].image,
                                            height: 2.5.h,
                                            width: 2.5.w,
                                          ),
                                          SizedBox(
                                            height: 1.5.h,
                                          ),
                                          AutoSizeText(
                                            services[index].itemName,
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 8,
                                              color: black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                  );
                                })),
                          ),
                        ),
                        // SizedBox(
                        //   height: 1.5.h,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.h, vertical: 2.h),
                            height: 16.h,
                            width: Get.width,
                            color: fagoSecondaryColorWithOpacity10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  'Manage Multiple Business \nAccounts in One App',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                const AutoSizeText(
                                  'Do you own a business with corporate registration? Manage them within this App or manage for others',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: stepsColor,
                                  ),
                                ),
                                Container(
                                  width: 30.w,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: buttonColor),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3.w, vertical: .8.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/fundAccount_icon.svg'),
                                        const AutoSizeText(
                                          "New Account",
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 8,
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
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          child: Image.asset(
                            'assets/images/refer-earn.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       for (int i = 0;
                        //           i < paymentContents.length;
                        //           i++) ...[
                        //         GestureDetector(
                        //           onTap: () {
                        //             if (paymentContents[i].route != null) {
                        //               Navigator.of(context).push(
                        //                 MaterialPageRoute(
                        //                   builder: (BuildContext context) =>
                        //                       paymentContents[i].route!,
                        //                 ),
                        //               );
                        //             }
                        //           },
                        //           child: Container(
                        //             height: 10.h,
                        //             width: 21.w,
                        //             padding: EdgeInsets.symmetric(
                        //                 vertical: 1.h, horizontal: 1.5.w),
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                   color: fagoSecondaryColor,
                        //                 ),
                        //                 borderRadius: const BorderRadius.all(
                        //                     Radius.circular(5))),
                        //             child: Column(
                        //               mainAxisAlignment:
                        //                   MainAxisAlignment.center,
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.center,
                        //               children: [
                        //                 paymentContents[i].image,
                        //                 SizedBox(
                        //                   height: 1.h,
                        //                 ),
                        //                 SizedBox(
                        //                   width: 20.w,
                        //                   child: AutoSizeText(
                        //                     paymentContents[i].description,
                        //                     textAlign: TextAlign.center,
                        //                     style: const TextStyle(
                        //                       fontFamily: "Work Sans",
                        //                       fontWeight: FontWeight.w400,
                        //                       fontSize: 9,
                        //                       color: inactiveTab,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         ),

                        //         // ),
                        //         // ),
                        //         // if (i != (paymentContents.length - 1))
                        //         //   SizedBox(
                        //         //     width: 2.5.w,
                        //         //   )
                        //       ]
                        //     ],
                        //   ),
                        // ),

                        // SizedBox(
                        //   child: Padding(
                        //     padding: EdgeInsets.only(
                        //         left: 5.w, right: 5.w, top: 1.h),
                        //     child: GridView(
                        //       padding: EdgeInsets.zero,
                        //       physics: const NeverScrollableScrollPhysics(),
                        //       gridDelegate:
                        //           const SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: 4,
                        //               mainAxisSpacing: 12.0,
                        //               crossAxisSpacing: 9.0),
                        //       shrinkWrap: true,
                        //       // runAlignment: WrapAlignment.start,
                        //       // runSpacing: 3.h,
                        //       // direction: Axis.horizontal,
                        //       // crossAxisAlignment: WrapCrossAlignment.start,
                        //       children: [
                        //         for (int i = 0;
                        //             i < serviceContent.length;
                        //             i++) ...[
                        //           GestureDetector(
                        //             onTap: (() {
                        //               if (serviceContent[i].route != null) {
                        //                 Navigator.of(context).push(
                        //                   MaterialPageRoute(
                        //                     builder: (BuildContext context) =>
                        //                         serviceContent[i].route!,
                        //                   ),
                        //                 );
                        //               }
                        //             }),
                        //             child: Container(
                        //               height: 13.h,
                        //               width: 26.w,
                        //               padding: EdgeInsets.symmetric(
                        //                   vertical: 1.h, horizontal: 1.5.w),
                        //               decoration: BoxDecoration(
                        //                   border: Border.all(
                        //                     color: fagoSecondaryColor,
                        //                   ),
                        //                   borderRadius: const BorderRadius.all(
                        //                       Radius.circular(5))),
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: [
                        //                   serviceContent[i].image,
                        //                   SizedBox(
                        //                     height: 1.h,
                        //                   ),
                        //                   if (serviceContent[i].description !=
                        //                       null)
                        //                     SizedBox(
                        //                       width: 20.w,
                        //                       child: AutoSizeText(
                        //                         serviceContent[i].description!,
                        //                         textAlign: TextAlign.center,
                        //                         style: const TextStyle(
                        //                             fontFamily: "Work Sans",
                        //                             fontWeight: FontWeight.w400,
                        //                             fontSize: 9,
                        //                             color: inactiveTab),
                        //                       ),
                        //                     ),
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //           // if (i != (serviceContent.length - 1))
                        //           //   SizedBox(
                        //           //     width: 1.w,
                        //           //   )
                        //         ]
                        //       ],
                        //     ),

                        //     // Padding(
                        //     //     padding:
                        //     //         EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                        //     //     child: const Image(
                        //     //       image: AssetImage("assets/images/Frame 256.png"),
                        //     //     ))
                        //   ),
                        // ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
      //  bottomNavigationBar: const FagoNavigationBar(),
    );
  }

  Future<void> getUserDetails() async {
    final response = await _loginController.getUserDetails();
    final userAccountjsonBodyData = response['data']['accountdetail'];
    final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
    _userController.setUserAccountDetails = userAccountDetails;
  }
}
