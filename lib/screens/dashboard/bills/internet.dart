import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/models/data_model.dart';
import 'package:fagopay/repository/controllers/bill_controller.dart';
import 'package:fagopay/screens/authentication/widgets/auth_buttons.dart';
import 'package:fagopay/screens/constants/colors.dart';
import 'package:fagopay/screens/constants/currency.dart';
import 'package:fagopay/screens/dashboard/bills/models/bill_post_model.dart';
import 'package:fagopay/screens/dashboard/transactions/confirm_transaction.dart';
import 'package:fagopay/screens/dashboard/widgets/head_style_extra_pages.dart';
import 'package:fagopay/screens/functions.dart';
import 'package:fagopay/screens/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class Internrt extends ConsumerStatefulWidget {
  const Internrt({super.key});

  @override
  ConsumerState<Internrt> createState() => _InternrtState();
}

class _InternrtState extends ConsumerState<Internrt> {
  late List<DataDetails>? allData;
  late String variationCode;
  late List<DropdownMenuItem<String>> dataDropdown;

  late bool verifiedUser;
  late bool isLoading;

  @override
  void initState() {
    isLoading = false;
    verifiedUser = false;
    variationCode = "";
    allData = [];
    buyInternetFields.setAmount = "0";
    dataDropdown = [];
    dataDropdown.add(
      const DropdownMenuItem(
          value: "", child: Text("Select a service Provider")),
    );
    super.initState();
  }

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "", child: Text("Select Service Provider")),
      DropdownMenuItem(value: "smile-direct", child: Text("Smile-Direct")),
      DropdownMenuItem(value: "spectranet", child: Text("Spectranet")),
    ];

    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems = dataDropdown;
    return menuItems;
  }

  String selectedValue = "";
  String priceSelected = "";

  @override
  Widget build(BuildContext context) {
    // buyInternetFields.setServiceid = "";
    // buyInternetFields.getVariationCode = "";
    // // buyInternetFields.setAmount = "";
    // buyInternetFields.setBillersCode = "";
    // buyInternetFields.setPhone = "";
    return Scaffold(
        body: (isLoading)
            ? const Loading()
            : SingleChildScrollView(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProgressStyle(
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
                            height: 2.h,
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
                                    amountController.text = "0";
                                    selectedValue = newValue!;
                                    buyInternetFields.setServiceid =
                                        selectedValue;
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
                            height: 2.h,
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
                                      amountController.text =
                                          allData![int.parse(priceSelected)]
                                              .variationAmount;
                                      buyInternetFields.setAmount =
                                          amountController.text;
                                      buyInternetFields.getVariationCode =
                                          allData![int.parse(priceSelected)]
                                              .variationCode;
                                      buyInternetFields.setName =
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          SizedBox(
                            width: 90.w,
                            child: TextFormField(
                              controller: phoneController,
                              maxLength: 14,
                              onChanged: (value) {
                                buyInternetFields.setBillersCode = value;
                                buyInternetFields.setPhone = value;
                                if (value.length >= 11) {
                                  verifyRouter(value);
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
                                    buyInternetFields
                                        .variationCode.isNotEmpty &&
                                    amountController.text.isNotEmpty &&
                                    buyInternetFields.billersCode.isNotEmpty) {
                                  buyInternetFields.setAmount =
                                      amountController.text;
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
                        ]))));
  }

  void fetchDataByServiceId(String serviceId) {
    ref
        .read(billControllerProvider.notifier)
        .getDatabyServiceId(serviceId)
        .then((value) {
      if (value.code != 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.message!),
          ),
        );
      } else {
        setState(() {
          allData = value.dataValues!;
          log(allData![0].variationAmount);
          dataDropdown = getDataList(allData!);
          isLoading = false;
        });
      }
    });
  }

  void verifyRouter(String routerNo) {
    setState(() {
      isLoading = true;
    });
    ref
        .read(billControllerProvider.notifier)
        .verifyInternetNo(routerNo)
        .then((value) {
      if (value.code != 200) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value.message!),
          ),
        );
      } else {
        setState(() {
          isLoading = false;
          verifiedUser = true;
        });
      }
    });
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
