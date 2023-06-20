import 'package:auto_size_text/auto_size_text.dart';
import 'package:fagopay/functions/constant.dart';
import 'package:fagopay/models/business_expenses_history_response_model.dart';
import 'package:collection/collection.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_client.dart';
import 'package:fagopay/service/network_services/dio_service_config/dio_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../controllers/expenses_controller.dart';
import 'package:dio/dio.dart' as dio;
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
  // final _salesController = Get.find<SalesController>();
  // final _expenseController = Get.find<ExpensesController>();
  final _companyController = Get.find<CompanyController>();

  List salesFilter = [
    {'type': 'All', 'value': ""},
    {'type': 'Paid', 'value': '2'},
    {'type': 'Part Paid', 'value': '1'},
    {'type': 'Not Poad', 'value': '3'},
  ];

  List expensesFilter = [
    {'type': 'All', 'value': ""},
    {'type': 'Food and Drinks', 'value': '7'},
    {'type': 'Vacation', 'value': '30'},
    {'type': 'Bank charges', 'value': '3'},
  ];

  String selectedFilter = '';
  int currentIndex = 0;
  late final PageController _controller = PageController(viewportFraction: 0.5);
  late bool inflowTab = true;
  late bool recordFound = true;

  @override
  void didChangeDependencies() {
    getSalesAndExpensesHistory();
    super.didChangeDependencies();
  }
  void filterExpenses(String value) {
    businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?.where((expense) => expense.category == value).toList();
    setState(() {});
  }

  ExpensesList? findExpenseById(String id) {
    return businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?.firstWhere((expense) => expense.id == id);
  }

  BusinessSalesExpensesHistoryResponse? businessExpensesHistoryResponse;
  bool? isLoadingExpenses;
  bool? isLoadingExpensesHasError;

  Future<dio.Response<dynamic>?> getBusinessExpensesHistory({required String companyId})async{
    isLoadingExpenses = true;
    isLoadingExpensesHasError = false;
    setState(() {});
    try{
      final response = await NetworkProvider().call(path: "/v1/business_sales_expenses/$companyId", method: RequestMethod.get);
      businessExpensesHistoryResponse = BusinessSalesExpensesHistoryResponse.fromJson(response?.data);
      isLoadingExpenses = false;
      isLoadingExpensesHasError = false;
      setState(() {});
      return response;
    }on dio.DioError catch (err) {
      isLoadingExpenses = false;
      isLoadingExpensesHasError = true;
      setState(() {});
      final errorMessage = Future.error(ApiError.fromDio(err));
      Get.snackbar('Error', err.response?.data['data']['error'] ?? errorMessage.toString());
      throw errorMessage;
    } catch (err) {
      isLoadingExpenses = false;
      isLoadingExpensesHasError = true;
      setState(() {});
      Get.snackbar('Something Went Wrong',err.toString());
      throw err.toString();
    }
  }


  void filterSales(String value) {
    businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?.where((sale) => sale.paymentStatus == value).toList();
    setState(() {});
  }

  Future<void> getSalesAndExpensesHistory() async {
    // await getBusinessSales(companyId: _companyController.company!.id!);
    await getBusinessExpensesHistory(companyId: _companyController.company!.id!);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BookKeepingModel> bookKeepingContent = [
      BookKeepingModel(
        accountType: "Total Amount",
        description: "Income",
        balance: businessExpensesHistoryResponse?.data?.salesExpenses?.totalInflow?.toString() ?? "",
        imagePath: "assets/images/inflow.svg",
      ),
      BookKeepingModel(
        accountType: "Total Spent",
        description: "Expenses",
        balance: businessExpensesHistoryResponse?.data?.salesExpenses?.totalOutflow?.toString() ?? "",
        imagePath: "assets/images/outflow.svg",
      ),
      BookKeepingModel(
        accountType: "Total Received",
        description: businessExpensesHistoryResponse?.data == null ? "" "#0.0, retrieved" :
    "${businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.where((element) => element.paymentStatus == "2").toList().map((e) => double.parse(e.amountPaid.toString())).reduce((a, b) => a+b)}  retrieved",
        balance: businessExpensesHistoryResponse?.data == null ? "0.0" :
        "${businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.where((element) => element.paymentStatus == "2").toList().map((e) => double.parse(e.amountPaid.toString())).reduce((a, b) => a+b)}",
        imagePath: "assets/images/total_credit.svg",
      ),
      BookKeepingModel(
        accountType: "Customers Debt",
        description: "Customer’s Debt",
        balance: businessExpensesHistoryResponse?.data == null ? "0.0" : "${businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.map((e) => num.parse(e.salesAmount!)).toList().sumBy((element) => element) -
            businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.map((e) => num.parse(e.amountPaid!)).toList().sumBy((element) => element)}",
        imagePath: "assets/images/total_debit.svg",
      ),
    ];
    return Scaffold(
      backgroundColor: white,
      body: businessExpensesHistoryResponse == null &&
          isLoadingExpenses == true &&
          isLoadingExpensesHasError == false ?
      Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: MediaQuery.of(context).size.height/2.5,),
            const CupertinoActivityIndicator(color: fagoSecondaryColor,),
            const SizedBox(height: 15,),
            Text("Please wait", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),),
            // SizedBox(height: MediaQuery.of(context).size.height/2.5,),
          ],
        ),
      ) :SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: ()async{
            await getSalesAndExpensesHistory();
          },
          child:  Padding(
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
                                                // Text(Constant().formatCurrency.format(double.parse(bookKeepingContent[i].balance.toString())),
                                                //   style: TextStyle(
                                                //       fontFamily: "Work Sans",
                                                //       fontSize: 18,
                                                //       color: (i == 1 ||
                                                //           i ==
                                                //               (bookKeepingContent
                                                //                   .length -
                                                //                   1))
                                                //           ? fagoSecondaryColor
                                                //           : inactiveTab,
                                                //       fontWeight:
                                                //       FontWeight.w700)
                                                // ),
                                                AutoSizeText(
                                                  "$currencySymbol${double.parse(bookKeepingContent[i].balance.toString())}",
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
                            selectedFilter = "";
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
                            selectedFilter = "";
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
                                        inflowTab
                                            ? filterSales(value)
                                            : filterExpenses('');
                                      } else {
                                        selectedFilter = "";
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
                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(color: businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.isEmpty ? Colors.transparent : fagoSecondaryColorWithOpacity10),
                    child: businessExpensesHistoryResponse!.data!.salesExpenses!.salesList!.isEmpty
                        ? const NoRecordFound(
                      recordDescription: 'Record a Sales now to keep track of your daily sales and expenses.',
                      recordRoute: AddSalesOrExpenses(),
                      recordText: 'Transactions',
                    )
                        : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: inflowTab
                          ? businessExpensesHistoryResponse?.data?.salesExpenses?.salesList!.length
                          : businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList!.length,
                      itemBuilder: (context, index) => inflowTab
                          ? CustomSaleHistoryCard(
                        customerName: businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index].customerName ?? "",
                        salesDescription: businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index].salesDescription ?? "",
                        salesStatus: businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index].paymentStatus ==
                            '2'
                            ? 'Fully Paid'
                            : businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index]
                            .paymentStatus ==
                            '1'
                            ? 'Part Paid'
                            : 'Not Paid',
                        salesAmount: businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index].salesAmount ?? "",
                        salesDate: Jiffy.parse(businessExpensesHistoryResponse?.data?.salesExpenses?.salesList?[index].salesDate?.toString() ?? DateTime.now().toString())
                            .format(pattern: 'dd MMM yyyy'),
                      )
                          : SupplierExpenseHistoryCard(
                        supplierName: businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].supplier !=
                            null
                            ? businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList![index].supplier?.name ?? ""
                            : businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].reason ?? "",
                        note: businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].note ?? "",
                        expenseDate: Jiffy.parse(businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].expenseDate.toString() ?? DateTime.now().toString())
                            .format(pattern: 'dd MMM yyyy'), categoryName: businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].category ?? "",
                        amount: businessExpensesHistoryResponse?.data?.salesExpenses?.expensesList?[index].amount ?? "0.0",
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

  // Future<void> getBusinessSales() async {
  //   final companyId = _companyController.company!.id!;
  //   final response = await _salesController.getBusinessSales(companyId);
  //   final resBody = response['data']['sales_list'];
  //   final returnedSalesList =
  //       resBody.map<Sales>((sale) => Sales.fromJson(sale)).toList();
  //   setState(() {
  //     _salesController.sales = returnedSalesList;
  //   });
  // }

  // Future<void> getBusinessExpenses() async {
  //   final companyId = _companyController.company!.id!;
  //   final response = await _expenseController.getBusinessExpensesHistory(companyId: _companyController.company!.id!);
  //   final resBody = response['data']['expenses_list'];
  //   final returnedExpensesList =
  //       resBody.map<Expenses>((expense) => Expenses.fromJson(expense)).toList();
  //   setState(() {
  //     _expenseController.expenses = returnedExpensesList;
  //   });
  // }
}


extension ListUtils<T> on List<T> {
  num sumBy(num f(T element)) {
    num sum = 0;
    for(var item in this) {
      sum += f(item);
    }
    return sum;
  }
}
