import 'package:auto_size_text/auto_size_text.dart';
import 'new_transaction.dart';
import '../widgets/load_more.dart';
import '../../constants/colors.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../controllers/user_controller.dart';
import '../../individual/widgets/head_style_extra_pages.dart';
import '../home/home.dart';

class AllTransaction extends StatefulWidget {
  const AllTransaction({super.key});

  @override
  State<AllTransaction> createState() => _AllTransactionState();
}

class _AllTransactionState extends State<AllTransaction> {
  final _userController = Get.find<UserController>();
  List accountType = [
    {'type': 'All account', 'value': ""},
    {'type': 'Marketing Account', 'value': '1'},
    {'type': 'Challenge Account', 'value': '14'},
    {'type': 'Sales Account', 'value': '60'},
  ];

  List filter = [
    {'type': 'Filter By', 'value': ""},
    {'type': '7 days', 'value': '7'},
    {'type': '30 days', 'value': '30'},
  ];

  String? selectedAccount = "";
  String? selectedFilter = "";
  bool inflowTab = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProgressStyle(
                stage: 0,
                pageName: "Transactions",
                // backRoute: BusinessHome(
                //   userDetails: _userController.user!,
                //   accountDetails: _userController.userAccountDetails!,
                // ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => goToPage(context, const NewTransaction()),
                    child: SizedBox(
                      width: 45.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.2.h,
                        ),
                        decoration: const BoxDecoration(
                          color: fagoSecondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/fluent_receipt-20-filled.png",
                              color: white,
                            ),
                            const AutoSizeText(
                              "New Transaction",
                              style: TextStyle(
                                fontFamily: "Work Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 5.h,
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                            color: fagoBlackColorWithOpacity15,
                            width: 0.3,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: black,
                              ),
                              isDense: true,
                              value: selectedAccount,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    selectedAccount = value;
                                  } else {
                                    selectedAccount = null;
                                  }
                                });
                              },
                              items: accountType.map((account) {
                                return DropdownMenuItem<String>(
                                  value: account['value'],
                                  child: Text(account['type']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    },
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Inflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        if (inflowTab) {
                          inflowTab = !inflowTab;
                        }
                      });
                    }),
                    child: Container(
                      width: 40.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (!inflowTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: const AutoSizeText(
                          "Outflow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AutoSizeText(
                    "Today",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Work Sans",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: inactiveTab,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 5.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: white,
                          border: Border.all(
                            color: fagoBlackColorWithOpacity15,
                            width: 0.3,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              style: const TextStyle(
                                fontFamily: "Work Sans",
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                                color: black,
                              ),
                              isDense: false,
                              value: selectedFilter,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    selectedFilter = value;
                                  } else {
                                    selectedFilter = null;
                                  }
                                });
                              },
                              items: filter.map((eachFilter) {
                                return DropdownMenuItem<String>(
                                  value: eachFilter['value'],
                                  child: Text(eachFilter['type']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 35.h,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration:
                    const BoxDecoration(color: fagoSecondaryColorWithOpacity10),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (inflowTab) ...[
                      for (var i = 0; i < 7; i++) ...[
                        SizedBox(
                          height: 1.5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 8,
                                          color: fagoGreenColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 6) ...[
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ],
                    ],
                    if (!inflowTab) ...[
                      for (var i = 0; i < 7; i++) ...[
                        SizedBox(
                          height: 1.5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 8,
                                          color: fagoGreenColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 6) ...[
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ],
                    ],
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const AutoSizeText(
                "Last 7 days",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: inactiveTab,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                height: 15.h,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration:
                    const BoxDecoration(color: fagoSecondaryColorWithOpacity10),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    if (inflowTab) ...[
                      for (var i = 0; i < 7; i++) ...[
                        SizedBox(
                          height: 1.5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 8,
                                          color: fagoGreenColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 6) ...[
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ],
                    ],
                    if (!inflowTab) ...[
                      for (var i = 0; i < 7; i++) ...[
                        SizedBox(
                          height: 1.5.h,
                        ),
                        SizedBox(
                          width: 90.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 45.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/Group 88.png',
                                      // width: 8.w,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AutoSizeText(
                                          "Website Development",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 14,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        const AutoSizeText(
                                          "24 Mar 2023",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: inactiveTab,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AutoSizeText(
                                    "NGN 500",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontFamily: "Work Sans",
                                        fontSize: 10,
                                        color: fagoSecondaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.h),
                                    decoration: const BoxDecoration(
                                        color: fagoGreenColorWithOpacity10,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const AutoSizeText(
                                      "Fully Paid",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 8,
                                          color: fagoGreenColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (i != 6) ...[
                          SizedBox(
                            height: 1.5.h,
                          ),
                        ],
                      ],
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LoadMore(),
    );
  }
}
