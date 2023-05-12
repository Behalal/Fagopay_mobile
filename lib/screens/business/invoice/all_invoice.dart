import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../book_keeping/models/model.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../home/models/sales.model.dart';
import '../widgets/no_record.dart';
import 'add_invoice.dart';
import 'invoice_details.dart';

class AllInvoice extends StatefulWidget {
  const AllInvoice({super.key});

  @override
  State<AllInvoice> createState() => _AllInvoiceState();
}

class _AllInvoiceState extends State<AllInvoice> {
  bool allTab = true;
  bool unPaidTab = false;
  bool partPaidTab = false;
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
                pageName: "Invoice",
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
                      goToPage(context, const AddInvoice());
                    },
                    child: SizedBox(
                      width: 45.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
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
                            SvgPicture.asset(
                              "assets/images/stickynote.svg",
                              color: white,
                            ),
                            const AutoSizeText(
                              "New Invoice",
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
                height: 12.h,
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
                      return SizedBox(
                        width: 43.w,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // goToPage(context, const AllSales());
                              },
                              child: SizedBox(
                                width: 43.w,
                                child: Card(
                                  elevation: 1.5,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(bookKeepingContent[i].imagePath),
                                        SizedBox(width: 1.w),
                                        SvgPicture.asset(
                                                "assets/images/Line.svg"),
                                        SizedBox(width: 1.w),
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
                              ),
                            ),
                            SizedBox(
                              width: 1.5.w,
                            )
                          ],
                        ),
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
                        allTab = true;
                        partPaidTab = false;
                        unPaidTab = false;
                      });
                    },
                    child: Container(
                      width: 20.5.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (allTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: AutoSizeText(
                          "All",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: (allTab) ? fagoSecondaryColor : inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        allTab = false;
                        partPaidTab = false;
                        unPaidTab = true;
                      });
                    }),
                    child: Container(
                      width: 20.5.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (unPaidTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: AutoSizeText(
                          "Unpaid",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color:
                                (unPaidTab) ? fagoSecondaryColor : inactiveTab,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      setState(() {
                        allTab = false;
                        partPaidTab = true;
                        unPaidTab = false;
                      });
                    }),
                    child: Container(
                      width: 20.5.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 0.5,
                              color: (partPaidTab)
                                  ? fagoSecondaryColor
                                  : Colors.transparent),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: AutoSizeText(
                          "Part Paid",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Work Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: (partPaidTab)
                                ? fagoSecondaryColor
                                : inactiveTab,
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
              SizedBox(
                height: 2.h,
              ),
              // Record Found
              if (recordFound)
                Container(
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  decoration: const BoxDecoration(
                      color: Colors.transparent),
                  child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        // if (allTab) ...[
                          for (var i = 0; i < 7; i++) ...[
                            SizedBox(
                              height: 1.h,
                            ),
                            InkWell(
                              onTap: () => goToPage(context, const InvoiceDetails()),
                              child: SizedBox(
                                width: 90.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.start,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 3.w,
                                                backgroundColor: fagoSecondaryColorWithOpacity10,
                                                child: SvgPicture.asset(
                                                    "assets/images/stickynote.svg",
                                                    color: ( i == 0 || i == 6)? inactiveTabWithOpacity30 : null,
                                                    ),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: 50.w,
                                                      child: AutoSizeText(
                                                        "Halal Payment Limited",
                                                        style: TextStyle(
                                                            fontFamily: "Work Sans",
                                                            fontSize: 14,
                                                            color: ( i == 0 || i == 6)? inactiveTabWithOpacity30 :inactiveTab,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                    ),
                                                    SizedBox(height: 1.h,),
                                                    SizedBox(
                                                      width: 50.w,
                                                      child: AutoSizeText(
                                                        "Date Paid: 24 Mar 2023 ",
                                                        style: TextStyle(
                                                            fontFamily: "Work Sans",
                                                            fontSize: 12,
                                                            color: ( i == 0 || i == 6)? inactiveTabWithOpacity30 :inactiveTab,
                                                            fontWeight:
                                                                FontWeight.w500),
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
                                    if ( i == 0 || i == 6) SizedBox(width: 10.w ,child: Image.asset("assets/images/paidBanner.png", height: 6.h,)),
                                    if ( i != 0 && i != 6) SizedBox(width: 10.w),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        AutoSizeText(
                                          "$currencySymbol 20,000",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: "Work Sans",
                                              fontSize: 12,
                                              color: ( i == 0 || i == 6)? fagoGreenColorWithOpacity17 : fagoSecondaryColor,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: .5.h),
                                          decoration: BoxDecoration(
                                              color: ( i == 0 || i == 6)? fagoGreenColorWithOpacity17 : fagoSecondaryColorWithOpacity10,
                                              borderRadius: const BorderRadius.all(
                                                  Radius.circular(25),),),
                                          child: AutoSizeText(
                                            (i == 0 || i == 6)? "Paid" :"Unpaid",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Work Sans",
                                                fontSize: 8,
                                                color: ( i == 0 || i == 6)? inactiveTabWithOpacity30 : fagoGreenColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.h,),
                            if (i != 6) ...[
                              Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Container(
                                  height: 0.2,
                                  decoration: const BoxDecoration(
                                    color: fagoBlackColorWithOpacity20
                                  ),
                                ),
                              ),
                            ],
                          ],
                        // ],
                      ]),
                ),
              // No record Found
              if (!recordFound)
                const NoRecordFound(
                  recordDescription:
                      'Create invoice now and share to your customers to get paid easily.',
                  recordRoute: AddInvoice(),
                  recordText: 'Invoice',
                )
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
