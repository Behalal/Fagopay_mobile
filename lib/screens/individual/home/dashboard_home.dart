import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/company_model.dart';
import 'package:fagopay/screens/kyc/personal_verification_page.dart';
import '../../../controllers/company_controller.dart';
import '../../business/book_keeping/booking_keeping.dart';
import '../../business/invoice/all_invoice.dart';
import '../../authentication/account_creation/select_type.dart';
import '../../business/customers/customer.dart';
import '../../business/suppliers/all_supplies.dart';
import 'widgets/services_widget.dart';
import '../sales/sales_page.dart';
import '../../../controllers/login_controller.dart';
import '../../../controllers/user_controller.dart';
import '../../widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import 'widgets/dashboard_details.dart';

import '../../../models/user_model/user.dart';

class DashboardHome extends StatefulWidget {
  final String? accountType;
  final User userDetails;
  final AccountDetail? accountDetails;

  const DashboardHome({
    Key? key,
    required this.userDetails,
    this.accountDetails,
    this.accountType,
  }) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  bool isLoading = false;
  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();

  @override
  void initState() {
    getUserDetails();
    getCompany();
    super.initState();
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
                  height: 32.5.h,
                  child: DashBoardDetails(
                    user: widget.userDetails,
                    accountType: "Individual",
                    accountDetails: widget.accountDetails!,
                    userDetails: _userController.user!,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        widget.userDetails.kycVerified == 1 &&
                                widget.accountType == "Bussiness"
                            ?
                            //
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 2.h,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const AutoSizeText(
                                          '0',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: fagoSecondaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        const AutoSizeText(
                                          'Sub Accounts',
                                          style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: stepsColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                const ViewAccountModal());
                                      },
                                      child: Container(
                                        height: 4.h,
                                        width: 20.5.h,
                                        decoration: BoxDecoration(
                                            color: fagoSecondaryColor,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: fagoSecondaryColor)),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            const AutoSizeText(
                                              'View Accounts',
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
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                height: 0.h,
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
                                              const ProfileKycPage()
                                          //     const KycVerfication(
                                          //   accountType: 'individual',
                                          // ),
                                          ),
                                    );
                                  },
                                  child: Container(
                                    // height: 10.2.h,
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
                                                const Text(
                                                  'Attention',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                //  Text(
                                                //   'Attention ${widget.userDetails.firstName}!',
                                                //   style: const TextStyle(
                                                //     fontSize: 12,
                                                //     fontWeight: FontWeight.w700,
                                                //     color: Colors.white,
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: .4.h,
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
                                height: 0.h,
                              ),

                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.w,
                          ),
                          child: const AutoSizeText(
                            "Payment & Services",
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
                                horizontal: 2.h, vertical: 2.h),
                            //height: 23.h,
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
                                crossAxisSpacing: 4.0.h,
                                mainAxisSpacing: 3.0.h,
                                childAspectRatio: 0.10.h,
                                children:
                                    List.generate(services.length, (index) {
                                  return InkWell(
                                    onTap: () {
                                      if (services[index].route != null &&
                                          widget.userDetails.kycVerified == 0) {
                                        Get.defaultDialog(
                                            title: "",
                                            middleText: "",
                                            titlePadding: EdgeInsets.zero,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 5.h,
                                                    vertical: 3.h),
                                            content: unverifiedUserDialogue());
                                      } else if (services[index].route !=
                                          null) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                services[index].route!,
                                          ),
                                        );
                                      } else if (services[index].route ==
                                              null &&
                                          widget.userDetails.kycVerified == 1 &&
                                          services[index].bill == 'special') {
                                        showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(20),
                                              ),
                                            ),
                                            context: context,
                                            builder: (context) =>
                                                const BillsPayment());
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
                                            height: 1.0.h,
                                          ),
                                          AutoSizeText(
                                            services[index].itemName,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: "Work Sans",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 0,
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
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 5.w,
                          ),
                          child: const AutoSizeText(
                            "Business Tools",
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
                            // height: 10.h,
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
                                    if (widget.userDetails.kycVerified == 0) {
                                      Get.defaultDialog(
                                          title: "",
                                          middleText: "",
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          content: unverifiedUserDialogue());
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CustomerPage(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/customer_new_icon.svg',
                                        height: 2.5.h,
                                        width: 2.5.w,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Customers",
                                        style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 5,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (widget.userDetails.kycVerified == 0) {
                                      Get.defaultDialog(
                                          title: "",
                                          middleText: "",
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          content: unverifiedUserDialogue());
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllSupplies(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/people_icon.svg',
                                        height: 2.5.h,
                                        width: 2.5.w,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Suppliers",
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
                                    if (widget.userDetails.kycVerified == 0) {
                                      Get.defaultDialog(
                                          title: "",
                                          middleText: "",
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          content: unverifiedUserDialogue());
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const BookKeeping(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.house,
                                        size: 2.5.h,
                                        color: fagoSecondaryColor,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Bookkeeping",
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
                                    if (widget.userDetails.kycVerified == 0) {
                                      Get.defaultDialog(
                                          title: "",
                                          middleText: "",
                                          titlePadding: EdgeInsets.zero,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 8),
                                          content: unverifiedUserDialogue());
                                      return;
                                    }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllInvoice(),
                                      ),
                                    );
                                    // Get.to(() => const RequestHome());
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.file_copy,
                                        size: 2.5.h,
                                        color: fagoSecondaryColor,
                                      ),
                                      SizedBox(
                                        height: 1.5.h,
                                      ),
                                      const AutoSizeText(
                                        "Invoice",
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

                        // SizedBox(
                        //   height: 1.5.h,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 2.h),
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                              SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.h, vertical: 2.h),
                                // height: 20.h,
                                width: Get.width,
                                color: fagoSecondaryColor.withOpacity(0.05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    SizedBox(
                                      height: 1.5.h,
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
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => const SelectType());
                                      },
                                      child: Container(
                                        width: 20.h,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
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
                                    ),
                                  ],
                                ),
                              )
                            ],
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

  Widget unverifiedUserDialogue() {
    return SizedBox(
      height: 240,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset('assets/icons/lock_primary.svg'),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            "You don’t have any account",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: fagoSecondaryColor,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            "Create one now",
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: stepsColor,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          const AutoSizeText(
            'You will be able to enjoy our services once we verify your identity.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Work Sans",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: stepsColorWithOpacity55,
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.h),
              child: InkWell(
                onTap: () {
                  Get.to(() => const SelectType());
                },
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 1.w,
                      ),
                      const AutoSizeText(
                        "Open an Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w600,
                          color: white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUserDetails() async {
    final response = await _loginController.getUserDetails();
    final userAccountjsonBodyData = response['data']['accountdetail'];
    final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
    _userController.setUserAccountDetails = userAccountDetails;
  }

  Future<void> getCompany() async {
    final response = await _companyController.getCompany();
    final companyjsonBodyData = response['data']['company_detail'];
    final companyDetails = Company.fromJson(companyjsonBodyData[0]);
    _companyController.setCompany = companyDetails;
  }
}

class ViewAccountModal extends StatefulWidget {
  const ViewAccountModal({
    super.key,
  });

  @override
  State<ViewAccountModal> createState() => _ViewAccountModalState();
}

class _ViewAccountModalState extends State<ViewAccountModal> {
  final _userUcontroller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 0.3.h,
                      width: 10.h,
                      color: fagoSecondaryColor,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const AutoSizeText(
                      'Obasana Designs',
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: fagoSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: stepsColor,
            ),
            // ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoSizeText(
                  '4',
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: fagoSecondaryColor,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                const AutoSizeText(
                  'Sub Accounts',
                  style: TextStyle(
                    fontFamily: "Work Sans",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: stepsColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            const Divider(
              color: stepsColor,
            ),
            // ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 2.h,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const SalesAccount());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                      height: 10.h,
                      width: Get.width,
                      color: fagoSecondaryColor.withOpacity(0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/sub_account_icons.svg',
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          SvgPicture.asset(
                            'assets/icons/vertical_line.svg',
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                'Sales Account | Damburi Branch',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              AutoSizeText(
                                '2038173855 | Guaranty Trust Bank ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor.withOpacity(0.5),
                                ),
                              ),
                              const AutoSizeText(
                                '# 900,340.00',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: fagoSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/arrow_front.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SalesAccount());
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                      height: 10.h,
                      width: Get.width,
                      color: fagoGreenColor.withOpacity(0.05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/sub_account_icons.svg',
                            color: fagoGreenColor,
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          SvgPicture.asset(
                            'assets/icons/vertical_line.svg',
                          ),
                          SizedBox(
                            width: 1.h,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AutoSizeText(
                                'Sales Account | Damburi Branch',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: stepsColor,
                                ),
                              ),
                              AutoSizeText(
                                '2038173855 | Guaranty Trust Bank ',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: stepsColor.withOpacity(0.5),
                                ),
                              ),
                              const AutoSizeText(
                                '# 900,340.00',
                                style: TextStyle(
                                  fontFamily: "Work Sans",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: fagoGreenColor,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/icons/arrow_front.svg',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  InkWell(
                    onTap: () {
                      //  Get.to(() => const SelectType());
                    },
                    child: Container(
                      width: 38.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: buttonColor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.3.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/icons/fundAccount_icon.svg'),
                            const AutoSizeText(
                              "Create Sub Account",
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
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
