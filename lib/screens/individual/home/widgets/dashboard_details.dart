import 'package:auto_size_text/auto_size_text.dart';
import 'package:clipboard/clipboard.dart';
import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/notification_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/screens/authentication/account_creation/select_type.dart';
import 'package:fagopay/screens/individual/notification/notification_screen.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:fagopay/models/user_model/user.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/individual/home/wallets/fund_wallet.dart';

import '../../../../controllers/login_controller.dart';
import '../../../authentication/recover_password_otp_screen.dart';

class DashBoardDetails extends StatefulWidget {
  final UserDetail user;
  final UserDetail userDetails;
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
  bool isLoading = true;
  String notVisibleText = "******";
  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();
  final _notificationController = Get.find<NotificationController>();


  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _userUcontroller.switchedAccountType == 2 ? isUser = false: isUser = true;
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
                      padding: EdgeInsets.only(left: 4.w,),
                      child: Container(
                        padding: const EdgeInsets.only(top: 40, bottom: 0),
                        width: 95.w, height: 18.h,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/image1.png"),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Positioned(
                              top: 6.2.h, width: 13.w,
                              height: 60.09, left: 4.w,
                              child: SvgPicture.asset("assets/images/Frame.svg"),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    _userController.switchedAccountType == 2 ? '${_companyController.company?.companyName?.substring(0, 1)}'??'' :
                                    '${widget.user.firstName?.substring(0, 1) ?? ""}${widget.user.lastName?.substring(0, 1) ?? ""}',
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,wordSpacing: 2),),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(flex: 5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: white,
                                          ),
                                          children: [
                                            const TextSpan(text: 'Welcome'),
                                            TextSpan(
                                              text: ' ${_userController.switchedAccountType == 2 ? _companyController.company?.companyName ?? "" : widget.user.firstName ?? ""}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),

                                      SizedBox(height: 0.6.h),
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
                                            child:  const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children:  [
                                                AutoSizeText(
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
                                                    alignment: AlignmentDirectional.center,
                                                    children:[
                                                      Image(
                                                        image: AssetImage("assets/images/box.png"),
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
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 5.w,
                                ),
                                // Expanded(child: Container()),
                                // const Icon(
                                //   Icons.qr_code_scanner,
                                //   size: 20,
                                //   color: white,
                                // ),
                                // SizedBox(
                                //   width: 2.w,
                                // ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(()=>const NotificationScreen());
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => BusinessHome(
                                    //       userDetails: widget.userDetails,
                                    //       accountDetails: widget.accountDetails!,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Stack(
                                    children: [
                                      const Icon(
                                        Icons.notifications,
                                        size: 30,
                                        color: white,
                                      ),
                                      Container(height: 18, width: 18,
                                        decoration: BoxDecoration(shape: BoxShape.circle,
                                            border: Border.all(color: Colors.blue), color: Colors.blue),
                                        child: Center(child: Text(_notificationController.notificationLength.toString(),
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),)),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
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
                    padding: EdgeInsets.only(left: 4.w, bottom: 20),
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
                                      ? ((widget.accountDetails!.balance.toString() == "") ? " 0.00"
                                          : "$currencySymbol ${_userController.switchedAccountType == 2 ? _companyController.company!.account!.balance : _userController.userAccountDetails!.balance}.00") : notVisibleText,
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
                                (balanceVisible) ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                                color: white,
                                size: 20,
                              ),
                            ),
                            const Spacer(),
                            isLoading? Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: const Center(child: SizedBox(height: 15, width: 15,
                                  child: CircularProgressIndicator(color: fagoSecondaryColor, strokeWidth: 2,))),
                            ):GestureDetector(
                              onTap: ()async{
                                getUserDetails();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 12),
                                decoration: const BoxDecoration(
                                  color: Colors.transparent
                                ),
                                 child: Row(
                                   children: [
                                     const Icon(Icons.refresh,color: white),
                                     SizedBox(width: 1.w,),
                                     Text('Refresh',style: Constant().textStyle(size: 14, weight: FontWeight.w600,color: white),)
                                   ],
                                 ),
                              ),
                            ),
                             SizedBox(width: 2.w,)
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
                                    _userController.switchedAccountType == 2
                                        ? _companyController
                                            .company!.account!.bankName!
                                        : widget.accountDetails!.bankName!,
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
                                        _userController.switchedAccountType == 2
                                            ? _companyController.company!
                                                .account!.accountNumber!
                                            : widget
                                                .accountDetails!.accountNumber!,
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
                                          if (widget.accountDetails!.accountNumber! == "") {
                                            print('enter text');
                                          } else {
                                            print(widget.accountDetails!.accountNumber!);
                                            FlutterClipboard.copy(widget.accountDetails!.accountNumber!).then((value) => print('copied'));
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
                              padding: EdgeInsets.only(right: 5.w),
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FundWallet(
                                        accountDetails: _userController
                                                    .switchedAccountType ==
                                                2
                                            ? _companyController
                                                .company!.account!
                                            : widget.accountDetails!,
                                      ),
                                    ),
                                  );
                                }),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
  Future<void> getUserDetails() async {
    setState(() {
      isLoading = true;
    });
   await _loginController.getUserDetails().then((value) {
     if(value != null){
       final userjsonBodyData = value.data['data']['userdetail'];
       final userDetails = UserDetail.fromJson(userjsonBodyData);
       final userAccountjsonBodyData = value.data['data']['userdetail']['accountdetail'];
       final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
         isLoading = false;
         _userController.setUserAccountDetails = userAccountDetails;
         _userController.setUser = userDetails;
       if (kDebugMode) {
         print("Account refreshed successfully");
       }
     }else{
       if (kDebugMode) {
         print('Something went wrong, cant refresh balance');
       }
     }
    });
    // print(' response is = ${response['data']['userdetail']['nextofkin']}');

    // print('User details are kyc number is ${userDetails.kycVerified}');
  }

}

