// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/authentication/account_creation/select_type.dart';
import 'package:fagopay/screens/business/home/home.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/home/wallets/fund_wallet.dart';

class DashBoardDetails extends StatefulWidget {
  final User user;
  final User userDetails;
  final String? accountType;
  final AccountDetail? accountDetails;

  const DashBoardDetails({
    Key? key,
    required this.user,
    this.accountType,
    this.accountDetails,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<DashBoardDetails> createState() => _DashBoardDetailsState();
}

class _DashBoardDetailsState extends State<DashBoardDetails> {
  bool balanceVisible = true;
  String notVisibleText = "******";
  final _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100.h,
            // height: 30.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              linearGradient2,
              linearGradient1,
            ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 1.w,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 0),
                        width: 95.w,
                        height: 18.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/image1.png"),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Positioned(
                              top: 6.2.h,
                              width: 13.w,
                              height: 60.09,
                              left: 4.w,
                              child:
                                  SvgPicture.asset("assets/images/Frame.svg"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: 7.w,
                                  ),
                                ),
                                const CircleAvatar(
                                  radius: 25, // Image radius
                                  backgroundImage:
                                      AssetImage('assets/images/fago(2).png'),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        RichText(
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: white,
                                            ),
                                            children: [
                                              TextSpan(text: 'Welcome'),
                                              // TextSpan(
                                              //   text:
                                              //       ' ${widget.user.firstName}',
                                              //   style: const TextStyle(
                                              //     fontWeight: FontWeight.w700,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 3.h),
                                        // PopupMenuButton<String>(
                                        //   offset: const Offset(0, 50),
                                        //   initialValue: widget.accountType ==
                                        //           "Individual"
                                        //       ? AccountType.individual.toString()
                                        //       : AccountType.business.toString(),
                                        //   onSelected: (selectedItem) {
                                        //     if (selectedItem ==
                                        //         AccountType.business.toString()) {
                                        //       Navigator.of(context)
                                        //           .pushReplacement(
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 const BusinessDashboard()

                                        //             //     BusinessHome(
                                        //             //   userDetails: widget.user,
                                        //             //   accountDetails:
                                        //             //       widget.accountDetails,
                                        //             // ),
                                        //             ),
                                        //       );
                                        //       return;
                                        //     }
                                        //     Navigator.of(context).pushReplacement(
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               const Dashboard()
                                        //           //     DashboardHome(
                                        //           //   userDetails: widget.user,
                                        //           //   accountDetails:
                                        //           //       widget.accountDetails,
                                        //           // ),
                                        //           ),
                                        //     );
                                        //   },
                                        //   itemBuilder: (BuildContext context) =>
                                        //       <PopupMenuEntry<String>>[
                                        //     PopupMenuItem<String>(
                                        //       value: AccountType.individual
                                        //           .toString(),
                                        //       child: const Text('Individual'),
                                        //     ),
                                        //     PopupMenuItem<String>(
                                        //       value:
                                        //           AccountType.business.toString(),
                                        //       child: const Text('Business'),
                                        //     ),
                                        //   ],
                                        //   child: Stack(
                                        //     alignment:
                                        //         AlignmentDirectional.center,
                                        //     children: const [
                                        //       Image(
                                        //         image: AssetImage(
                                        //             "assets/images/box.png"),
                                        //         height: 20,
                                        //         width: 20,
                                        //       ),
                                        //       Icon(
                                        //         Icons.keyboard_arrow_down_rounded,
                                        //         color: white,
                                        //         size: 15,
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          context: context,
                                          builder: (context) => ManageAccount(
                                            userDetails: _userController.user!,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 33.w,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                          color: white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 0.4.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const AutoSizeText(
                                                "Switch Account",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 7,
                                                  fontWeight: FontWeight.w500,
                                                  color: black,
                                                ),
                                              ),
                                              Expanded(
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: const [
                                                    Image(
                                                      image: AssetImage(
                                                          "assets/images/box.png"),
                                                      height: 20,
                                                      width: 20,
                                                      color: stepsColor,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: stepsColor,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 5.w,
                                ),
                                // Expanded(child: Container()),
                                const Icon(
                                  Icons.qr_code_scanner,
                                  size: 20,
                                  color: white,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // SecureStorage.deleteUserIdentifier();
                                    // SecureStorage.deleteUserToken();
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => const SignIn()),
                                    //     (route) => false);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BusinessHome(
                                          userDetails: widget.userDetails,
                                          accountDetails:
                                              widget.accountDetails!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.notifications,
                                    size: 20,
                                    color: white,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     // SecureStorage.deleteUserIdentifier();
                                //     // SecureStorage.deleteUserToken();
                                //     // Navigator.of(context).pushAndRemoveUntil(
                                //     //     MaterialPageRoute(
                                //     //         builder: (context) => const SignIn()),
                                //     //     (route) => false);
                                //   },
                                //   child: const Icon(
                                //     Icons.notifications,
                                //     size: 20,
                                //     color: white,
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.userDetails.kycVerified == 1)
                  Padding(
                    padding: EdgeInsets.only(left: 9.w, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Wallet Balance",
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: white,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => AutoSizeText(
                                  (balanceVisible)
                                      ? ((widget.accountDetails!.balance
                                                  .toString() ==
                                              "")
                                          ? " 0.00"
                                          : "$currencySymbol ${_userController.userAccountDetails!.balance}.00")
                                      : notVisibleText,
                                  style: const TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: white),
                                )),
                            SizedBox(
                              width: 2.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  balanceVisible = !balanceVisible;
                                });
                              },
                              child: Icon(
                                (balanceVisible)
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: white,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.accountDetails!.accountName != "")
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    widget.accountDetails!.bankName!,
                                    style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: white),
                                  ),
                                  SizedBox(
                                    height: 0.2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        widget.accountDetails!.accountNumber!,
                                        style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: white),
                                      ),
                                      SizedBox(
                                        width: 1.5.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (widget.accountDetails!
                                                  .accountNumber! ==
                                              "") {
                                            print('enter text');
                                          } else {
                                            print(widget.accountDetails!
                                                .accountNumber!);
                                            FlutterClipboard.copy(widget
                                                    .accountDetails!
                                                    .accountNumber!)
                                                .then(
                                                    (value) => print('copied'));
                                            Get.snackbar(
                                                'Account Number Copied',
                                                widget.accountDetails!
                                                    .accountNumber!,
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 3.h,
                                                  vertical: 2.h,
                                                ));
                                          }
                                        },
                                        child: const Icon(
                                          Icons.copy,
                                          color: white,
                                          size: 18,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FundWallet(
                                        accountDetails: widget.accountDetails!,
                                      ),
                                    ),
                                  );
                                }),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/fundAccount_icon.svg'),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    const AutoSizeText(
                                      "Fund Account",
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                else if (widget.userDetails.kycVerified == 2 &&
                    widget.accountDetails == null)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 8, right: 8, top: 1),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                          SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                          Container(
                            padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                            height: 12.h,
                            width: 40.h,
                            decoration: const BoxDecoration(
                              color: white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "Account Creation in Progress",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                AutoSizeText(
                                  "Verify your identity and ",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5.sp,
                                    color: stepsColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SelectType());
                                  },
                                  child: Container(
                                    width: 35.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: buttonColor),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: .9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/fundAccount_icon.svg'),
                                          const AutoSizeText(
                                            "Get an Account",
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
                  )
                else if (widget.userDetails.kycVerified == 0)
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 8, right: 8, top: 1),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                          SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                          Container(
                            padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                            height: 12.h,
                            width: 40.h,
                            decoration: const BoxDecoration(
                              color: white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "No account created",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: fagoSecondaryColor,
                                  ),
                                ),
                                AutoSizeText(
                                  "Verify your identity and ",
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 5.sp,
                                    color: stepsColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => const SelectType());
                                  },
                                  child: Container(
                                    width: 40.w,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: buttonColor),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 3.w, vertical: .9.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/fundAccount_icon.svg'),
                                          const AutoSizeText(
                                            "Get an Account",
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
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum AccountType { individual, business }

class ManageAccount extends StatefulWidget {
  final User userDetails;
  const ManageAccount({super.key, required this.userDetails});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final _userUcontroller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return widget.userDetails.kycVerified == 1
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
            height: Get.height * .7,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 0.4.h,
                          width: 10.h,
                          color: fagoSecondaryColor,
                        ),

                        SizedBox(
                          height: 1.h,
                        ),
                        const AutoSizeText(
                          'Manage Accounts',
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: fagoSecondaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Divider(
                          color: stepsColor.withOpacity(0.3),
                        ),
                        // ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
                  const AutoSizeText(
                    'Personal Account',
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: stepsColor,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const Dashboard());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      width: Get.width,
                      //height: 10.h,
                      decoration: BoxDecoration(
                        color: fagoSecondaryColor.withOpacity(0.05),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 27, // Image radius
                              backgroundImage:
                                  AssetImage('assets/images/fago(2).png'),
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    AutoSizeText(
                                      _userUcontroller.user!.firstName ?? '',
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: welcomeText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.5.h,
                                    ),
                                    AutoSizeText(
                                      _userUcontroller.user!.lastName ?? '',
                                      style: const TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: welcomeText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.h),
                                  //height: 2.5.h,
                                  // width: 11.5.h,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  child: const AutoSizeText(
                                    'Owner',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            SvgPicture.asset('assets/icons/owner_icon.svg')
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Divider(
                    color: stepsColor.withOpacity(0.3),
                  ),
                  // ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  const AutoSizeText(
                    'Business I manage',
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: stepsColor,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: InkWell(
                      onTap: () {
                        print('cliked');
                        Get.to(() => const Dashboard());
                        //  Get.to(() => FagoMainPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        width: Get.width,
                        //height: 10.h,
                        decoration: BoxDecoration(
                          color: fagoSecondaryColor.withOpacity(0.05),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 27, // Image radius
                                backgroundImage:
                                    AssetImage('assets/images/fago(2).png'),
                              ),
                              SizedBox(
                                width: 1.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AutoSizeText(
                                    'Obasana Designs',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: welcomeText,
                                    ),
                                  ),
                                  SizedBox(
                                    height: .5.h,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1.h),
                                    height: 2.5.h,
                                    // width: 11.5.h,
                                    decoration: BoxDecoration(
                                        color: white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      'Owner',
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: fagoSecondaryColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              SvgPicture.asset('assets/icons/arrow_front.svg')
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      width: Get.width,
                      //  height: 10.h,
                      decoration: BoxDecoration(
                        color: fagoSecondaryColor.withOpacity(0.05),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 27, // Image radius
                              backgroundImage:
                                  AssetImage('assets/images/fago(2).png'),
                            ),
                            SizedBox(
                              width: 1.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const AutoSizeText(
                                  'Fagopay Limited',
                                  style: TextStyle(
                                    fontFamily: "Work Sans",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: welcomeText,
                                  ),
                                ),
                                SizedBox(
                                  height: .5.h,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 1.h),
                                  height: 2.5.h,
                                  // width: 11.5.h,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  child: const AutoSizeText(
                                    'Manager',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: fagoSecondaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            SvgPicture.asset('assets/icons/arrow_front.svg')
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                      SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        // height: 17.h,
                        width: Get.width,
                        color: fagoSecondaryColor.withOpacity(0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText(
                              'Manage individualn Business \nAccounts in One App',
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
                                width: 60.w,
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
                                        "Create New Business Account",
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
                ],
              ),
            ),
          )
        : SizedBox(
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
                          'Manage Accounts',
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
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                  ),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SvgPicture.asset('assets/icons/Ellipse 278.svg'),
                      SvgPicture.asset('assets/icons/Ellipse 279.svg'),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.h, vertical: 2.h),
                        height: 25.h,
                        width: Get.width,
                        color: fagoSecondaryColor.withOpacity(0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/user-tick.svg',
                              color: stepsColor.withOpacity(0.5),
                            ),
                            const AutoSizeText(
                              'No account created',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: fagoSecondaryColor,
                              ),
                            ),
                            const AutoSizeText(
                              'Create an account and verify your identity ',
                              textAlign: TextAlign.start,
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
                            InkWell(
                              onTap: () {
                                Get.to(() => const SelectType());
                              },
                              child: Container(
                                width: 37.w,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: buttonColor),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3.w, vertical: 1.3.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/fundAccount_icon.svg'),
                                      const AutoSizeText(
                                        "Open an Account",
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
              ],
            ),
          );
  }
}
