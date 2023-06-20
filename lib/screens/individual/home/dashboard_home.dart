import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/notification_controller.dart';
import 'package:fagopay/local_notification_services.dart';
import 'package:fagopay/screens/authentication/widgets/email_phone_input.dart';
import 'package:fagopay/screens/individual/bills/qr_code/my_qr_code.dart';
import 'package:fagopay/screens/individual/requests/share_payment_link.dart';
import 'package:fagopay/screens/widgets/navigation_bar.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controllers/government_identity_verification_controller.dart';
import '../bills/data.dart';
import '../bills/swap_airtime.dart';
import '../refer_and_win/refer_page.dart';
import '../requests/requests.dart';
import '../transactions/fago_to_bank.dart';
import '../transactions/fago_to_fago.dart';
import '../../kyc/personal_verification_page.dart';
import '../../business/book_keeping/booking_keeping.dart';
import '../../business/invoice/all_invoice.dart';
import '../../authentication/account_creation/select_type.dart';
import '../../business/customers/customers.dart';
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
  final UserDetail userDetails;
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
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  final _loginController = Get.find<LoginController>();
  final _userController = Get.find<UserController>();
  final _notificationController = Get.put(NotificationController());
  final _governmentIdentityController = Get.find<GovernmentIdentityVerificationController>();

  Timer interval(Duration duration, func) {
    Timer function() {
      Timer timer = Timer(duration, function);

      func(timer);

      return timer;
    }

    return Timer(duration, function);
  }

  checkEmailOrPassword(){
    WidgetsBinding.instance.addPostFrameCallback((_){
      if(_userController.user?.email == null || _userController.user?.email == ""){
        interval(const Duration(minutes: 1), (timer) {
          showEmailAlertDialog(context);
          if (kDebugMode) {
            print(_userController.emailPromptCount++);
          }
          if (_userController.emailPromptCount > 0) timer.cancel();
        });
      }else if(_userController.user?.phoneNumber == null || _userController.user?.phoneNumber == ""){
        interval(const Duration(minutes: 1), (timer) {
          showPhoneNumberAlertDialog(context);
          if (kDebugMode) {
            print(_userController.phonePromptCount++);
          }
          if (_userController.phonePromptCount > 0) timer.cancel();
        });
      }
    });
  }

  String? otpText;
  final controller = TextEditingController();

  void showOtpDialog({required String emailOrPhone}){
    showDialog(context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height/2, color: fagoSecondaryColorWithOpacity10.withOpacity(0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5,),
                  Container(height: 1, width: 100, color: fagoSecondaryColor,),
                  const SizedBox(height: 30,),
                  const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/home_nav_logo.png',height: 30, width: 30,),
                      // const SizedBox(width: 10,),
                      AutoSizeText(
                        'Verify Email/Phone',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: fagoSecondaryColor,),
                  const SizedBox(height: 40,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Provide OTP',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "We sent OTP to $emailOrPhone Please \ncheck your inbox and enter the OTP received.",
                        style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                      padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
                      child: PinCodeTextField(
                        length: 6, controller: controller,
                        appContext: Get.context!,
                        pastedTextStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 36,
                          color: inactiveTab,
                        ),
                        keyboardType: TextInputType.number,
                        pinTheme: PinTheme(
                          activeColor: signInText,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 38,
                          fieldWidth: 38,
                          activeFillColor: Colors.white,
                        ),
                        onChanged: (String value) async {
                          if(value.isEmpty || value == ''){
                            Get.snackbar("Error", "Please enter OTP");
                          }else if (value.length < 6){
                            null;
                          }else if (value.length == 6) {
                            otpText = controller.text;
                          }
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Didn\'t recieve an otp?',
                            style: TextStyle(
                              color: fagoSecondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Container()),
                        const Icon(
                          Icons.refresh,
                          size: 15,
                          color: fagoSecondaryColor,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            resendEmailPhoneNumberPromptOtp(phoneNumberOrPassword: emailOrPhone);
                          },
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              color: fagoSecondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: InkWell(
                      onTap: (){
                        Get.back();
                        verifyOtp(phoneNumberOrPassword: emailOrPhone, otp: otpText!);
                      },
                      child: Container(
                          height: 43,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: fagoSecondaryColor,
                          ),
                          child: const Center(
                            child: AutoSizeText(
                              "Continue",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Work Sans",
                                  fontWeight: FontWeight.w600,
                                  color: white),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showEmailAlertDialog(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height/2, color: fagoSecondaryColorWithOpacity10.withOpacity(0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5,),
                  Container(height: 1, width: 100, color: fagoSecondaryColor,),
                  const SizedBox(height: 30,),
                  const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/home_nav_logo.png',height: 30, width: 30,),
                      // const SizedBox(width: 10,),
                      AutoSizeText(
                        'SetUp Email',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: fagoSecondaryColor,),
                  const SizedBox(height: 40,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'Verify Email',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "Setup Email address to get access to \nimportant information and updates.",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: EmailPhone(
                      prefixIcon: const Icon(Icons.email_outlined, color: signInText,),
                      hintText: "Enter email",
                      controller: emailController,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: GestureDetector(
                      onTap: (){
                        if(emailController.text.isEmpty){
                          Get.snackbar("Error", "Please enter a valid email address", backgroundColor: Colors.white, colorText: stepsColor);
                        }else{
                          Get.back();
                          verifyEmailOrPassword(emailOrPhoneNumber: emailController.text);
                        }
                      },
                      child: Container(
                        height: 43, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text("Continue", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight:  FontWeight.w700),)),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });
  }

  void showPhoneNumberAlertDialog(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: MediaQuery.of(context).size.height/2, color: fagoSecondaryColorWithOpacity10.withOpacity(0.05),
              child:  Column(mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5,),
                  Container(height: 1, width: 100, color: fagoSecondaryColor,),
                  const SizedBox(height: 30,),
                  const Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset('assets/images/home_nav_logo.png', height: 30, width: 30,),
                      // const SizedBox(width: 10,),
                      AutoSizeText(
                        'Verify Phone Number',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: fagoSecondaryColor,),
                  const SizedBox(height: 40,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        'SetUp Phone Number',
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: fagoSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Align(alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                      "Setup PhoneNumber to get access to \nimportant information and updates.",
                        style: TextStyle(
                          fontFamily: "Work Sans",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: stepsColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: EmailPhone(
                      prefixIcon: const Icon(Icons.local_phone, color: signInText,),
                      hintText: "Enter phone number",
                      controller: phoneNumber,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: GestureDetector(
                      onTap: (){
                        if(phoneNumber.text.isEmpty){
                          Get.snackbar("Error", "Please enter a valid phone number",backgroundColor: Colors.white, colorText: stepsColor);
                        }else{
                          Get.back();
                          verifyEmailOrPassword(emailOrPhoneNumber: phoneNumber.text);
                        }
                      },
                      child: Container(
                        height: 43, decoration: BoxDecoration(color: fagoSecondaryColor, borderRadius: BorderRadius.circular(30)),
                        child: Center(child: Text("Continue", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),)),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20,),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    _notificationController.getNotification();
    checkEmailOrPassword();
    getUserDetails();
    getIdentityDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Update this shitty code back
    ///getUserDetails();
    // print(' user details is ${_loginController.getUserDetails()}');
    return Scaffold(
      body: (isLoading)
          ? const Loading()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32.5.h,
                  child: Obx(() {
                    return DashBoardDetails(
                      user: widget.userDetails,
                      accountType: "Individual",
                      accountDetails: widget.accountDetails!,
                      userDetails: _userController.user!,
                    );
                  }),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Obx(() {
                      // print(
                      //     ' user details Under home Obx ${_loginController.getUserDetails()}');
                      if (_loginController.getUserStatus == GetUserStatus.loading) {
                        return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                widget.userDetails.kycVerified == 1 && widget.accountType == "Bussiness" ?
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
                                                      borderRadius: BorderRadius.vertical(
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
                                                    borderRadius: BorderRadius.circular(25),
                                                    border: Border.all(color: fagoSecondaryColor)),
                                                alignment: Alignment.center,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    const AutoSizeText(
                                                      'View Accounts',
                                                      style: TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: white,
                                                      ),
                                                    ),
                                                    SvgPicture.asset('assets/icons/arrow-right.svg')
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
                                                  builder:
                                                      (BuildContext context) =>
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Container(
                                                      padding: const EdgeInsets.all(8),
                                                      color: white, height: 35, width: 35,
                                                      child: SvgPicture.asset('assets/icons/bi_shield-lock.svg',
                                                        color: fagoSecondaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      children: [
                                                        const Text(
                                                          'Attention',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w700,
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
                                                  SvgPicture.asset('assets/icons/arrow-right.svg'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        // SizedBox(
                                        //   height: 0.h,
                                        // ),
                                      ) :
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
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //     horizontal: 5.w,
                                //   ),
                                //   child: Container(
                                //     padding: EdgeInsets.symmetric(
                                //         horizontal: 2.h, vertical: 2.h),
                                //     //height: 23.h,
                                //     width: Get.width,
                                //     decoration: BoxDecoration(
                                //         color: fagoSecondaryColor.withOpacity(0.05),
                                //         borderRadius: BorderRadius.circular(8)),
                                //     alignment: Alignment.center,
                                //     child: GridView.count(
                                //         padding: EdgeInsets.zero,
                                //         physics: const NeverScrollableScrollPhysics(),
                                //         shrinkWrap: true,
                                //         crossAxisCount: 4,
                                //         crossAxisSpacing: 4.0.h,
                                //         mainAxisSpacing: 3.0.h,
                                //         childAspectRatio: 0.10.h,
                                //         children:
                                //             List.generate(services.length, (index) {
                                //           return InkWell(
                                //             onTap: () {
                                //               // if (services[index].route != null &&
                                //               //     widget.userDetails.kycVerified == 0) {
                                //               //   Get.defaultDialog(
                                //               //       title: "",
                                //               //       middleText: "",
                                //               //       titlePadding: EdgeInsets.zero,
                                //               //       contentPadding:
                                //               //           EdgeInsets.symmetric(
                                //               //               horizontal: 5.h,
                                //               //               vertical: 3.h),
                                //               //       content: unverifiedUserDialogue());
                                //               // } else if (services[index].route !=
                                //               //     null) {
                                //               //   Navigator.of(context).push(
                                //               //     MaterialPageRoute(
                                //               //       builder: (BuildContext context) =>
                                //               //           services[index].route!,
                                //               //     ),
                                //               //   );
                                //               // } else if (services[index].route ==
                                //               //         null &&
                                //               //     widget.userDetails.kycVerified == 1 &&
                                //               //     services[index].bill == 'special') {
                                //               //   showModalBottomSheet(
                                //               //       isScrollControlled: true,
                                //               //       shape: const RoundedRectangleBorder(
                                //               //         borderRadius:
                                //               //             BorderRadius.vertical(
                                //               //           top: Radius.circular(20),
                                //               //         ),
                                //               //       ),
                                //               //       context: context,
                                //               //       builder: (context) =>
                                //               //           const BillsPayment());
                                //               // }
                                //             },
                                //             child: Column(children: [
                                //               Column(
                                //                 crossAxisAlignment:
                                //                     CrossAxisAlignment.center,
                                //                 children: [
                                //                   SvgPicture.asset(
                                //                     services[index].image,
                                //                     height: 2.5.h,
                                //                     width: 2.5.w,
                                //                   ),
                                //                   SizedBox(
                                //                     height: 1.0.h,
                                //                   ),
                                //                   AutoSizeText(
                                //                     services[index].itemName,
                                //                     textAlign: TextAlign.center,
                                //                     style: const TextStyle(
                                //                       fontFamily: "Work Sans",
                                //                       fontWeight: FontWeight.w400,
                                //                       fontSize: 0,
                                //                       color: black,
                                //                     ),
                                //                   ),
                                //                 ],
                                //               )
                                //             ]),
                                //           );
                                //         })),
                                //   ),
                                // ),
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
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (widget.userDetails
                                                        .kycVerified ==
                                                    0) {
                                                  Get.defaultDialog(
                                                      title: "",
                                                      middleText: "",
                                                      titlePadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FagoToBank(
                                                      userDetails: _userController.user!,
                                                      accountDetails: _userController.userAccountDetails!,
                                                    ),
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
                                                    "Transfer \nMoney",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      titlePadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      content:
                                                          unverifiedUserDialogue());
                                                  return;
                                                }
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const FagoToFago()),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/new_paymentLink_icon.svg',
                                                    height: 2.5.h,
                                                    width: 2.5.w,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const AutoSizeText(
                                                    "Fago 2 \nFago",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }else{
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const MyQrCode()));
                                                }
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) => FagoToBank(
                                                //       userDetails:
                                                //           _userController.user!,
                                                //       accountDetails: _userController
                                                //           .userAccountDetails!,
                                                //     ),
                                                //   ),
                                                // );
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset('assets/icons/new_scanToPay_icon.svg', height: 2.5.h, width: 2.5.w,),
                                                  SizedBox(height: 1.5.h,),
                                                  const AutoSizeText("Scan to \nPay", textAlign: TextAlign.center,
                                                    style: TextStyle(fontFamily: "Work Sans", fontWeight: FontWeight.w400, fontSize: 5, color: black,),),
                                                ],
                                              ),
                                            ),
                                            _userController.switchedAccountType == 2 ? Container() : InkWell(
                                              onTap: () {
                                                if (widget.userDetails.kycVerified == 0) {
                                                  Get.defaultDialog(title: "", middleText: "", titlePadding: EdgeInsets.zero, contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RequestHome()),);
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset('assets/icons/new_requestMoney_icon.svg', height: 2.5.h, width: 2.5.w,),
                                                  SizedBox(height: 1.5.h,),
                                                  const AutoSizeText("Request \nMoney",
                                                    textAlign: TextAlign.center, style: TextStyle(fontFamily: "Work Sans", fontWeight: FontWeight.w400, fontSize: 5, color: black,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Divider(
                                          color: stepsColor.withOpacity(0.3),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (widget.userDetails.kycVerified == 0) {
                                                  Get.defaultDialog(title: "", middleText: "", titlePadding: EdgeInsets.zero,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BuyData()),);
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/new_airtime_icon.svg',
                                                    height: 2.5.h,
                                                    width: 2.5.w,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const AutoSizeText(
                                                    "Airtime \n& Data",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 5,
                                                      color: black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (widget.userDetails
                                                        .kycVerified ==
                                                    0) {
                                                  Get.defaultDialog(
                                                      title: "",
                                                      middleText: "",
                                                      titlePadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      content:
                                                          unverifiedUserDialogue());
                                                  return;
                                                }
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                        top:
                                                            Radius.circular(20),
                                                      ),
                                                    ),
                                                    context: context,
                                                    builder: (context) =>
                                                        const BillsPayment());

                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const BuyData()),
                                                // );
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/new_payInternet_icon.svg',
                                                    height: 2.5.h,
                                                    width: 2.5.w,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const AutoSizeText(
                                                    "Bills \nPayment",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 5,
                                                      color: black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            _userController.switchedAccountType == 2 ? InkWell(
                                              onTap: () {
                                                if (widget.userDetails.kycVerified == 0) {
                                                  Get.defaultDialog(
                                                      title: "",
                                                      middleText: "",
                                                      titlePadding:
                                                      EdgeInsets.zero,
                                                      contentPadding:
                                                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const CountdownPage2()),
                                                // );
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const kyc_success()),
                                                // );
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                      const SharePaymentLink()),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/new_payment_link.svg',
                                                    height: 2.5.h,
                                                    width: 2.5.w,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const AutoSizeText(
                                                    "Payment \nLink",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 5,
                                                      color: black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ) :
                                            InkWell(
                                              onTap: () {
                                                if (widget.userDetails.kycVerified == 0) {
                                                  Get.defaultDialog(title: "",
                                                      middleText: "", titlePadding: EdgeInsets.zero,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SwapAirtime()),);
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset('assets/icons/new_swapAirtime_icon.svg', height: 2.5.h, width: 2.5.w,),
                                                  SizedBox(height: 1.5.h,),
                                                  const AutoSizeText("Swap \nAirtime", textAlign: TextAlign.center,
                                                    style: TextStyle(fontFamily: "Work Sans", fontWeight: FontWeight.w400, fontSize: 5, color: black,),),
                                                ],
                                              ),
                                            ),
                                            _userController.switchedAccountType == 2 ? const SizedBox() : InkWell(
                                              onTap: () {
                                                if (widget.userDetails.kycVerified == 0) {
                                                  Get.defaultDialog(
                                                      title: "",
                                                      middleText: "",
                                                      titlePadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                      content: unverifiedUserDialogue());
                                                  return;
                                                }
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const CountdownPage2()),
                                                // );
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           const kyc_success()),
                                                // );
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const SharePaymentLink()),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/new_payment_link.svg',
                                                    height: 2.5.h,
                                                    width: 2.5.w,
                                                  ),
                                                  SizedBox(
                                                    height: 1.5.h,
                                                  ),
                                                  const AutoSizeText(
                                                    "Payment \nLink",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 5,
                                                      color: black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                if (_userController.switchedAccountType == 2)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
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
                                              color: fagoSecondaryColor
                                                  .withOpacity(0.05),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (widget.userDetails
                                                          .kycVerified ==
                                                      0) {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        middleText: "",
                                                        titlePadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 8),
                                                        content:
                                                            unverifiedUserDialogue());
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 5,
                                                        color: black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (widget.userDetails
                                                          .kycVerified ==
                                                      0) {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        middleText: "",
                                                        titlePadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 8),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (widget.userDetails
                                                          .kycVerified ==
                                                      0) {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        middleText: "",
                                                        titlePadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 8),
                                                        content:
                                                            unverifiedUserDialogue());
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 10,
                                                        color: black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (widget.userDetails
                                                          .kycVerified ==
                                                      0) {
                                                    Get.defaultDialog(
                                                        title: "",
                                                        middleText: "",
                                                        titlePadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8,
                                                                vertical: 8),
                                                        content:
                                                            unverifiedUserDialogue());
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
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                    ],
                                  ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 2.h),
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/Ellipse 278.svg'),
                                      SvgPicture.asset(
                                          'assets/icons/Ellipse 279.svg'),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.h, vertical: 2.h),
                                        // height: 20.h,
                                        width: Get.width,
                                        color: fagoSecondaryColor
                                            .withOpacity(0.05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                Get.to(
                                                    () => const SelectType());
                                              },
                                              child: Container(
                                                //width: 21.h,
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.45,
                                                ),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    color: buttonColor),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 3.w,
                                                      vertical: .8.h),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/icons/fundAccount_icon.svg'),
                                                      const AutoSizeText(
                                                        "Create New Account",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Work Sans",
                                                          fontSize: 8,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => const ReferAndEarn());
                                    },
                                    child: Image.asset(
                                      'assets/images/refer-earn.png',
                                      fit: BoxFit.cover,
                                    ),
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
                            );
                      } else {
                        return Container();
                      }
                    }),
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

  Future<void> verifyEmailOrPassword({required String emailOrPhoneNumber}) async {
    progressIndicator(context);
    try {
      final body = jsonEncode({
        "identifier": emailOrPhoneNumber
      });
      final response = await NetworkProvider().call(path: "/v1/verify/email-phone-prompt", method: RequestMethod.post, body: body);
      if(response?.statusCode == 200 || response?.statusCode == 201){
        Get.back();
        showOtpDialog(emailOrPhone: emailOrPhoneNumber);
      }
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (error) {
      Get.back();
      Get.snackbar('Error', error.toString());
      throw error.toString();
    }
  }

  Future<void> verifyOtp({required String phoneNumberOrPassword, required String otp}) async {
    progressIndicator(context);
    try {
      final body = jsonEncode({
        "identifier": phoneNumberOrPassword,
        "otp": otp,
      });
      final response = await NetworkProvider().call(path: "/v1/verify/validate-email-phone-otp", method: RequestMethod.post, body: body);
      if(response?.statusCode == 200 || response?.statusCode == 201){
        Get.back();
        Get.snackbar("Success", response?.data["data"]["message"] ?? "Verification was successful");
      }
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (error) {
      Get.back();
      Get.snackbar('Error', error.toString());
      throw error.toString();
    }
  }

  Future<void> resendEmailPhoneNumberPromptOtp({required String phoneNumberOrPassword}) async {
    progressIndicator(context);
    try {
      final body = jsonEncode({
        "identifier": phoneNumberOrPassword
      });
      final response = await NetworkProvider().call(path: "/v1/verify/resend-email-phone-prompt", method: RequestMethod.post, body: body);
      if(response?.statusCode == 200 || response?.statusCode == 201){
        Get.back();
        Get.snackbar("Success", response?.data["data"]["message"] ?? "Verification was successful");
      }
    }on DioError catch (err) {
      Get.back();
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (error) {
      Get.back();
      Get.snackbar('Error', error.toString());
      throw error.toString();
    }
  }

  Future<void> getUserDetails() async {
    final response = await _loginController.getUserDetails();
   // print(' response is = ${response['data']['userdetail']['nextofkin']}');
    final userjsonBodyData = response?.data['data']['userdetail'];
    final userDetails = UserDetail.fromJson(userjsonBodyData);
    final userAccountjsonBodyData = response?.data['data']['userdetail']['accountdetail'];
    final userAccountDetails = AccountDetail.fromJson(userAccountjsonBodyData);
      _userController.setUserAccountDetails = userAccountDetails;
      _userController.setUser = userDetails;
    //print('User details are kyc number is ${userDetails.kycVerified}');
  }

  // Future<void> getCompany() async {
  //   final response = await _companyController.getCompany();
  //   final companyjsonBodyData = response['data']['company_detail'];
  //   final returnedCompanies = companyjsonBodyData
  //       .map<Company>((company) => Company.fromJson(company))
  //       .toList();
  //   final companyDetails = Company.fromJson(companyjsonBodyData[0]);
  //   setState(() {
  //     _companyController.companies = returnedCompanies;
  //     _companyController.setCompany = companyDetails;
  //   });
  // }

  Future<void> getIdentityDetails() async {
    final response = await _governmentIdentityController.getIdentityDetails();
    final identityjsonBodyData = response['data']['identity_detail'];
    print(identityjsonBodyData['id']);
    setState(() {
      _governmentIdentityController.governmentIdentityDetailId = identityjsonBodyData['id'];
    });
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
  //final _userUcontroller = Get.find<UserController>();
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
                            SvgPicture.asset('assets/icons/fundAccount_icon.svg'),
                            const Text(
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
