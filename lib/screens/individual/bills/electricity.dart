import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/bill_controller.dart';
import 'package:get/get.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'models/bill_post_model.dart';
import 'widgets/electricity_provider.dart';
import 'widgets/meter_type.dart';
import '../transactions/confirm_transaction.dart';
import '../widgets/head_style_extra_pages.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  bool _verifiedMeter = false;
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressStyle(
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
                SizedBox(
                  height: 2.h,
                ),
                const MeterType(),
                SizedBox(
                  height: 2.h,
                ),
                const AutoSizeText(
                  "Enter Router Number",
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
                    controller: _billController.meterNoController,
                    onChanged: (value) {
                      if (value.length >= 11 &&
                          buyElectricityFields.serviceid.isNotEmpty &&
                          buyElectricityFields.variationCode.isNotEmpty) {
                        verifyMeterNo(buyElectricityFields.serviceid, value,
                            buyElectricityFields.variationCode);
                      }
                    },
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: signInPlaceholder),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                  height: 2.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    controller: _billController.phoneController,
                    enabled: _verifiedMeter,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: stepsColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                      hintText: "Amount to send",
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
                  height: 2.h,
                ),
                SizedBox(
                  width: 90.w,
                  child: TextFormField(
                    controller: _billController.amountController,
                    enabled: _verifiedMeter,
                    style: const TextStyle(
                        fontFamily: "Work Sans",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: stepsColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
                      hintText: "Amount to send",
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
                      if (_billController.meterNoController.text.length >= 10 &&
                          _verifiedMeter &&
                          buyElectricityFields.serviceid.isNotEmpty &&
                          buyElectricityFields.variationCode.isNotEmpty &&
                          _billController.amountController.text.isNotEmpty) {
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
                        color: (_verifiedMeter) ? null : inactiveTab,
                        text: "Continue",
                        route: ConfirmTransactions(
                          backRoute: const Electricity(),
                          action: 'buy_light',
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyMeterNo(String serviceID, String billerCode, String type) async {
    final response =
        await _billController.verifyMeterNo(serviceID, billerCode, type);
    if (response.statusCode != 200) {
      setState(() {
        _verifiedMeter = false;
      });
    } else {
      setState(() {
        _verifiedMeter = true;
      });
    }
  }
}
