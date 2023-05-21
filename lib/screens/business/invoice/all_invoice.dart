// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:fagopay/models/invoice_model.dart';
import 'package:fagopay/screens/business/invoice/components/custom_invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sizer/sizer.dart';

import 'package:fagopay/controllers/company_controller.dart';
import 'package:fagopay/controllers/invoice_controller.dart';

import '../../constants/colors.dart';
import '../../constants/currency.dart';
import '../../functions.dart';
import '../../widgets/head_style_extra_pages.dart';
import '../book_keeping/models/model.dart';
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
  final _invoiceController = Get.find<InvoiceController>();
  final _companyController = Get.find<CompanyController>();
  List loadedInvoices = [];

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
  void initState() {
    getBusinessInvoices();
    super.initState();
  }

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
                          horizontal: 7.w,
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
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: _invoiceController.invoices.isEmpty ||
                          loadedInvoices.isEmpty
                      ? const Center(
                          child: AutoSizeText('No Invoice yet'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _invoiceController.invoices.length,
                          itemBuilder: (context, index) => CustomInvoiceCard(
                            customerName: loadedInvoices[index]['customer']
                                ['fullname'],
                            date: Jiffy.parse(_invoiceController
                                    .invoices[index].createdAt!)
                                .format(pattern: 'dd MMM yyyy'),
                            total: _invoiceController.invoices[index].total!,
                            status: _invoiceController.invoices[index].status!,
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const InvoiceDetails(),
                                settings: RouteSettings(
                                  arguments:
                                      _invoiceController.invoices[index].id!,
                                ),
                              ),
                            ),
                          ),
                        ),
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

  Future<void> getBusinessInvoices() async {
    final companyId = _companyController.company!.id!;
    final response = await _invoiceController.getInvoices(companyId);
    final resBody = response['data']['Invoice_List'];
    final returnedInvoiceList = resBody.map((invoice) => invoice).toList();
    final returnedInvoices =
        resBody.map<Invoice>((invoic) => Invoice.fromJson(invoic)).toList();
    setState(() {
      _invoiceController.invoices = returnedInvoices;
      loadedInvoices = returnedInvoiceList;
    });
  }
}