enum AccountType { individual, business }

class ManageAccount extends StatefulWidget {
  final UserDetail userDetails;
  const ManageAccount({super.key, required this.userDetails});

  @override
  State<ManageAccount> createState() => _ManageAccountState();
}

class _ManageAccountState extends State<ManageAccount> {
  final _userUcontroller = Get.find<UserController>();
  final _companyController = Get.find<CompanyController>();
  final scrollController = ScrollController();

  ///Cache account Number
  Future<void> saveAccountId({required String accountId}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("accountId", accountId);
  }
  ///Cache Company ID
  Future<void> saveCompanyId({required String companyId}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("companyId", companyId);
  }
  @override
  Widget build(BuildContext context) {
    return widget.userDetails.kycVerified == 1
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 2.h),
            height: Get.height * 0.75,
            child: SingleChildScrollView(
              physics:  const BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        SizedBox(height: 1.5.h,),
                        const Divider(color: stepsColor,),
                        SizedBox(height: 1.h,),
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
                      _userUcontroller.switchedAccountType = 1;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                          (route) => false);
                      // Navigator.of(context).pop();
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      width: Get.width,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: fagoSecondaryColor.withOpacity(0.05),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //_userUcontroller.switchedAccountType == 2 ? '${_companyController.company?.companyName?.substring(0, 1)}'??'' :
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: fagoSecondaryColor.withOpacity(0.05),
                              child: Text('${_userUcontroller.user?.firstName?.substring(0, 1)}${_userUcontroller.user?.lastName?.substring(0, 1)}',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,wordSpacing: 2),),
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
                                  height: 2.5.h,
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
                  const Divider(
                    color: stepsColor,
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
                  SizedBox(height: 2.h,),
                  _companyController.companies.isEmpty
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.h),
                            child: const Text(
                                'No Created Company/Business Account!'),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Obx(
                              () => ListView.builder(
                                controller: scrollController,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: _companyController.companies.length,
                                itemBuilder: (context, index) =>
                                    CustomCompanyCard(
                                  companyName: _companyController
                                      .companies[index].companyName!,
                                  companyType: _companyController
                                          .companies[index].companyType ??
                                      'Manager',
                                  onPressed: () async {
                                    _companyController.setCompany = _companyController.companies[index];
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => const Dashboard()), (route) => false);
                                    _userUcontroller.switchedAccountType = 2;
                                    saveAccountId(accountId: _companyController.companies[index].account?.accountNumber ?? "");
                                    saveCompanyId(companyId: _companyController.companies[index].id ?? "");
                                    setState(() {});
                                  },
                                  isActive: _userUcontroller.switchedAccountType == 2 && _companyController.companies[index].id == _companyController.company!.id
                                          ? Colors.green
                                          : Colors.transparent,
                                ),
                              ),
                            )
                          ],
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
                        padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                        width: Get.width,
                        color: fagoSecondaryColor.withOpacity(0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AutoSizeText(
                              'Manage Individual and Business \nAccounts in One App',
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: fagoSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 10,),
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
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: () {
                                Get.to(() => const SelectType());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: buttonColor),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/fundAccount_icon.svg'),
                                    const SizedBox(width: 10,),
                                    const Text(
                                      "Create New Business Account",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 13,
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

class CustomCompanyCard extends StatelessWidget {
  const CustomCompanyCard({
    super.key,
    required this.companyName,
    required this.companyType,
    required this.onPressed,
    required this.isActive,
  });

  final String companyName, companyType;
  final VoidCallback onPressed;
  final Color isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 1.h),
        padding: const EdgeInsets.all(18),
        width: Get.width,
        decoration: BoxDecoration(
          color: fagoSecondaryColor.withOpacity(0.05),
          border: Border.all(
            width: 2,
            color: isActive,
          ),
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30, backgroundColor: fagoSecondaryColor.withOpacity(0.05),
                child: Text(companyName.substring(0, 1) ?? "",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800,color: fagoSecondaryColor,wordSpacing: 2),),
              ),
              SizedBox(width: 1.h,),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(
                      companyName,
                      style: const TextStyle(
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(25)),
                      child: AutoSizeText(
                        companyType,
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SvgPicture.asset('assets/icons/arrow_front.svg')
            ]),
      ),
    );
  }

}
