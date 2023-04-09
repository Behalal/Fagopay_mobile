import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/bill_controller.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import '../../../models/data_model.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'models/bill_post_model.dart';
import '../transactions/confirm_transaction.dart';
import '../widgets/head_style_extra_pages.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Internrt extends StatefulWidget {
  const Internrt({super.key});

  @override
  State<Internrt> createState() => _InternrtState();
}

class _InternrtState extends State<Internrt> {
  List<DataDetails>? allData = [];
  String variationCode = "";
  List<DropdownMenuItem<String>> dataDropdown = [];

  bool verifiedUser = false;
  bool isLoading = false;

  @override
  void dispose() {
    _billController.amountController.clear();
    _billController.meterNoController.clear();
    super.dispose();
  }

  @override
  void initState() {
    buyInternetFields.setAmount = "0";
    dataDropdown.add(
      const DropdownMenuItem(
          value: "", child: Text("Select a service Provider")),
    );
    super.initState();
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Service Provider")),
      DropdownMenuItem(value: "smile-direct", child: Text("Smile-Direct")),
      DropdownMenuItem(value: "spectranet", child: Text("Spectranet")),
    ];
    return menuItems;
  }

  final _billController = Get.find<BillController>();
  String verrifiedMeterUser = "";

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = dataDropdown;
    return menuItems;
  }

  String selectedValue = "";
  String priceSelected = "";

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProgressStyle(
                      stage: 50,
                      pageName: "Internet Subscription",
                      // backRoute: const DashboardHome(),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Select Service Provider",
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
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: fagoSecondaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          alignment: AlignmentDirectional.centerStart,
                          value: selectedValue,
                          items: dropdownItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              isLoading = true;
                              _billController.amountController.text = "0";
                              selectedValue = newValue!;
                              buyInternetFields.setServiceid = selectedValue;
                              if (selectedValue.isNotEmpty) {
                                fetchDataByServiceId(selectedValue);
                              }
                            });
                          },
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Work Sans",
                              color: signInPlaceholder),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const AutoSizeText(
                      "Select Data Bundle",
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
                    Container(
                      width: 90.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: fagoSecondaryColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: DropdownButton(
                          underline: const SizedBox(),
                          isExpanded: true,
                          alignment: AlignmentDirectional.centerStart,
                          value: priceSelected,
                          items: dropdownItems2,
                          onChanged: (String? newValue) {
                            setState(() {
                              priceSelected = newValue!;
                              if (priceSelected.isNotEmpty) {
                                _billController.amountController.text =
                                    allData![int.parse(priceSelected)]
                                        .variationAmount;
                                buyInternetFields.setAmount =
                                    _billController.amountController.text;
                                buyInternetFields.getVariationCode =
                                    allData![int.parse(priceSelected)]
                                        .variationCode;
                                buyInternetFields.setName =
                                    allData![int.parse(priceSelected)].name;
                              }
                            });
                          },
                          style: const TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Work Sans",
                              color: signInPlaceholder),
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
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Price",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: welcomeText,
                              ),
                            ),
                            AutoSizeText(
                              "$currencySymbol ${buyInternetFields.amount}",
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: TextFormField(
                            controller: _billController.meterNoController,
                            // maxLength: 14,
                            onChanged: (value) {
                              buyInternetFields.setBillersCode = value;
                              buyInternetFields.setPhone = value;
                              if (value.length >= 11) {
                                verifyRouter(context, value);
                              }
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                      color: textBoxBorderColor,
                                      width: 1.0,
                                      style: BorderStyle.solid)),
                              hintText: "Enter Router Number",
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
                      height: 12.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: GestureDetector(
                        onTap: (() {
                          if (verifiedUser &&
                              buyInternetFields.serviceid.isNotEmpty &&
                              buyInternetFields.variationCode.isNotEmpty &&
                              _billController
                                  .amountController.text.isNotEmpty &&
                              buyInternetFields.billersCode.isNotEmpty) {
                            buyInternetFields.setAmount =
                                _billController.amountController.text;
                            goToPage(
                                context,
                                ConfirmTransactions(
                                  backRoute: const Internrt(),
                                  action: 'buy_internet',
                                ));
                          }
                        }),
                        child: AuthButtons(
                            form: true,
                            color: (verifiedUser) ? null : inactiveTab,
                            text: "Continue",
                            route: ConfirmTransactions(
                              backRoute: const Internrt(),
                              action: 'buy_internet',
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> fetchDataByServiceId(String serviceId) async {
    final response = await _billController.getDatabyServiceId(serviceId);
    List<DataDetails> x = response['data']['variation']
        .map<DataDetails>((variation) => DataDetails.fromJson(variation))
        .toList();
    setState(() {
      allData = x;
      // log(allData![0].variationAmount);
      dataDropdown = getDataList(allData!);
      isLoading = false;
    });
  }

  void verifyRouter(BuildContext context, String routerNo) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response = await _billController.verifyRouter(routerNo);

    final jsonBodyData = jsonDecode(response.body);
    final customerDetail = jsonBodyData['data']['customer_detail'];
    if (response.statusCode != 200) {
      progress.dismiss();
      setState(() {
        verrifiedMeterUser = "";
        verifiedUser = false;
      });
    } else {
      progress.dismiss();
      setState(() {
        verrifiedMeterUser = customerDetail['Customer_Name'];
        verifiedUser = true;
      });
    }
  }

  List<DropdownMenuItem<String>> getDataList(List<DataDetails> data) {
    List<DropdownMenuItem<String>> dataItems = [];
    dataItems.add(
      const DropdownMenuItem(value: "", child: Text("Select Desired Data")),
    );

    for (var i = 0; i < data.length; i++) {
      dataItems.add(
        DropdownMenuItem(value: i.toString(), child: Text(data[i].name)),
      );
    }

    return dataItems;
  }
}
