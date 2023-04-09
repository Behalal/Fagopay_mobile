import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import '../../../controllers/bill_controller.dart';
import '../../../models/data_model.dart';
import '../../functions.dart';
import 'models/bill_post_model.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import '../../authentication/widgets/auth_buttons.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import 'widgets/tv_sub_dropdown.dart';
import '../transactions/confirm_transaction.dart';
import '../widgets/head_style_extra_pages.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TVSubscription extends StatefulWidget {
  const TVSubscription({super.key});

  @override
  State<TVSubscription> createState() => _TVSubscriptionState();
}

class _TVSubscriptionState extends State<TVSubscription> {
  final _billcontroller = Get.find<BillController>();
  String priceSelected = "";
  List<DataDetails>? allData = [];
  List<DropdownMenuItem<String>> dataDropdown = [
    const DropdownMenuItem(value: "", child: Text("Select Package")),
  ];
  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = dataDropdown;
    return menuItems;
  }

  String verifiedCableUser = "";
  bool verifiedUser = false;
  final bool _isLoading = false;

  @override
  void dispose() {
    _billcontroller.meterNoController.clear();
    _billcontroller.amountController.clear();
    _billcontroller.phoneController.clear();
    super.dispose();
  }

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
                        pageName: "Cable Subscription",
                        // backRoute: const DashboardHome(),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TVProviders(
                        onChanged: (String? newValue) async {
                          setState(() {
                            buyTvCableFields.setServiceid = newValue!;
                          });
                          await fetchDataByServiceId(newValue!);
                        },
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AutoSizeText(
                            "Select Package",
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
                                      _billcontroller.amountController.text =
                                          allData![int.parse(priceSelected)]
                                              .variationAmount;
                                      buyTvCableFields.setAmount =
                                          _billcontroller.amountController.text;
                                      buyTvCableFields.getVariationCode =
                                          allData![int.parse(priceSelected)]
                                              .variationCode;
                                      buyTvCableFields.setName =
                                          allData![int.parse(priceSelected)]
                                              .name;
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
                        ],
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
                                "$currencySymbol${buyTvCableFields.amount != '' ? buyTvCableFields.amount : 0}",
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
                      SizedBox(
                        width: 90.w,
                        child: TextFormField(
                          onChanged: (value) async {
                            if (value.length >= 10 &&
                                buyTvCableFields.serviceid.isNotEmpty) {
                              buyTvCableFields.setBillersCode = value;
                              await verifySmartCardNumber(
                                  context, value, buyTvCableFields.serviceid);
                            }
                          },
                          controller: _billcontroller.meterNoController,
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
                            hintText: "Enter Card Number",
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
                                verifiedCableUser,
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
                          controller: _billcontroller.phoneController,
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
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: GestureDetector(
                          onTap: (() {
                            if (_billcontroller.meterNoController.text.length >=
                                    10 &&
                                buyTvCableFields.serviceid.isNotEmpty &&
                                buyTvCableFields.variationCode.isNotEmpty &&
                                _billcontroller
                                    .amountController.text.isNotEmpty) {
                              buyTvCableFields.setAmount =
                                  _billcontroller.amountController.text;
                              buyTvCableFields.setBillersCode =
                                  _billcontroller.meterNoController.text;
                              buyTvCableFields.setPhone =
                                  _billcontroller.phoneController.text;
                              goToPage(
                                  context,
                                  ConfirmTransactions(
                                    backRoute: const TVSubscription(),
                                    action: 'tv',
                                  ));
                            }
                          }),
                          child: AuthButtons(
                            form: true,
                            text: "Continue",
                            route: ConfirmTransactions(
                              backRoute: const TVSubscription(),
                              action: 'tv',
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifySmartCardNumber(
      BuildContext context, String cardNo, String serviceID) async {
    final progress = ProgressHUD.of(context);
    progress!.show();
    final response =
        await _billcontroller.verifySmartCardNumber(cardNo, serviceID);
    final jsonBodyData = jsonDecode(response.body);
    final customerDetail = jsonBodyData['data']['customer_detail'];
    if (response.statusCode != 200) {
      progress.dismiss();
      setState(() {
        verifiedCableUser = "";
        verifiedUser = false;
      });
    } else {
      progress.dismiss();
      setState(() {
        verifiedCableUser = customerDetail['Customer_Name'];
        verifiedUser = true;
      });
    }
  }

  Future<void> fetchDataByServiceId(String serviceId) async {
    final response = await _billcontroller.getDatabyServiceId(serviceId);
    List<DataDetails> x = response['data']['variation']
        .map<DataDetails>((variation) => DataDetails.fromJson(variation))
        .toList();
    setState(() {
      allData = x;
      dataDropdown = getDataList(allData!);
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
