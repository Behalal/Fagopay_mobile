import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/screens/authentication/recover_password_otp_screen.dart';
import 'package:fagopay/screens/widgets/progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/bill_controller.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../functions.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../transactions/confirm_transaction.dart';
import 'models/bill_post_model.dart';
import 'widgets/electricity_provider.dart';
import 'widgets/meter_type.dart';

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  bool _verifiedMeter = false;
  String verrifiedMeterUser = "";
  final _billController = Get.find<BillController>();

  @override
  void dispose() {
    _billController.meterNoController.clear();
    _billController.phoneController.clear();
    _billController.amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BillController>(
      init: BillController(),
        builder: (controller){
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ProgressStyle(
                  stage: 50,
                  pageName: "Electricity Purchase",
                  // backRoute: const DashboardHome(),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ElectricityProvider(),
                SizedBox(height: 2.h,),
                const MeterType(),
                SizedBox(
                  height: 2.h,
                ),
                const AutoSizeText(
                  "Enter Meter Number",
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: FocusScope(
                        onFocusChange: (value) {
                          if (!value) {
                            verifyMeterNo(
                                context,
                                buyElectricityFields.serviceid,
                                _billController.meterNoController.text,
                                buyElectricityFields.variationCode);
                          }
                        },
                        child: TextFormField(
                          controller: _billController.meterNoController,
                          onFieldSubmitted: (value) {
                            if (buyElectricityFields.serviceid.isNotEmpty && buyElectricityFields.variationCode.isNotEmpty) {
                              verifyMeterNo(
                                  context,
                                  buyElectricityFields.serviceid,
                                  value,
                                  buyElectricityFields.variationCode);
                            }
                          },
                          style: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder),
                          decoration: InputDecoration(
                            suffixIcon: isVerifyingNumber == true ? const CupertinoActivityIndicator(color: fagoSecondaryColor,) : const SizedBox(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                color: textBoxBorderColor, width: 1.0,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                    color: textBoxBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                            hintText: "Enter Meter Number",
                            hintStyle: const TextStyle(
                              fontFamily: "Work Sans",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: signInPlaceholder,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                      width: 90.w,
                      decoration: const BoxDecoration(
                          color: fagoSecondaryColorWithOpacity10,
                          borderRadius:
                          BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Fullname",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: welcomeText,
                              ),
                            ),
                            AutoSizeText(
                              verrifiedMeterUser,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: welcomeText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 0.5.h,
                // ),
                // Container(
                //   width: 90.w,
                //   decoration: const BoxDecoration(
                //       color: Fago_secondary_color_with_opacity_10,
                //       borderRadius: BorderRadius.all(Radius.circular(5))),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(
                //         horizontal: 4.w, vertical: 1.h),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: const [
                //         AutoSizeText(
                //           "Fullname",
                //           style: TextStyle(
                //             fontFamily: "Work Sans",
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400,
                //             color: welcome_text,
                //           ),
                //         ),
                //         AutoSizeText(
                //           "Obasa Yusuf",
                //           style: TextStyle(
                //             decoration: TextDecoration.underline,
                //             fontFamily: "Work Sans",
                //             fontSize: 14,
                //             fontWeight: FontWeight.w700,
                //             color: welcome_text,
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
                  "Phone Number",
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
                    controller: _billController.phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        color: stepsColor),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      hintText: "Enter phone number",
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
                  "Amount to Buy",
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
                    controller: _billController.amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 14,
                        color: stepsColor),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(
                              color: textBoxBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid)),
                      hintText: "Enter amount",
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
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GestureDetector(
                    onTap: (() {
                      if (_billController.meterNoController.text.length >=
                          10 &&
                          _verifiedMeter &&
                          buyElectricityFields.serviceid.isNotEmpty &&
                          buyElectricityFields.variationCode.isNotEmpty &&
                          _billController
                              .amountController.text.isNotEmpty) {
                        buyElectricityFields.setAmount =
                            _billController.amountController.text;
                        buyElectricityFields.setBillersCode =
                            _billController.meterNoController.text;
                        buyElectricityFields.setPhone =
                            _billController.phoneController.text;

                        goToPage(
                            context,
                            ConfirmTransactions(
                              backRoute: const Electricity(),
                              action: 'buy_light',
                            ));
                      }
                    }),
                    child: AuthButtons(
                      form: true,
                      text: "Continue",
                      route: ConfirmTransactions(
                        backRoute: const Electricity(),
                        action: 'buy_light',
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 10.w),
                //   child: GestureDetector(
                //     onTap: (() {
                //       if (_billController.meterNoController.text.length >=
                //           10 &&
                //           _verifiedMeter &&
                //           buyElectricityFields.serviceid.isNotEmpty &&
                //           buyElectricityFields.variationCode.isNotEmpty &&
                //           _billController
                //               .amountController.text.isNotEmpty) {
                //         buyElectricityFields.setAmount =
                //             _billController.amountController.text;
                //         buyElectricityFields.setBillersCode =
                //             _billController.meterNoController.text;
                //         buyElectricityFields.setPhone =
                //             _billController.phoneController.text;
                //
                //         goToPage(
                //             context,
                //             ConfirmTransactions(
                //               backRoute: const Electricity(),
                //               action: 'buy_light',
                //             ));
                //       }
                //     }),
                //     child: AuthButtons(
                //         form: true,
                //         color: _verifiedMeter
                //             ? fagoSecondaryColor
                //             : inactiveTab,
                //         text: "Continue",
                //         route: ConfirmTransactions(
                //           backRoute: const Electricity(),
                //           action: 'buy_light',
                //         )),
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
  bool? isVerifyingNumber;
  bool? isVerifyingNumberHasError;
  void verifyMeterNo(BuildContext context, String serviceID, String billerCode,
      String type) async {
    isVerifyingNumber = true;
    isVerifyingNumberHasError = false;
    setState(() {});
    final response =
        await _billController.verifyMeterNo(serviceID, billerCode, type);
    final jsonBodyData = jsonDecode(response.body);
    final customerDetail = jsonBodyData['data']['customer_detail'];
    if (response.statusCode == 200) {
      isVerifyingNumber = false;
      isVerifyingNumberHasError = false;
      setState(() {});
      setState(() {
        verrifiedMeterUser = customerDetail['Customer_Name'];
        _verifiedMeter = true;
      });
      return;
    }else{
      isVerifyingNumber = false;
      isVerifyingNumberHasError = true;
      setState(() {});
      // Get.back();
      setState(() {
        verrifiedMeterUser = "";
        _verifiedMeter = false;
      });
      Get.snackbar("Error","${jsonBodyData['data']['error']}", colorText: Colors.white, backgroundColor: fagoSecondaryColor);
    }
  }
}
