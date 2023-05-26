import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../controllers/expenses_controller.dart';
import '../../../models/expenses_model.dart';
import 'components/custom_expense_history_card.dart';
import '../../../controllers/company_controller.dart';
import '../../../controllers/sales_controller.dart';
import '../../../models/sales_model.dart';
import 'components/custom_sale_history_card.dart';
import '../../functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
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
  final _salesController = Get.find<SalesController>();
  final _companyController = Get.find<CompanyController>();
  final _expenseController = Get.find<ExpensesController>();

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
  late bool inflowTab = true;
  late bool recordFound = true;

  @override
  void didChangeDependencies() {
    getBusinessSales();
    getBusinessExpenses();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: getBusinessSales,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
            child: Obx(
              () => Column(
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
                          goToPage(context, const AddSalesOrExpenses());
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
                                SvgPicture.asset(
                                  "assets/images/archive-book.svg",
                                  color: white,
                                  height: 2.h,
                                  width: 2.w,
                                ),
                                const Expanded(
                                  child: AutoSizeText(
                                    "New Transaction",
                                    style: TextStyle(
                                      fontFamily: "Work Sans",
                                      fontSize: 5,
                                      fontWeight: FontWeight.w600,
                                      color: white,
                                    ),
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
                                  // child: Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 2.w, vertical: 1.h),
                                  //   decoration: const BoxDecoration(
                                  //       color: white,
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(5)),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: blackWithOpacity,
                                  //           offset: Offset.zero,
                                  //           spreadRadius: 1,
                                  //           blurRadius: 3,
                                  //         ),
                                  //       ]),
                                  child: SizedBox(
                                    width: 43.w,
                                    child: Card(
                                      elevation: 1.5,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 1.w, vertical: 1.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                bookKeepingContent[i]
                                                    .imagePath),
                                            SizedBox(width: 1.w),
                                            // Container(
                                            //   height: 53,
                                            //   decoration: DottedDecoration(
                                            //       color: blackWithOpacity5,
                                            //       // dash: const [1, 1, 1],
                                            //       linePosition: LinePosition.right),
                                            // ),
                                            SvgPicture.asset(
                                                "assets/images/Line.svg"),
                                            SizedBox(width: 2.w),
                                            SizedBox(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    bookKeepingContent[i]
                                                        .accountType,
                                                    style: const TextStyle(
                                                      fontFamily: "Work Sans",
                                                      fontSize: 12,
                                                      color: inactiveTab,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  SizedBox(height: 1.h),
                                                  AutoSizeText(
                                                    bookKeepingContent[i]
                                                        .description,
                                                    style: TextStyle(
                                                        fontFamily: "Work Sans",
                                                        fontSize: 10,
                                                        color: (i == 2)
                                                            ? fagoGreenColor
                                                            : inactiveTabWithOpacity30,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
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
                    height: 1.5.h,
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
                                color: (inflowTab)
                                    ? fagoSecondaryColor
                                    : inactiveTab,
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
                                color: (!inflowTab)
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
                  if (recordFound) ...[
                    Container(
                      height: 38.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                          color: _salesController.sales.isEmpty
                              ? Colors.transparent
                              : fagoSecondaryColorWithOpacity10),
                      child: _salesController.sales.isEmpty
                          ? const NoRecordFound(
                              recordDescription:
                                  'Record a Sales now to keep track of your daily sales and expenses.',
                              recordRoute: AddSalesOrExpenses(),
                              recordText: 'Transactions',
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: inflowTab
                                  ? _salesController.sales.length
                                  : _expenseController.expenses.length,
                              itemBuilder: (context, index) => inflowTab
                                  ? CustomSaleHistoryCard(
                                      customerName: _salesController
                                          .sales[index].customerName!,
                                      salesDescription: _salesController
                                          .sales[index].salesDescription!,
                                      salesStatus: _salesController
                                                  .sales[index].paymentStatus ==
                                              '2'
                                          ? 'Fully Paid'
                                          : _salesController.sales[index]
                                                      .paymentStatus ==
                                                  '1'
                                              ? 'Part Paid'
                                              : 'Not Paid',
                                      salesAmount: _salesController
                                          .sales[index].salesAmount!,
                                      salesDate: Jiffy.parse(_salesController
                                              .sales[index].salesDate!)
                                          .format(pattern: 'dd MMM yyyy'),
                                    )
                                  : SupplierExpenseHistoryCard(
                                      supplierName: _expenseController
                                                  .expenses[index].supplier !=
                                              null
                                          ? _expenseController
                                              .expenses[index].supplier!.name!
                                          : _expenseController
                                              .expenses[index].reason!,
                                      note: _expenseController
                                          .expenses[index].note!,
                                      expenseDate: Jiffy.parse(
                                              _expenseController
                                                  .expenses[index].expenseDate!)
                                          .format(pattern: 'dd MMM yyyy'),
                                    ),
                            ),
                    ),
                  ] else ...[
                    // No Record Found
                    const NoRecordFound(
                      recordDescription:
                          'Record a transaction now to keep track of your daily sales and expenses.',
                      recordRoute: AddSalesOrExpenses(),
                      recordText: 'Transactions',
                    ),
                  ],
                ],
              ),
            ),
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

  Future<void> getBusinessSales() async {
    final companyId = _companyController.company!.id!;
    final response = await _salesController.getBusinessSales(companyId);
    final resBody = response['data']['sales_list'];
    final returnedSalesList =
        resBody.map<Sales>((sale) => Sales.fromJson(sale)).toList();
    setState(() {
      _salesController.sales = returnedSalesList;
    });
  }

  Future<void> getBusinessExpenses() async {
    final companyId = _companyController.company!.id!;
    final response = await _expenseController.getBusinessExpenses(companyId);
    final resBody = response['data']['expenses_list'];
    final returnedExpensesList =
        resBody.map<Expenses>((expense) => Expenses.fromJson(expense)).toList();
    setState(() {
      _expenseController.expenses = returnedExpensesList;
    });
  }
}
