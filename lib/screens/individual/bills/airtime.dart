import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/controllers/bill_controller.dart';
import 'package:get/get.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import 'data.dart';
import 'models/bill_post_model.dart';
import '../transactions/confirm_transaction.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuyAirtime extends StatefulWidget {
  const BuyAirtime({super.key});

  @override
  State<BuyAirtime> createState() => _BuyAirtimeState();
}

class _BuyAirtimeState extends State<BuyAirtime> {
  bool mtnActive = false;
  bool airtelActive = false;
  bool gloActive = false;
  bool etisatActive = false;

  String serviceProviderValue = "";
  final _billsController = Get.find<BillController>();

  @override
  void dispose() {
    _billsController.phoneController.clear();
    _billsController.amountController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          serviceProviderValue = "mtn";
                          buyAirtimeFields.setServiceid = serviceProviderValue;
                        });
                      }),
                      child: Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                            border: (mtnActive)
                                ? Border.all(
                                    color: fagoSecondaryColor, width: 2.0)
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child:
                              Image(image: AssetImage("assets/images/mtn.png")),
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
                          serviceProviderValue = "airtel";
                          buyAirtimeFields.setServiceid = serviceProviderValue;
                        });
                      }),
                      child: Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                            border: (airtelActive)
                                ? Border.all(
                                    color: fagoSecondaryColor, width: 2.0)
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
                          serviceProviderValue = "glo";
                          buyAirtimeFields.setServiceid = serviceProviderValue;
                        });
                      }),
                      child: Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                            border: (gloActive)
                                ? Border.all(
                                    color: fagoSecondaryColor, width: 2.0)
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child:
                              Image(image: AssetImage("assets/images/glo.png")),
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
                          serviceProviderValue = "9mobile";
                          buyAirtimeFields.setServiceid = serviceProviderValue;
                        });
                      }),
                      child: Container(
                        width: 20.w,
                        decoration: BoxDecoration(
                            border: (etisatActive)
                                ? Border.all(
                                    color: fagoSecondaryColor, width: 2.0)
                                : null,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image(
                              image: AssetImage("assets/images/etisalat.png")),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4.h),
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
                    maxLength: 14,
                    controller: _billsController.phoneController,
                    keyboardType: TextInputType.number,
                    onChanged: ((value) {
                      setState(() {
                        buyAirtimeFields.setPhone =
                            _billsController.phoneController.text;
                      });
                    }),
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
                            style: BorderStyle.solid),
                      ),
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
                // SizedBox(
                //   height: 0.5.h,
                // ),
                // Container(
                //   width: 90.w,
                //   decoration: const BoxDecoration(
                //       color: Fago_secondary_color_with_opacity_10,
                //       borderRadius: BorderRadius.all(Radius.circular(5))),
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         const Image(image: AssetImage("assets/images/account.png")),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         const AutoSizeText(
                //           "Ibrahim Lukman",
                //           style: TextStyle(
                //             fontFamily: "Work Sans",
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
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
                  "Amount",
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
                    controller: _billsController.amountController,
                    keyboardType: TextInputType.number,
                    onChanged: ((value) {
                      setState(() {
                        buyAirtimeFields.setAmount =
                            _billsController.amountController.text;
                      });
                    }),
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
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        borderSide: BorderSide(
                            color: textBoxBorderColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
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
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: GestureDetector(
                    onTap: () {
                      if (mtnActive == false &&
                          airtelActive == false &&
                          gloActive == false &&
                          etisatActive == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Select a Network Provider'),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ConfirmTransactions(
                            action: 'buy_airtime',
                            backRoute: const BuyAirtime(),
                          ),
                        ),
                      );
                    },
                    child: AuthButtons(
                      form: true,
                      text: "Continue",
                      route: const BuyData(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
