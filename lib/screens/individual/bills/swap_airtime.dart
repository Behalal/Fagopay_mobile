import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/bill_controller.dart';
import 'package:fagopay/controllers/user_controller.dart';
import 'package:fagopay/screens/individual/bills/how_it_works.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/swap_airtime_model.dart/initiateSwap.dart';
import '../../authentication/recover_password_otp_screen.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';

class SwapAirtime extends StatefulWidget {
  const SwapAirtime({super.key});

  @override
  State<SwapAirtime> createState() => _SwapAirtimeState();
}

class _SwapAirtimeState extends State<SwapAirtime> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FlutterContactPicker _contactPicker = FlutterContactPicker();
  final Contact _contact = Contact(
    fullName: "",
  );
  final _userUcontroller = Get.find<UserController>();
  final _billsController = Get.find<BillController>();

  Debouncer? _debouncer;

  late bool mtnActive;
  late bool airtelActive;
  late bool gloActive;
  late bool etisatActive;
  @override
  void initState() {
    mtnActive = true;
    airtelActive = false;
    gloActive = false;
    etisatActive = false;
    super.initState();
  }

  @override
  void dispose() {
    _billsController.phoneController.clear();
    _billsController.amountController.clear();
    _billsController.confirmPhoneController.clear();
    // TODO: implement dispose
    super.dispose();
  }

  Timer? searchOnStoppedTyping;

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = Timer(duration, () {
          _billsController.swapCharge(
              amount: _billsController.amountController.text.toString(),
              network: (mtnActive) == true
                  ? 'mtn'
                  : (gloActive) == true
                      ? 'glo'
                      : (airtelActive) == true
                          ? 'airtel'
                          : (etisatActive) == true
                              ? 'etisalat'
                              : 'glo'
              // network: if(mtnActive == true){
              //   mtnActive == 'mtn'
              // }else if(gloActive == true){
              //   gloActive == 'glo'
              // }else if(airtelActive == true){
              //   airtelActive == 'airtel'
              // }lse if(etisatActive == true){
              //   etisatActive == 'etisalat'
              // }
              // ,
              );
          search(value);
          print('okay aske here');
        }));
  }

  search(value) {
    print('hello world from search . the value is $value');
  }

  @override
  Widget build(BuildContext context) {
    // _billsController.swapCharge(
    //   amount: '10000',
    //   network: 'mtn',
    // );
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Form(
            key: formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressStyle(
                    stage: 50,
                    pageName: "Swap Airtime",
                    // backRoute: const DashboardHome(),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  const AutoSizeText(
                    "Select Network Provider",
                    style: TextStyle(
                        color: welcomeText,
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            mtnActive = true;
                            airtelActive = false;
                            gloActive = false;
                            etisatActive = false;
                          });
                        }),
                        child: Container(
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: (mtnActive)
                                  ? Border.all(color: fagoBlue, width: 2.0)
                                  : null,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage("assets/images/mtn.png")),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            mtnActive = false;
                            airtelActive = true;
                            gloActive = false;
                            etisatActive = false;
                          });
                        }),
                        child: Container(
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: (airtelActive)
                                  ? Border.all(color: fagoBlue, width: 2.0)
                                  : null,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage("assets/images/airtel.png")),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            mtnActive = false;
                            airtelActive = false;
                            gloActive = true;
                            etisatActive = false;
                          });
                        }),
                        child: Container(
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: (gloActive)
                                  ? Border.all(color: fagoBlue, width: 2.0)
                                  : null,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image: AssetImage("assets/images/glo.png")),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() {
                          setState(() {
                            mtnActive = false;
                            airtelActive = false;
                            gloActive = false;
                            etisatActive = true;
                          });
                        }),
                        child: Container(
                          width: 20.w,
                          decoration: BoxDecoration(
                              border: (etisatActive)
                                  ? Border.all(color: fagoBlue, width: 2.0)
                                  : null,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Image(
                                image:
                                    AssetImage("assets/images/etisalat.png")),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  const AutoSizeText(
                    "Enter Phone Number",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: welcomeText,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      controller: _billsController.phoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        } else if (value.length < 11) {
                          return 'Phone Number is not correct';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter Phone Number",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  // Container(
                  //   width: 90.w,
                  //   decoration: const BoxDecoration(
                  //       color: fagoSecondaryColorWithOpacity10,
                  //       borderRadius: BorderRadius.all(Radius.circular(5))),
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 4.w, vertical: 1.h),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Image(
                  //             image:
                  //                 AssetImage("assets/images/account.png")),
                  //         SizedBox(
                  //           width: 2.w,
                  //         ),
                  //         AutoSizeText(
                  //           _contact.fullName!,
                  //           style: const TextStyle(
                  //             fontFamily: "Work Sans",
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500,
                  //             color: welcomeText,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 15.w,
                  //         ),
                  //         GestureDetector(
                  //           onTap: (() async {
                  //             Contact? contact =
                  //                 await _contactPicker.selectContact();
                  //             setState(() {
                  //               _contact = contact!;
                  //               _billsController.phoneController.text =
                  //                   _contact.phoneNumbers![0];
                  //             });
                  //           }),
                  //           child: const AutoSizeText(
                  //             "Select from Contacts",
                  //             style: TextStyle(
                  //               decoration: TextDecoration.underline,
                  //               fontFamily: "Work Sans",
                  //               fontSize: 10,
                  //               fontWeight: FontWeight.w500,
                  //               color: fagoBlue,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "Confirm Phone Number",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: welcomeText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      controller: _billsController.confirmPhoneController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'confirm Phone must not be empty';
                        } else if (_billsController.phoneController.text
                                .trim() !=
                            _billsController.confirmPhoneController.text
                                .trim()) {
                          return 'Phone Number does not match';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Confirm Phone Number",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  const AutoSizeText(
                    "How much Airtime to Swap",
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: welcomeText,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: TextFormField(
                      onChanged: _onChangeHandler,
                      controller: _billsController.amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                          ),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(
                                color: textBoxBorderColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        hintText: "Enter Amount",
                        hintStyle: const TextStyle(
                          fontFamily: "Work Sans",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: signInPlaceholder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: fagoSecondaryColorWithOpacity10,
                    ),
                    child: Obx(() {
                      return Padding(
                        padding: EdgeInsets.all(2.5.w),
                        child: SizedBox(
                          width: 42.w,
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: AutoSizeText(
                                    "Transaction Information",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: stepsColor,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Amount:",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    _billsController.swapChargesStatus ==
                                            SwapChargesEnum.loading
                                        ? const LoadingWidget(
                                            color: welcomeText,
                                            size: 12,
                                          )
                                        : _billsController.chargesAmount.value
                                                    ?.swappingAmount !=
                                                null
                                            ? AutoSizeText(
                                                "$currencySymbol ${_billsController.userchargesAmount!.swappingAmount}",
                                                style: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: verificationCodeText,
                                                ),
                                              )
                                            : const AutoSizeText(
                                                "0",
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Network",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    _billsController.swapChargesStatus ==
                                            SwapChargesEnum.loading
                                        ? const LoadingWidget(
                                            color: welcomeText,
                                            size: 12,
                                          )
                                        : _billsController.chargesAmount.value
                                                    ?.network !=
                                                null
                                            ? AutoSizeText(
                                                _billsController
                                                    .userchargesAmount!.network!
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: verificationCodeText,
                                                ),
                                              )
                                            : const AutoSizeText(
                                                "Network",
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const AutoSizeText(
                                      "Transaction Fee",
                                      style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: stepsColor,
                                      ),
                                    ),
                                    _billsController.swapChargesStatus ==
                                            SwapChargesEnum.loading
                                        ? const LoadingWidget(
                                            color: welcomeText,
                                            size: 12,
                                          )
                                        : _billsController.chargesAmount.value
                                                    ?.swappingAmount !=
                                                null
                                            ? AutoSizeText(
                                                "$currencySymbol ${_billsController.userchargesAmount!.fee}",
                                                style: const TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: verificationCodeText,
                                                ),
                                              )
                                            : const AutoSizeText(
                                                "0",
                                                style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: stepsColor,
                                                ),
                                              ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(
                    height: 4.h,
                  ),
                  Obx(() {
                    return InkWell(
                      onTap: () {
                        SwappingDetailModel swapDetails = SwappingDetailModel(
                            userId: _userUcontroller.user!.id,
                            phoneNumber:
                                _billsController.phoneController.text.trim(),
                            confirm_phone_number: _billsController
                                .confirmPhoneController.text
                                .trim(),
                            network:
                                _billsController.userchargesAmount!.network!,
                            amount:
                                _billsController.amountController.text.trim(),
                            airtimeValue: _billsController
                                .userchargesAmount!.swappingAmount,
                            fee: _billsController.userchargesAmount!.fee
                                .toString());

                        if (kDebugMode) {
                          print('Next of kin: ${swapDetails.toJson()}');
                        }
                        print('here i am');
                        if (_billsController.initiateSwapStatus !=
                                InitiateSwapEnum.loading &&
                            formKey.currentState!.validate()) {
                          print('here i am 3');
                          _billsController.initiateSwap(swapDetails);
                        }
                        Get.to(() => SwapAirtimeDescPage(
                              network:
                                  _billsController.userchargesAmount!.network!,
                              amount: _billsController.amountController.text,
                              number: _billsController.phoneController.text,
                            ));
                        print('here i am 2');
                      },
                      child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              color: fagoSecondaryColor),
                          child: (_billsController.initiateSwapStatus ==
                                  InitiateSwapEnum.loading)
                              ? const LoadingWidget()
                              : const Center(
                                  child: AutoSizeText(
                                    'Swap Now',
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                    ),
                                  ),
                                )),
                    );
                  }),
                  SizedBox(
                    height: 2.h,
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //   child: InkWell(
                  //     onTap: () {
                  //       print(
                  //           'Network ${_billsController.userchargesAmount!.network!}');
                  //       Get.to(() => SwapAirtimeDescPage(
                  //             network:
                  //                 _billsController.userchargesAmount!.network!,
                  //             amount: _billsController.amountController.text,
                  //             number: _billsController.phoneController.text,
                  //           ));
                  //     },
                  //     child: const AutoSizeText(
                  //       'Test',
                  //       style: TextStyle(
                  //         fontFamily: "Work Sans",
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w400,
                  //         color: fagoBlackColor,
                  //       ),
                  //     ),
                  //   ),
                  // )
                ]),
          ),
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;

  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}


