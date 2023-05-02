import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/screens/business/invoice/add_invoice.dart';
import 'package:fagopay/screens/business/invoice/all_invoice.dart';
import 'package:fagopay/screens/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../home/models/sales.model.dart';
import '../widgets/no_record.dart';
import 'add_sales_or_expense.dart';
import 'models/model.dart';

class BookKeeping extends StatefulWidget {
  const BookKeeping({super.key});

  @override
  State<BookKeeping> createState() => _BookKeepingState();
}

class _BookKeepingState extends State<BookKeeping> {
  bool inflowTab = true;
  bool recordFound = true;
  List salesFilter = [
    {'type': 'All', 'value': ""},
    {'type': 'Paid', 'value': '7'},
    {'type': 'Part Paid', 'value': '30'},
    {'type': 'Full Credit', 'value': '3'},
  ];

  List expensesFilter = [
    {'type': 'All', 'value': ""},
    {'type': 'Food and Drinks', 'value': '7'},
    {'type': 'Vacation', 'value': '30'},
    {'type': 'Bank charges', 'value': '3'},
  ];

  String? selectedFilter = '';
  int currentIndex = 0;
  late final PageController _controller = PageController(viewportFraction: 0.5);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                pageName: "Sales & Expenses",
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // goToPage(context, const AddSalesOrExpenses());
                      goToPage(context, const AllInvoice());
                    },
                    child: SizedBox(
                      width: 45.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
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
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 100.w,
                height: 11.h,
                child: PageView.builder(
                    controller: _controller,
                    padEnds: false,
                    itemCount: bookKeepingContent.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (context, i) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // goToPage(context, const AllSales());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              decoration: const BoxDecoration(
                                  color: white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: blackWithOpacity,
                                        offset: Offset.zero,
                                        spreadRadius: 2,
                                        blurRadius: 8),
                                  ]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(bookKeepingContent[i].imagePath),
                                  SizedBox(width: 2.w),
                                  Container(
                                    height: 53,
                                    decoration: DottedDecoration(
                                        color: blackWithOpacity5,
                                        // dash: const [1, 1, 1],
                                        linePosition: LinePosition.right),
                                  ),
                                  SizedBox(width: 2.w),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        bookKeepingContent[i].accountType,
                                        style: const TextStyle(
                                          fontFamily: "Work Sans",
                                          fontSize: 12,
                                          color: inactiveTab,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 1.h),
                                      AutoSizeText(
                                        "$currencySymbol${bookKeepingContent[i].balance}",
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 18,
                                            color: (i == 1 ||
                                                    i ==
                                                        (bookKeepingContent
                                                                .length -
                                                            1))
                                                ? fagoSecondaryColor
                                                : inactiveTab,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 1.h),
                                      AutoSizeText(
                                        bookKeepingContent[i].description,
                                        style: TextStyle(
                                            fontFamily: "Work Sans",
                                            fontSize: 10,
                                            color: (i == 2)
                                                ? fagoGreenColor
                                                : inactiveTabWithOpacity30,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 1.5.w,
                          )
                        ],
                      ); // ]
                    }),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              // Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  salesContent.length,
                  (index) => buildDot(index, context),
                ),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Container(
                height: 0.5,
                decoration: const BoxDecoration(
                  color: blackWithOpacity10,
                ),
              ),
              SizedBox(
                height: 2.h,
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
                        child: AutoSizeText(
                          "Sales History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                (inflowTab) ? fagoSecondaryColor : inactiveTab,
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
                        child: AutoSizeText(
                          "Expenses History",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                (!inflowTab) ? fagoSecondaryColor : inactiveTab,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "All Transactions",
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
                                items: (inflowTab)
                                    ? salesFilter.map((eachFilter) {
                                        return DropdownMenuItem<String>(
                                          value: eachFilter['value'],
                                          child: Text(eachFilter['type']),
                                        );
                                      }).toList()
                                    : expensesFilter.map((eachFilter) {
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
              ),
              SizedBox(
                height: 2.h,
              ),
              // Record Found
              if (recordFound)
                Container(
                  height: 35.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: const BoxDecoration(
                      color: fagoSecondaryColorWithOpacity10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/inflow.png',
                                          // width: 8.w,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const AutoSizeText(
                                              "Obasana Yussuf",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  color: inactiveTab,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                              child: const AutoSizeText(
                                                "customer bought a a pair of shoe",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    color: inactiveTab,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 60.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/outflow.png',
                                          // width: 8.w,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const AutoSizeText(
                                              "Tunde Akande",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Work Sans",
                                                  fontSize: 14,
                                                  color: inactiveTab,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            SizedBox(
                                              width: 50.w,
                                              child: const AutoSizeText(
                                                "Paid employee salary",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontFamily: "Work Sans",
                                                    fontSize: 12,
                                                    color: inactiveTab,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            color:
                                                fagoSecondaryColorWithOpacity10,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(25))),
                                        child: const AutoSizeText(
                                          "Fully Paid",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 8,
                                              color: fagoSecondaryColor,
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
                      ]),
                ),
              // No record Found
              if (!recordFound) const NoRecordFound(recordDescription: 'Record a transaction now to keep track of your daily sales and expenses.', recordRoute: AddSalesOrExpenses(), recordText: 'Transactions',)
            ],
          ),
        ),
      ),
    );
  }
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 4,
      width: currentIndex == index ? 18 : 5,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? fagoSecondaryColor
            : fagoSecondaryColorWithOpacity,
      ),
    );
  }
}
